#!perl -T
use strict;
use warnings;
use Test::More;
use Geo::Coder::All;
if($ENV{BING_API_KEY}){
    plan tests => 8;
}else{
    plan skip_all => "No Bing Api key provided skipping tests for Bing Geocoder,SET ENV variable BING_API_KEY=key";
    exit;
}
{
my $geocoder = Geo::Coder::All->new(geocoder=>'Bing',key=>$ENV{BING_API_KEY});
my $location =$geocoder->geocode({location=> 'Anfield,Liverpool'});
isa_ok($geocoder->geocoder_engine->Bing,'Geo::Coder::Bing');
is($location->{geocoder},'Bing','checking geocoder');
is($location->{country},'United Kingdom','checking country');
is($location->{country_code},'GB','checking country code');
is($location->{country_code_alpha_3},'GBR','checking country code alpha3');
like($location->{address},qr/Anfield(.*)Liverpool/,'checking address');
like($location->{coordinates}{lat},qr/53.4/,'checking latitude');
like($location->{coordinates}{lon},qr/-2.9/,'checking longitude');
}



