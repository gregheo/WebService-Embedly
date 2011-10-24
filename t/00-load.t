#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'WebService::Embedly' ) || print "Bail out!\n";
}

diag( "Testing WebService::Embedly $WebService::Embedly::VERSION, Perl $], $^X" );
