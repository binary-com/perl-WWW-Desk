package WWW::Desk::Browser;

use 5.006;
use strict;
use warnings FATAL => 'all';

use Moose;
use LWP::UserAgent;
use URI;
use JSON;

=head1 NAME

WWW::Desk::Browser - Desk.com Browser Client

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 ATTRIBUTES

=head2 base_url

REQUIRED - your desk url

=cut

has 'base_url' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1
);

has 'browser' => (
    is      => 'ro',
    isa     => 'LWP::UserAgent',
    lazy    => 1,
    default => sub {
        my ($self) = @_;
        my $browser = LWP::UserAgent->new;
        $browser->cookie_jar( {} );
        return $browser;
    }
);

has 'json' => (
    is => 'ro',
    isa => 'JSON',
    lazy => 1,
    default => sub {
        my ( $self ) = @_;
        return JSON->new();
    }
);

=head1 SYNOPSIS

    use WWW::Desk::Browser;

    my $browser_client = WWW::Desk::Browser->new();

=head1 SUBROUTINES/METHODS

=head2 prepare_url

Utility method to build base url and fragment

=cut

sub prepare_url {
    my ( $self, $fragment ) = @_;
    my $base_url = $self->base_url;
    my $api_version = $base_url=~/\/$/ ? 'api/v2/' : '/api/v2/';
    if ( $fragment=~/^\// ) {
        $fragment=~s/^\///ig;
    }
    return "$base_url$api_version$fragment";
}

=head2 prepare_uri_as_string

Utility method to build url with query parameters

=cut

sub prepare_uri_as_string {
    my ( $self, $url, $params ) = @_;
    my $uri = URI->new($url);
    if ( $params ) {
        $uri->query_form( ref($params) eq "HASH" ? %$params : @$params );
    }
    return $uri->as_string;
}

=head2 json_response

Utility method to get response as JSON format

=cut

sub json_response {
    my ( $self, $response ) = @_;
    return $self->json->encode( $response );
}

=head1 AUTHOR

binary.com, C<< <rakesh at binary.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-www-desk at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=WWW-Desk>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc WWW::Desk


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=WWW-Desk>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/WWW-Desk>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/WWW-Desk>

=item * Search CPAN

L<http://search.cpan.org/dist/WWW-Desk/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2014 binary.com.

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

no Moose;
__PACKAGE__->meta->make_immutable();

1; # End of WWW::Desk
