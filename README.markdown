WebService::Embedly -- a Perl interface to Embed.ly services
============================================================

WebService::Embedly is a very simple module for accessing metadata on embedded
content through Embed.ly.

Module dependencies:

* Carp
* JSON
* LWP::UserAgent
* URI
* URI::Escape

Example:

    my $e = new WebService::Embedly;
    my $r = $e->oembed(url => "http://vimeo.com/18150336");
    print "Video title is: ", $r->[0]->{'title'}, "\n";

Installation
------------

To install this module, run the following commands:

	perl Makefile.PL
	make
	make test
	make install

Support
-------

Check out the [GitHub page](http://github.com/gregheo/WebService-Embedly).

Credits
-------

Written with one eye on the [Embed.ly library for PHP](https://github.com/embedly/embedly-php).

Funded by the fine folks at [The Tyee](http://www.thetyee.ca).

Copyright (c) 2011, Greg Heo (<greg@node79.com>).
Released under the MIT license (see MIT-LICENSE).

