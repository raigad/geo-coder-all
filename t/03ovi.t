#!perl -T
use strict;
use warnings;
use Test::More;
use Geo::Coder::All;
use Data::Dumper;
plan tests => 8;
{
my $geocoder = Geo::Coder::All->new(geocoder =>'Ovi');
my $location =$geocoder->geocode({location=> 'Anfield,Liverpool'});
isa_ok($geocoder->geocoder_engine->Ovi,'Geo::Coder::Ovi');
is($location->{geocoder},'Ovi','checking geocoder');
is($location->{country},'United Kingdom','checking country');
is($location->{country_code},'GB','checking country code ');
is($location->{country_code_alpha_3},'GBR','checking country code alpha3');
like($location->{address},qr/Anfield(.*)Liverpool/,'checking address');
like($location->{coordinates}{lat},qr/53.4/,'checking latitude');
like($location->{coordinates}{lon},qr/-2.9/,'checking longitude');
}



