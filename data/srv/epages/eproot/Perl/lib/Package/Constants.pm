package Package::Constants;

use strict;
use vars qw[$VERSION $DEBUG];

$VERSION    = '0.02';
$DEBUG      = 0;

=head1 NAME

Package::Constants - List all constants declared in a package

=head1 SYNOPSIS

    use Package::Constants;

    ### list the names of all constants in a given package;
    @const = Package::Constants->list( __PACKAGE__ );
    @const = Package::Constants->list( 'main' );

    ### enable debugging output
    $Package::Constants::DEBUG = 1;

=head1 DESCRIPTION

C<Package::Constants> lists all the constants defined in a certain
package. This can be useful for, among others, setting up an
autogenerated C<@EXPORT/@EXPORT_OK> for a Constants.pm file.

=head1 CLASS METHODS

=head2 @const = Package::Constants->list( PACKAGE_NAME );

Lists the names of all the constants defined in the provided package.

=cut

sub list {
    my $class = shift;
    my $pkg   = shift;
    return unless defined $pkg; # some joker might use '0' as a pkg...

    _debug("Inspecting package '$pkg'");

    my @rv;
    {   no strict 'refs';
        my $stash = $pkg . '::';

        for my $name (sort keys %$stash ) {

            _debug( "   Checking stash entry '$name'" );

            ### is it a subentry?
            my $sub = $pkg->can( $name );
            next unless defined $sub;

            _debug( "       '$name' is a coderef" );

            next unless defined prototype($sub) and
                     not length prototype($sub);

            _debug( "       '$name' is a constant" );
            push @rv, $name;
        }
    }

    return sort @rv;
}

=head1 GLOBAL VARIABLES

=head2 $Package::Constants::DEBUG

When set to true, prints out debug information to STDERR about the
package it is inspecting. Helps to identify issues when the results
are not as you expect.

Defaults to false.

=cut

sub _debug { warn "@_\n" if $DEBUG; }

1;

=head1 BUG REPORTS

Please report bugs or other issues to E<lt>bug-package-constants@rt.cpan.org<gt>.

=head1 AUTHOR

This module by Jos Boumans E<lt>kane@cpan.orgE<gt>.

=head1 COPYRIGHT

This library is free software; you may redistribute and/or modify it
under the same terms as Perl itself.

=cut

# Local variables:
# c-indentation-style: bsd
# c-basic-offset: 4
# indent-tabs-mode: nil
# End:
# vim: expandtab shiftwidth=4:
