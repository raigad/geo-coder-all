package Geo::Coder::All::OSM;
use Modern::Perl;
use Moose;
use namespace::autoclean;
use Carp;
use Geo::Coder::OSM;
with 'Geo::Coder::Role::Geocode';
has 'OSM' => (
    is      =>  'ro',
    isa     =>  'Geo::Coder::OSM',
    default => sub { Geo::Coder::OSM->new();},
);

sub geocode_local{
    my ($self,$rh_args) = @_;
    croak "Adress needed" unless ($rh_args->{address});    
    return $self->OSM->geocode(location => $rh_args->{address}); 
}
__PACKAGE__->meta->make_immutable;
1;
