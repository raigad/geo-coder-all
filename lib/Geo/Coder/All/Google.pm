package Geo::Coder::All::Google;
use Modern::Perl;
use Moose;
use Carp;
use namespace::autoclean;
with 'Geo::Coder::Role::Geocode';
has 'base_api_uri' => (
    is          => 'ro',
    isa         => 'Str',
    init_arg    =>  undef,
    default     => 'http://maps.googleapis.com/maps/api/geocode/json?&sensor=false&address='
);

sub geocode_local {
    my ($self,$rh_args)= @_;
    croak "Adress needed" unless ($rh_args->{address});
    return $self->get($self->base_api_uri.($rh_args->{address}));
}
__PACKAGE__->meta->make_immutable;
1;
