=head1 NAME

Class::Mix - dynamic class mixing

=head1 SYNOPSIS

	use Class::Mix qw(mix_class);

	$foobar_object = mix_class("Foo", "Bar")->new;
	$digest_class = mix_class("Foo", "Bar", {prefix=>"Digest::"});

	use Class::Mix qw(genpkg);

	$package = genpkg;
	$package = genpkg("Digest::Foo::");

=head1 DESCRIPTION

The C<mix_class> function provided by this module dynamically generates
`anonymous' classes with specified inheritance.

=cut

package Class::Mix;

{ use 5.006; }
use warnings;
use strict;

use constant _DO_MRO => "$]" >= 5.009005;

use Carp qw(croak);
use Params::Classify 0.000 qw(is_undef is_string is_ref);
use if _DO_MRO, "mro";

our $VERSION = "0.005";

use parent "Exporter";
our @EXPORT_OK = qw(mix_class genpkg);

BEGIN {
	if(_DO_MRO) {
		*_get_mro = \&mro::get_mro;
	} else {
		*_get_mro = sub ($) { "dfs" };
	}
}

my $prefix_rx = qr/(?:[a-zA-Z_][0-9a-zA-Z_]*::(?:[0-9a-zA-Z_]+::)*)?/;

=head1 FUNCTIONS

=over

=item mix_class(ITEMS ...)

This function is used to dynamically generate `anonymous' classes by
mixing pre-existing classes.  This is useful where an incomplete class
requires use of a mixin in order to become instantiable, several suitable
mixins are available, and it is desired to make the choice between mixins
at runtime.

Each I<ITEM> in the argument list is either the name of a class to inherit
from (a parent class) or a reference to a hash of options.  The C<@ISA>
list of the mixture class is set to the list of parent class names,
in the order supplied.  The options that may be supplied are:

=over

=item B<mro>

Specifies the desired method resolution order (MRO) of the mixture class.
See L<mro> for details of the valid values and the default determined
by Perl.  Typically, this should be set to B<c3> if mixing into an
existing C3-based class hierarchy.

=item B<prefix>

Specifies where the resulting package will go.  May be C<undef> to
indicate that the caller doesn't care (which is the default state).
Otherwise it must be either the empty string (to create a top-level
package) or a bareword followed by "::" (to create a package under
that name).  For example, "Digest::" could be specified to ensure that
the resulting package has a name starting with "Digest::", so that C<<
Digest->new >> will accept it as the name of a message digest algorithm.

=back

The function generates a class of the form described by the arguments, and
returns its name.  The same class will be returned by repeated invocations
with the same parent class list and options.  The returned name may be
used to call a constructor or other class methods of the mixed class.

A class name must be returned because there is no such thing as an
anonymous class in Perl.  Classes are referenced by name.  The names
that are generated by this function are unique and insignificant.
See C<genpkg> below for more information.

If fewer than two classes to inherit from are specified, the function
tries to avoid generating a separate class for the mixture.  If only
one parent class is specified then that class may be returned, and if
no parent classes are specified then C<UNIVERSAL> may be returned.
This provides the desired inheritance without creating superfluous
classes.  These special cases only apply if the options are compatible
with the pre-existing class.

This function relies on the classes it returns remaining unmodified in
order to be returned by future invocations.  If you want to modify your
dynamically-generated `anonymous' classes, use C<genpkg> (below).

=cut

sub genpkg(;$);

my %mixtures;
sub mix_class(@) {
	my @parents;
	my %options;
	foreach(@_) {
		if(is_string($_)) {
			push @parents, $_;
		} elsif(is_ref($_, "HASH")) {
			foreach my $k (keys %$_) {
				croak "clashing option `$k'"
					if exists $options{$k};
				$options{$k} = $_->{$k};
			}
		} else {
			croak "bad argument for mix_class";
		}
	}
	foreach(keys %options) {
		croak "bad option `$_' for mix_class"
			unless /\A(?:mro|prefix)\z/;
	}
	$options{mro} = "dfs" unless exists $options{mro};
	croak "bad mro value" unless is_string($options{mro});
	$options{prefix} = undef unless exists $options{prefix};
	croak "bad prefix value" unless
		is_undef($options{prefix}) ||
			(is_string($options{prefix}) &&
				$options{prefix} =~ /\A$prefix_rx\z/o);
	return "UNIVERSAL" if @parents == 0 &&
		$options{mro} eq _get_mro("UNIVERSAL") &&
		(is_undef($options{prefix}) || $options{prefix} eq "");
	return $parents[0] if @parents == 1 &&
		$options{mro} eq _get_mro($parents[0]) &&
		(is_undef($options{prefix}) ||
			$parents[0] =~ /\A\Q$options{prefix}\E[^:]*\z/);
	$options{prefix} = "Class::Mix::" unless defined $options{prefix};
	my $recipe = join("", map { length($_)."_".$_ }
				$options{mro}, $options{prefix}, @parents);
	return $mixtures{$recipe} ||= do {
		my $pkg = genpkg($options{prefix});
		no strict "refs";
		@{$pkg."::ISA"} = @parents;
		mro::set_mro($pkg, $options{mro}) if $options{mro} ne "dfs";
		$pkg;
	};
}

=item genpkg([PREFIX])

This function selects and returns a package name that has not been
previously used.  The name returned is an ordinary bareword-form package
name, and can be used as the second argument to C<bless> and in all
other ways that package names are used.  The package is initially empty.

The package names returned by this function are of a type that should not
be used as ordinary fixed module names.  However, it is not possible to
entirely prevent a clash.  This function checks that the package name it
is about to return has not already been used, and will avoid returning
such names, but it cannot guarantee that a later-loaded module will not
create a clash.

PREFIX, if present, specifies where the resulting package will go.
It must be either the empty string (to create a top-level package)
or a bareword followed by "::" (to create a package under that name).
For example, "Digest::" could be specified to ensure that the resulting
package has a name starting with "Digest::", so that C<< Digest->new >>
will accept it as the name of a message digest algorithm.  If the PREFIX
is not supplied, the caller is not expressing any preference.

=cut

my $n = 0;
sub genpkg(;$) {
	my($prefix) = @_;
	$prefix = "Class::Mix::" unless defined $prefix;
	croak "`$prefix' is not a valid module name prefix"
		unless $prefix =~ /\A$prefix_rx\z/o;
	no strict "refs";
	my $pkgtail;
	do {
		$pkgtail = "__GP".$n++;
	} while(exists ${$prefix || "::"}{$pkgtail."::"});
	my $pkgname = $prefix.$pkgtail;
	%{$pkgname."::"} = ();
	return $pkgname;
}

=back

=head1 SEE ALSO

L<Class::Generate>,
L<mro>

=head1 AUTHOR

Andrew Main (Zefram) <zefram@fysh.org>

=head1 COPYRIGHT

Copyright (C) 2004, 2006, 2009, 2010, 2011
Andrew Main (Zefram) <zefram@fysh.org>

=head1 LICENSE

This module is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1;
