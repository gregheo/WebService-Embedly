#!perl -T

use Test::More tests => 3;
use WebService::Embedly;

my $api = new WebService::Embedly;

is($api->_make_urls_string("http://example.com/18150336"),
   'urls=http%3A%2F%2Fexample.com%2F18150336',
   "one URL");
is($api->_make_urls_string("http://example.com/18150336", "http://example.com/18150338"),
   'urls=http%3A%2F%2Fexample.com%2F18150336,http%3A%2F%2Fexample.com%2F18150338',
   "two URLs");
is($api->_make_urls_string("http://example.com/with,comma", "http://example.com/12345"),
   'urls=http%3A%2F%2Fexample.com%2Fwith%2Ccomma,http%3A%2F%2Fexample.com%2F12345',
   "URL with comma");

