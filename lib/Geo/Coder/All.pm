package Geo::Coder::All;
use Moose;
use Geo::Coder::All::Google;
use Geo::Coder::All::OSM;
use Geo::Coder::All::TomTom;
use Geo::Coder::All::Ovi;
use Geo::Coder::All::Bing;
use URI::Escape;
use Data::Dumper;
my %VALID_GEOCODER_LIST = map { $_ => 1} qw(
    Google
    OSM
    TomTom
    Ovi
    Bing
);
has 'geocoder'              => (is=>'rw',isa=>'Str',default=>'Google');
has 'key'                   => (is=>'rw',isa=>'Str',default=>'',    reader=>'get_key');
has 'langauge'              => (is=>'rw',isa=>'Str',default=>'en',  reader=>'get_language',             init_arg=>'language');
has 'google_client'         => (is=>'rw',isa=>'Str',default=>'',    reader=>'get_google_client',        init_arg=>'client');
has 'google_apiver'         => (is=>'rw',isa=>'Num',default=>3,     reader=>'get_google_apiver',        init_arg=>'apiver');
has 'google_encoding'       => (is=>'rw',isa=>'Str',default=>'utf8',reader=>'get_google_encoding',      init_arg=>'encoding');
has 'google_country_code'   => (is=>'rw',isa=>'Str',default=>'',    reader=>'get_google_country_code',  init_arg=>'country_code');
has 'google_sensor'         => (is=>'rw',isa=>'Str',default=>'',    reader=>'get_google_sensor',        init_arg=>'sensor');

has 'geocoder_engine' => (
    is  => 'rw',
    init_arg => undef,
    lazy => 1,
    isa => 'Object',
    builder => '_build_geocoder_engine',
    handles =>{
        geocode         => 'geocode_local',
        reverse_geocode => 'reverse_geocode_local'
        } 
    );

sub _build_geocoder_engine {
    my $self        = shift;
    my $geocoder    = $self->geocoder;
    
    unless($VALID_GEOCODER_LIST{$geocoder}){
        $geocoder = 'Google';
        $self->geocoder('Google');
    }
    
    my $class = 'Geo::Coder::All::'.$geocoder;
    return $class->new(); 
}

around 'geocode' => sub{
    my ($orig,$class,$rh_args) =  @_;
    return $class->$orig($class->_process_args($rh_args));
};

around 'reverse_geocode' => sub{
    my ($orig,$class,$rh_args) =  @_;
    return $class->$orig($class->_process_args($rh_args));
};
#process the args passed to create new Geo::Coder::Google
sub _process_args {
    my ($self,$rh_args) =@_;
    $rh_args->{key}= $self->get_key if($self->get_key);
    $rh_args->{language}= $self->get_language if($self->get_language);
    $rh_args->{google_apiver}= $self->get_google_apiver || $rh_args->{apiver} if($self->geocoder eq 'Gooole');
    $rh_args->{google_client}= $self->get_google_client || $rh_args->{client} if($self->geocoder eq 'Google');
    $rh_args->{google_encoding}= $self->get_google_encoding || $rh_args->{encoding} if($self->geocoder eq 'Google');
    $rh_args->{google_country_code}= $self->get_google_country_code || $rh_args->{country_code} if($self->geocoder eq 'Google');
    return $rh_args;
}

=head1 NAME

Geo::Coder::All - The great new Geo::Coder::All!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Geo::Coder::All;
    #For google geocoder
    my $google_geocoder = Geo::Coder::All->new();#geocoder defaults to Google
    my $google_geocoder = Geo::Coder::All->new( geocoder=>'Google',apiver=>3);
    

=head1 METHODS

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=over 2

=item geocode

geocode method
for google geocoder
    $geocoder = Geo::Coder::All->new( geocoder=>'Google',apiver=>3);

=item reverse_geocode

reverse_geocode method

=cut

=back

=head1 AUTHOR

Rohit Deshmukh, C<< <raigad1630 at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-geo-coder-all at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Geo-Coder-All>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Geo::Coder::All


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Geo-Coder-All>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Geo-Coder-All>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Geo-Coder-All>

=item * Search CPAN

L<http://search.cpan.org/dist/Geo-Coder-All/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2014 Rohit Deshmukh.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

1; # End of Geo::Coder::All
