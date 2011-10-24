package WebService::Embedly;

use 5.006;
use strict;
use warnings;

use Carp;
use URI;
use URI::Escape;
use LWP::UserAgent;
use JSON;

our @ISA = qw(LWP::UserAgent);

our $VERSION = '1.00';

=head1 NAME

WebService::Embedly - Perl interface to the Embed.ly API

=head1 VERSION

Version 1.00

=cut

=head1 SYNOPSIS

    use WebService::Embedly;

    my $api = new WebService::Embedly;
    my $embed_data = $api->oembed(url => "http://vimeo.com/18150336");

    print "Video title: ", $embed_data->{'title'}, "\n";

=head1 DESCRIPTION

This module supports the oembed, preview, and objectify endpoints with
arguments as described here:
L<http://embed.ly/docs/endpoints>

As a shortcut, if you have no arguments other than URL(s), you can skip the
hash syntax and do something like:

    $embed_data = $api->oembed("http://vimeo.com/18150336");

    $embed_data = $api->oembed(["http://example.com/1", "http://example.com/2", ...]);

=head2 AUTHENTICATION

Key-based authentication is supported. You can either pass in your key once
to the constructor (recommended) or on each request.

    my $api = new WebService::Embedly(key => 'api key goes here');

=head2 MULTIPLE URLs

Embed.ly supports queries on multiple URLs with the C<urls> argument. Just
pass in an array reference and this module will do the rest.

    my $request = $api->oembed(urls => [ "http://...url1...",
                                         "http://...url2...",
                                         "http://...url3..." ]);

=cut

sub new
{
    my $class = shift;
    my $options = ref $_[0] ? $_[0] : {@_};

    my $self = new LWP::UserAgent;

    $self->{'api_url'} = $options->{'api_url'} || "http://api.embed.ly";
    $self->{'api_version'} = $options->{'api_version'} || 1;
    $self->{'key'} = $options->{'key'};

    bless $self, $class;
    return $self;
}

sub _execute
{
    my $self = shift;
    my $method = shift;
    my $args = ref $_[0] eq 'HASH'  ? $_[0] : 
               ref $_[0] eq 'ARRAY' ? {urls => $_[0]} :
               scalar @_ == 1       ? {url => $_[0]} :
                                      {@_};

    my $uri = new URI($self->{'api_url'} . "/" .
                      ($args->{'api_version'} || $self->{'api_version'}).
                      "/$method");
    $args->{'key'} = $self->{'key'} if ($self->{'key'});

    # always handle as multiple URLs
    my $urls_string = $self->_make_urls_string(@{$args->{'urls'}}, $args->{'url'});

    delete $args->{'url'};
    delete $args->{'urls'};

    $uri->query_form($args);
    $uri->query(($uri->query ? $uri->query."&" : "") . $urls_string);

    my $response = $self->get($uri);
    my $json;
    eval {
        $json = decode_json $response->content;
    };
    if ($@) {
        carp "JSON decode error: $@";
        return {"error" => $@, "error_response" => $response->content};
    }
    return $json;
}

sub _make_urls_string
{
    my $self = shift;
    my @urls;
    foreach (@_) {
        push @urls, $_ if $_;
    }
    return "urls=".join(",", map {uri_escape($_);} @urls);
}


sub AUTOLOAD
{
    our $AUTOLOAD;
    my $self = shift;

    (my $method = $AUTOLOAD) =~ s/.*:://s;
    if ($method =~ m/(oembed|preview|objectify)/) {
        return $self->_execute($method, @_);
    } else {
        croak "No such method $AUTOLOAD";
    }
}

sub DESTROY
{
}

1;

__END__

=head1 AUTHOR

Greg Heo, C<< <greg at node79.com> >>

=head1 ACKNOWLEDGEMENTS

Written with one eye on the Embed.ly library for PHP
L<http://github.com/embedly/embedly-php>

Funded by the fine folks at The Tyee
L<http://www.thetyee.ca>

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2011, Greg Heo E<lt>greg@node79.comE<gt>.

This program is distributed under the MIT (X11) license:
L<http://opensource.org/licenses/mit-license.txt>

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

=cut

