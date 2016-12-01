# This file is auto-generated by the Perl DateTime Suite time zone
# code generator (0.07) This code generator comes with the
# DateTime::TimeZone module distribution in the tools/ directory

#
# Generated from /tmp/JUf_DFso8q/australasia.  Olson data version 2011g
#
# Do not edit this file directly.
#
package DateTime::TimeZone::Pacific::Chuuk;
BEGIN {
  $DateTime::TimeZone::Pacific::Chuuk::VERSION = '1.34';
}

use strict;

use Class::Singleton;
use DateTime::TimeZone;
use DateTime::TimeZone::OlsonDB;

@DateTime::TimeZone::Pacific::Chuuk::ISA = ( 'Class::Singleton', 'DateTime::TimeZone' );

my $spans =
[
    [
DateTime::TimeZone::NEG_INFINITY,
59958193972,
DateTime::TimeZone::NEG_INFINITY,
59958230400,
36428,
0,
'LMT'
    ],
    [
59958193972,
DateTime::TimeZone::INFINITY,
59958229972,
DateTime::TimeZone::INFINITY,
36000,
0,
'CHUT'
    ],
];

sub olson_version { '2011g' }

sub has_dst_changes { 0 }

sub _max_year { 2021 }

sub _new_instance
{
    return shift->_init( @_, spans => $spans );
}



1;

