geo-coder-all
=============
#VERSION
       Geo::Coder::All - Geo::Coder::All
       Version 0.03

#DESCRIPTION
       Geo::Coder::All is wrapper for other geocoder cpan modules such as
       Geo::Coder::Google,Geo::Coder::Bing,Geo::Coder::Ovi,Geo::Coder::OSM and
       Geo::Coder::TomTom. Geo::Coder::All provides common geocode output
       format for all geocoder.

#SYNOPSIS
           use Geo::Coder::All;
           #For google geocoder
           my $google_geocoder = Geo::Coder::All->new();#geocoder defaults to Geo::Coder::Google::V3
           #You can also use optional params for google api
           my $google_geocoder = Geo::Coder::All->new(key=>'GMAP_KEY',client=>'GMAP_CLIENT');

           #For Bing
           my $bing_geocoder = Geo::Coder::All->new(geocoder=>'Bing',key=>'BING_API_KEY');

           #For Ovi
           my $ovi_geocoder = Geo::Coder::All->new(geocoder=>'Ovi');

           #For OSM
           my $osm_geocoder = Geo::Coder::All->new(geocoder=>'OSM');

           #For TomTom
           my $tomtom_geocoder = Geo::Coder::All->new(geocoder=>'TomTom');
