package Geo::Coder::All::TomTom;
use Moose;
use namespace::autoclean;
use Geo::Coder::TomTom;
use Carp;
use Data::Dumper;
with 'Geo::Coder::Role::Geocode';

has 'TomTom' => (
    is      =>  'ro',
    isa     =>  'Geo::Coder::TomTom',
    default => sub{ Geo::Coder::TomTom->new();}
);

sub geocode_local {
    my ($self,$rh_args) = @_;
    croak "Location string required" unless ($rh_args->{location});
    my $rh_data;
    my $rh_response = $self->TomTom->geocode(location => $rh_args->{location} );
    print STDERR Dumper($rh_response) if($rh_args->{DEBUG});
    $rh_data->{geocoder} = 'TomTom';  
    $rh_data->{address} = $rh_response->{formattedAddress};  
    $rh_data->{country} = $rh_response->{country};
    #TODO: get country code using Locale::Codes module
    $rh_data->{country_code} = undef;
    $rh_data->{coordinates}{lat} = $rh_response->{latitude};  
    $rh_data->{coordinates}{lon} = $rh_response->{longitude};  
    return $rh_data;
}
__PACKAGE__->meta->make_immutable;
1;
