package Geo::Coder::All::Google;
use Modern::Perl;
use Moose;
use namespace::autoclean;
use Carp;
use URI::Escape;
use JSON::XS;
use Locale::Codes::Country;
use Data::Dumper;
use Geo::Coder::Google;
with 'Geo::Coder::Role::Geocode';
has 'GOOGLE' =>(
    is => 'rw',
    isa => 'Object',
    writer => 'set_google_geocoder'
);
sub geocode_local {
    my ($self,$rh_args)= @_;
    croak "Location string needed" unless ($rh_args->{location});
    my $rh_data;
    $self->set_google_geocoder(Geo::Coder::Google->new(
        language    => $rh_args->{language},
        apiver      => 3,
        #TODO: findout why v2 does not work
        #($rh_args->{google_apiver} ? (apiver => $rh_args->{google_apiver}): () ),
    ));
    my $rh_response = $self->GOOGLE->geocode(location => $rh_args->{location});
    print STDERR Dumper($rh_response) if($rh_args->{DEBUG});
    $rh_data->{geocoder}        = 'Google';
    $rh_data->{address}         = $rh_response->{formatted_address} ;
    @{$rh_data->{coordinates}}{qw/lat lon/}     = @{$rh_response->{geometry}{location}}{qw/lat lng/} ;
    foreach my $component (@{$rh_response->{address_components}}){
        if($component->{types}->[0] =~ /country/){
            $rh_data->{country_code} = $component->{short_name};
            $rh_data->{country} = $component->{long_name};
            $rh_data->{country_code_alpha_3} = uc(country2code(code2country($rh_data->{country_code}),'alpha-3')) if($component->{short_name});
        }
    }
    return $rh_data;
}
__PACKAGE__->meta->make_immutable;
1;
