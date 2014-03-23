package Geo::Coder::All::OSM;
use Modern::Perl;
use Moose;
use namespace::autoclean;
use Carp;
use Geo::Coder::OSM;
use Data::Dumper;
with 'Geo::Coder::Role::Geocode';
has 'OSM' => (
    is      =>  'ro',
    isa     =>  'Geo::Coder::OSM',
    default => sub { Geo::Coder::OSM->new();},
);

sub geocode_local{
    my ($self,$rh_args) = @_;
    croak "Location String needed" unless ($rh_args->{location});    
    my $rh_response = $self->OSM->geocode(location => $rh_args->{location});
    my $rh_data;
    $rh_data->{geocoder}        = 'OSM';
    $rh_data->{address}         = $rh_response->{display_name};
    $rh_data->{coordinates}{lat}= $rh_response->{lat};
    $rh_data->{coordinates}{lon}= $rh_response->{lon};
    $rh_data->{country}         = $rh_response->{address}{country};
    $rh_data->{country_code}    = uc($rh_response->{address}{country_code});
    return $rh_data;
}
__PACKAGE__->meta->make_immutable;
1;
