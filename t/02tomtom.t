#!perl -T
use strict;
use warnings;
use Test::More;
use Geo::Coder::All;
plan tests => 7;
{
my $geocoder = Geo::Coder::All->new(geocoder =>'TomTom');
my $location =$geocoder->geocode({location=> 'Anfield,Liverpool'});
isa_ok($geocoder->geocoder_engine->TomTom,'Geo::Coder::TomTom');
is($location->{country},'United Kingdom','checking country');
is($location->{country_code},'GB','checking country code ');
is($location->{country_code_alpha_3},'GBR','checking country code alpha3');
like($location->{address},qr/Anfield(.*)Liverpool/,'checking address');
like($location->{coordinates}{lat},qr/53.4/,'checking latitude');
like($location->{coordinates}{lon},qr/-2.9/,'checking longitude');
}



