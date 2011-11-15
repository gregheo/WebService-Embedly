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

Examples
--------

Simple:

    my $e = new WebService::Embedly(key => "api key goes here");
    my $r = $e->oembed("http://vimeo.com/18150336");
    print "Video title is: ", $r->[0]->{'title'}, "\n";

Multiple URLs are simple too!

    $r = $e->oembed(["http://vimeo.com/18150336", "http://www.youtube.com/watch?v=dQw4w9WgXcQ"]);

Need to provide options?

    $r = $e->oembed({ url => "http://www.youtube.com/watch?v=dQw4w9WgXcQ",
                      maxwidth => 480 });

The return value is an array reference, with one array element for each URL
passed in.

Endpoints
---------

The `oembed`, `preview`, and `objectify` endpoints are supported.


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

Partly funded by the fine folks at [The Tyee](http://www.thetyee.ca). Thanks
to the Embed.ly folks for providing a full-access dev account too!

Copyright (c) 2011, Greg Heo (<greg@node79.com>).
Released under the MIT license (see MIT-LICENSE).

