package Geo::Coder::All::Google;
use Modern::Perl;
use Moose;
use namespace::autoclean;
use Carp;
use URI::Escape;
use JSON::XS;
use Data::Dumper;
with 'Geo::Coder::Role::Geocode';
has 'base_api_uri' => (
    is          => 'ro',
    isa         => 'Str',
    init_arg    =>  undef,
    default     => 'http://maps.googleapis.com/maps/api/geocode/json?&sensor=false&address='
);

sub geocode_local {
    my ($self,$rh_args)= @_;
    croak "Location string needed" unless ($rh_args->{location});
    my $rh_data;
    my $rh_response = decode_json($self->get($self->base_api_uri.uri_escape_utf8($rh_args->{location})));
    $rh_data->{geocoder}        = 'Google';
    $rh_data->{address}         = $rh_response->{results}->[0]->{formatted_address} ;
    $rh_data->{coordinates}     = $rh_response->{results}->[0]->{geometry}{location} ;
    foreach my $component (@{$rh_response->{results}->[0]->{address_components}}){
        if($component->{types}->[0] =~ /country/){
            $rh_data->{country_code} = $component->{short_name};
            $rh_data->{country} = $component->{long_name};
        }
    }
    return $rh_data;
}
__PACKAGE__->meta->make_immutable;
1;
