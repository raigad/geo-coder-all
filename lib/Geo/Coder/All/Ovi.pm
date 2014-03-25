package Geo::Coder::All::Ovi;
use Moose;
use namespace::autoclean;
use Carp;
use Geo::Coder::Ovi;
use Locale::Codes::Country;
with 'Geo::Coder::Role::Geocode';

has 'Ovi' =>(
    is  => 'rw',
    isa => 'Geo::Coder::Ovi',
    default => sub {Geo::Coder::Ovi->new();},
);

sub geocode_local {
    my ($self,$rh_args) = @_;
    croak 'Location string required' unless($rh_args->{location});
    my $rh_data;
    my $rh_response = $self->Ovi->geocode( location=> $rh_args->{location});
    $rh_data->{geocoder}                =   $rh_response->{'Ovi'};
    $rh_data->{address}                 =   $rh_response->{properties}{title};
    $rh_data->{country}                 =   $rh_response->{properties}{addrCountryName};
    $rh_data->{country_code}            =   uc(country2code($rh_response->{properties}{addrCountryName}));
    $rh_data->{country_code_alpha_3}    =   $rh_response->{properties}{addrCountryCode};
    $rh_data->{coordinates}{lat}        =   $rh_response->{properties}{geoLatitude};
    $rh_data->{coordinates}{lon}        =   $rh_response->{properties}{geoLongitude};
    return  $rh_data;
}


__PACKAGE__->meta->make_immutable();
1;
