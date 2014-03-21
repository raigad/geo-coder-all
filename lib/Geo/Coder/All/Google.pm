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
    croak "Adress needed" unless ($rh_args->{address});
    my $rh_data;
    my $rh_response = decode_json($self->get($self->base_api_uri.uri_escape_utf8($rh_args->{address})));
    return $rh_response->{results};
}
__PACKAGE__->meta->make_immutable;
1;
