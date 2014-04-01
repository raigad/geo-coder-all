#!perl -T
use strict;
use warnings;
use Test::More;
use Geo::Coder::All;
plan tests => 8;
{
my $geocoder = Geo::Coder::All->new(apiver =>3);
my $location =$geocoder->geocode({location=> 'Anfield'});
isa_ok($geocoder->geocoder_engine->GOOGLE,'Geo::Coder::Google::V3');
is($location->{geocoder},'Google','checking geocoder');
is($location->{country},'United Kingdom','checking country');
is($location->{country_code},'GB','checking country code ');
is($location->{country_code_alpha_3},'GBR','checking country code alpha3');
is($location->{address},'Anfield, Anfield Rd, Liverpool, Merseyside L4 0TH','checking address');
is($location->{coordinates}{lat},'53.4302988','checking latitude');
is($location->{coordinates}{lon},'-2.9616045','checking longitude');
}



