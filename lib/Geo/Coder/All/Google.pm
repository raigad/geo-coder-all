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
        ($rh_args->{key} ? ( key    => $rh_args->{key}):()),
        ($rh_args->{google_client} ? ( client    => $rh_args->{google_client}):()),
        #TODO: findout why v2 does not work
        #($rh_args->{google_apiver} ? (apiver => $rh_args->{google_apiver}): () ),
    ));
    my $rh_response = $self->GOOGLE->geocode(location => $rh_args->{location});
    print STDERR Dumper($rh_response) if($rh_args->{DEBUG});
    return $self->_process_response($rh_response);
}
sub reverse_geocode_local{
    my ($self,$rh_args) = @_;
    croak 'latlng needed to reverse geocode' unless($rh_args->{latlng});
    $self->set_google_geocoder(Geo::Coder::Google->new(
        language    => $rh_args->{language},
        apiver      => 3,
        ($rh_args->{key} ? ( key    => $rh_args->{key}):()),
        ($rh_args->{google_client} ? ( client    => $rh_args->{google_client}):()),
    ));
    my $rh_response = $self->GOOGLE->reverse_geocode(latlng => $rh_args->{latlng});
    print STDERR Dumper($rh_response) if($rh_args->{DEBUG});
    return $self->_process_response($rh_response);
}
#TODO:implement this method as private_method/protected using MooseX::Privacy
sub _process_response {
    my ($self,$rh_response) = @_;
    my $rh_data;
    $rh_data->{geocoder}        = 'Google';
    $rh_data->{address}         = $rh_response->{formatted_address} ;
    @{$rh_data->{coordinates}}{qw/lat lon/}     = @{$rh_response->{geometry}{location}}{qw/lat lng/} ;
    foreach my $component (@{$rh_response->{address_components}}){
        if($component->{types}->[0] =~ /country/){
            $rh_data->{country_code} = $component->{short_name};
            $rh_data->{country} = $component->{long_name};
            $rh_data->{country_code_alpha_3} = uc(country2code(code2country($rh_data->{country_code}),'alpha-3')) if($component->{short_name});
        }
        if($component->{types}[0] =~ /postal_code/){
            $rh_data->{postal_code} = $component->{long_name};    
        }
    }
    return $rh_data;
}
__PACKAGE__->meta->make_immutable;
1;
