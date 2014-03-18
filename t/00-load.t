#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'Geo::Coder::All' ) || print "Bail out!\n";
}

diag( "Testing Geo::Coder::All $Geo::Coder::All::VERSION, Perl $], $^X" );
