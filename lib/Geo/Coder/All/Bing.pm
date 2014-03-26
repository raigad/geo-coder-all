package Geo::Coder::All::Bing;
use Modern::Perl;
use Moose;
use namespace::autoclean;
use Carp;
use URI::Escape;
use JSON::XS;
use Locale::Codes::Country;
use Data::Dumper;
use Geo::Coder::Bing;
with 'Geo::Coder::Role::Geocode';
has 'Bing' =>(
    is => 'rw',
    isa => 'Geo::Coder::Bing',
    writer => 'set_bing_geocoder'
);
sub geocode_local {
    my ($self,$rh_args)= @_;
    croak "API key needed" unless ($rh_args->{api_key});
    croak "Location string needed" unless ($rh_args->{location});
    my $rh_data;
    $self->set_bing_geocoder(Geo::Coder::Bing->new(
        key    => $rh_args->{api_key},
    ));
    my $rh_response = $self->Bing->geocode(location => $rh_args->{location});
    print STDERR Dumper($rh_response) if($rh_args->{DEBUG});
    $rh_data->{geocoder}        = 'Bing';
    $rh_data->{address}         = $rh_response->{address}{formattedAddress} ;
    #$rh_data->{coordinates}{lat}     = $rh_response->{'point'}{'coordinates'} ;
    #foreach my $component (@{$rh_response->{address_components}}){
    #    if($component->{types}->[0] =~ /country/){
    #        $rh_data->{country_code} = $component->{short_name};
    #        $rh_data->{country} = $component->{long_name};
    #        $rh_data->{country_code_alpha_3} = uc(country2code(code2country($rh_data->{country_code}),'alpha-3')) if($component->{short_name});
    #    }
    #}
    return $rh_data;
}
__PACKAGE__->meta->make_immutable;
1;
