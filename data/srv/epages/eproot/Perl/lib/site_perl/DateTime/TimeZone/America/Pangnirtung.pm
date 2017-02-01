# This file is auto-generated by the Perl DateTime Suite time zone
# code generator (0.07) This code generator comes with the
# DateTime::TimeZone module distribution in the tools/ directory

#
# Generated from /tmp/JUf_DFso8q/northamerica.  Olson data version 2011g
#
# Do not edit this file directly.
#
package DateTime::TimeZone::America::Pangnirtung;
BEGIN {
  $DateTime::TimeZone::America::Pangnirtung::VERSION = '1.34';
}

use strict;

use Class::Singleton;
use DateTime::TimeZone;
use DateTime::TimeZone::OlsonDB;

@DateTime::TimeZone::America::Pangnirtung::ISA = ( 'Class::Singleton', 'DateTime::TimeZone' );

my $spans =
[
    [
DateTime::TimeZone::NEG_INFINITY,
60589382400,
DateTime::TimeZone::NEG_INFINITY,
60589382400,
0,
0,
'zzz'
    ],
    [
60589382400,
61255461600,
60589368000,
61255447200,
-14400,
0,
'AST'
    ],
    [
61255461600,
61366287600,
61255450800,
61366276800,
-10800,
1,
'AWT'
    ],
    [
61366287600,
61370283600,
61366276800,
61370272800,
-10800,
1,
'APT'
    ],
    [
61370283600,
61987780800,
61370269200,
61987766400,
-14400,
0,
'AST'
    ],
    [
61987780800,
62004110400,
61987773600,
62004103200,
-7200,
1,
'ADDT'
    ],
    [
62004110400,
62461346400,
62004096000,
62461332000,
-14400,
0,
'AST'
    ],
    [
62461346400,
62477067600,
62461335600,
62477056800,
-10800,
1,
'ADT'
    ],
    [
62477067600,
62492796000,
62477053200,
62492781600,
-14400,
0,
'AST'
    ],
    [
62492796000,
62508517200,
62492785200,
62508506400,
-10800,
1,
'ADT'
    ],
    [
62508517200,
62524245600,
62508502800,
62524231200,
-14400,
0,
'AST'
    ],
    [
62524245600,
62540571600,
62524234800,
62540560800,
-10800,
1,
'ADT'
    ],
    [
62540571600,
62555695200,
62540557200,
62555680800,
-14400,
0,
'AST'
    ],
    [
62555695200,
62572021200,
62555684400,
62572010400,
-10800,
1,
'ADT'
    ],
    [
62572021200,
62587749600,
62572006800,
62587735200,
-14400,
0,
'AST'
    ],
    [
62587749600,
62603470800,
62587738800,
62603460000,
-10800,
1,
'ADT'
    ],
    [
62603470800,
62619199200,
62603456400,
62619184800,
-14400,
0,
'AST'
    ],
    [
62619199200,
62634920400,
62619188400,
62634909600,
-10800,
1,
'ADT'
    ],
    [
62634920400,
62650648800,
62634906000,
62650634400,
-14400,
0,
'AST'
    ],
    [
62650648800,
62666370000,
62650638000,
62666359200,
-10800,
1,
'ADT'
    ],
    [
62666370000,
62680284000,
62666355600,
62680269600,
-14400,
0,
'AST'
    ],
    [
62680284000,
62697819600,
62680273200,
62697808800,
-10800,
1,
'ADT'
    ],
    [
62697819600,
62711733600,
62697805200,
62711719200,
-14400,
0,
'AST'
    ],
    [
62711733600,
62729874000,
62711722800,
62729863200,
-10800,
1,
'ADT'
    ],
    [
62729874000,
62743183200,
62729859600,
62743168800,
-14400,
0,
'AST'
    ],
    [
62743183200,
62761323600,
62743172400,
62761312800,
-10800,
1,
'ADT'
    ],
    [
62761323600,
62774632800,
62761309200,
62774618400,
-14400,
0,
'AST'
    ],
    [
62774632800,
62792773200,
62774622000,
62792762400,
-10800,
1,
'ADT'
    ],
    [
62792773200,
62806687200,
62792758800,
62806672800,
-14400,
0,
'AST'
    ],
    [
62806687200,
62824222800,
62806676400,
62824212000,
-10800,
1,
'ADT'
    ],
    [
62824222800,
62838136800,
62824208400,
62838122400,
-14400,
0,
'AST'
    ],
    [
62838136800,
62855672400,
62838126000,
62855661600,
-10800,
1,
'ADT'
    ],
    [
62855672400,
62869586400,
62855658000,
62869572000,
-14400,
0,
'AST'
    ],
    [
62869586400,
62887726800,
62869575600,
62887716000,
-10800,
1,
'ADT'
    ],
    [
62887726800,
62901036000,
62887712400,
62901021600,
-14400,
0,
'AST'
    ],
    [
62901036000,
62919176400,
62901025200,
62919165600,
-10800,
1,
'ADT'
    ],
    [
62919176400,
62932485600,
62919162000,
62932471200,
-14400,
0,
'AST'
    ],
    [
62932485600,
62950629600,
62932471200,
62950615200,
-14400,
1,
'EDT'
    ],
    [
62950629600,
62964543600,
62950611600,
62964525600,
-18000,
0,
'EST'
    ],
    [
62964543600,
62982079200,
62964529200,
62982064800,
-14400,
1,
'EDT'
    ],
    [
62982079200,
62995993200,
62982061200,
62995975200,
-18000,
0,
'EST'
    ],
    [
62995993200,
63013528800,
62995978800,
63013514400,
-14400,
1,
'EDT'
    ],
    [
63013528800,
63027442800,
63013510800,
63027424800,
-18000,
0,
'EST'
    ],
    [
63027442800,
63044978400,
63027428400,
63044964000,
-14400,
1,
'EDT'
    ],
    [
63044978400,
63058892400,
63044960400,
63058874400,
-18000,
0,
'EST'
    ],
    [
63058892400,
63077032800,
63058878000,
63077018400,
-14400,
1,
'EDT'
    ],
    [
63077032800,
63090345600,
63077011200,
63090324000,
-21600,
0,
'CST'
    ],
    [
63090345600,
63108486000,
63090327600,
63108468000,
-18000,
1,
'CDT'
    ],
    [
63108486000,
63121791600,
63108468000,
63121773600,
-18000,
0,
'EST'
    ],
    [
63121791600,
63139932000,
63121777200,
63139917600,
-14400,
1,
'EDT'
    ],
    [
63139932000,
63153846000,
63139914000,
63153828000,
-18000,
0,
'EST'
    ],
    [
63153846000,
63171381600,
63153831600,
63171367200,
-14400,
1,
'EDT'
    ],
    [
63171381600,
63185295600,
63171363600,
63185277600,
-18000,
0,
'EST'
    ],
    [
63185295600,
63202831200,
63185281200,
63202816800,
-14400,
1,
'EDT'
    ],
    [
63202831200,
63216745200,
63202813200,
63216727200,
-18000,
0,
'EST'
    ],
    [
63216745200,
63234885600,
63216730800,
63234871200,
-14400,
1,
'EDT'
    ],
    [
63234885600,
63248194800,
63234867600,
63248176800,
-18000,
0,
'EST'
    ],
    [
63248194800,
63266335200,
63248180400,
63266320800,
-14400,
1,
'EDT'
    ],
    [
63266335200,
63279644400,
63266317200,
63279626400,
-18000,
0,
'EST'
    ],
    [
63279644400,
63297784800,
63279630000,
63297770400,
-14400,
1,
'EDT'
    ],
    [
63297784800,
63309279600,
63297766800,
63309261600,
-18000,
0,
'EST'
    ],
    [
63309279600,
63329839200,
63309265200,
63329824800,
-14400,
1,
'EDT'
    ],
    [
63329839200,
63340729200,
63329821200,
63340711200,
-18000,
0,
'EST'
    ],
    [
63340729200,
63361288800,
63340714800,
63361274400,
-14400,
1,
'EDT'
    ],
    [
63361288800,
63372178800,
63361270800,
63372160800,
-18000,
0,
'EST'
    ],
    [
63372178800,
63392738400,
63372164400,
63392724000,
-14400,
1,
'EDT'
    ],
    [
63392738400,
63404233200,
63392720400,
63404215200,
-18000,
0,
'EST'
    ],
    [
63404233200,
63424792800,
63404218800,
63424778400,
-14400,
1,
'EDT'
    ],
    [
63424792800,
63435682800,
63424774800,
63435664800,
-18000,
0,
'EST'
    ],
    [
63435682800,
63456242400,
63435668400,
63456228000,
-14400,
1,
'EDT'
    ],
    [
63456242400,
63467132400,
63456224400,
63467114400,
-18000,
0,
'EST'
    ],
    [
63467132400,
63487692000,
63467118000,
63487677600,
-14400,
1,
'EDT'
    ],
    [
63487692000,
63498582000,
63487674000,
63498564000,
-18000,
0,
'EST'
    ],
    [
63498582000,
63519141600,
63498567600,
63519127200,
-14400,
1,
'EDT'
    ],
    [
63519141600,
63530031600,
63519123600,
63530013600,
-18000,
0,
'EST'
    ],
    [
63530031600,
63550591200,
63530017200,
63550576800,
-14400,
1,
'EDT'
    ],
    [
63550591200,
63561481200,
63550573200,
63561463200,
-18000,
0,
'EST'
    ],
    [
63561481200,
63582040800,
63561466800,
63582026400,
-14400,
1,
'EDT'
    ],
    [
63582040800,
63593535600,
63582022800,
63593517600,
-18000,
0,
'EST'
    ],
    [
63593535600,
63614095200,
63593521200,
63614080800,
-14400,
1,
'EDT'
    ],
    [
63614095200,
63624985200,
63614077200,
63624967200,
-18000,
0,
'EST'
    ],
    [
63624985200,
63645544800,
63624970800,
63645530400,
-14400,
1,
'EDT'
    ],
    [
63645544800,
63656434800,
63645526800,
63656416800,
-18000,
0,
'EST'
    ],
    [
63656434800,
63676994400,
63656420400,
63676980000,
-14400,
1,
'EDT'
    ],
    [
63676994400,
63687884400,
63676976400,
63687866400,
-18000,
0,
'EST'
    ],
    [
63687884400,
63708444000,
63687870000,
63708429600,
-14400,
1,
'EDT'
    ],
    [
63708444000,
63719334000,
63708426000,
63719316000,
-18000,
0,
'EST'
    ],
    [
63719334000,
63739893600,
63719319600,
63739879200,
-14400,
1,
'EDT'
    ],
    [
63739893600,
63751388400,
63739875600,
63751370400,
-18000,
0,
'EST'
    ],
    [
63751388400,
63771948000,
63751374000,
63771933600,
-14400,
1,
'EDT'
    ],
    [
63771948000,
63782838000,
63771930000,
63782820000,
-18000,
0,
'EST'
    ],
    [
63782838000,
63803397600,
63782823600,
63803383200,
-14400,
1,
'EDT'
    ],
];

sub olson_version { '2011g' }

sub has_dst_changes { 46 }

sub _max_year { 2021 }

sub _new_instance
{
    return shift->_init( @_, spans => $spans );
}

sub _last_offset { -18000 }

my $last_observance = bless( {
  'format' => 'E%sT',
  'gmtoff' => '-5:00',
  'local_start_datetime' => bless( {
    'formatter' => undef,
    'local_rd_days' => 730422,
    'local_rd_secs' => 7200,
    'offset_modifier' => 0,
    'rd_nanosecs' => 0,
    'tz' => bless( {
      'name' => 'floating',
      'offset' => 0
    }, 'DateTime::TimeZone::Floating' ),
    'utc_rd_days' => 730422,
    'utc_rd_secs' => 7200,
    'utc_year' => 2001
  }, 'DateTime' ),
  'offset_from_std' => 0,
  'offset_from_utc' => -18000,
  'until' => [],
  'utc_start_datetime' => bless( {
    'formatter' => undef,
    'local_rd_days' => 730422,
    'local_rd_secs' => 25200,
    'offset_modifier' => 0,
    'rd_nanosecs' => 0,
    'tz' => bless( {
      'name' => 'floating',
      'offset' => 0
    }, 'DateTime::TimeZone::Floating' ),
    'utc_rd_days' => 730422,
    'utc_rd_secs' => 25200,
    'utc_year' => 2001
  }, 'DateTime' )
}, 'DateTime::TimeZone::OlsonDB::Observance' )
;
sub _last_observance { $last_observance }

my $rules = [
  bless( {
    'at' => '2:00',
    'from' => '2007',
    'in' => 'Mar',
    'letter' => 'D',
    'name' => 'Canada',
    'offset_from_std' => 3600,
    'on' => 'Sun>=8',
    'save' => '1:00',
    'to' => 'max',
    'type' => undef
  }, 'DateTime::TimeZone::OlsonDB::Rule' ),
  bless( {
    'at' => '2:00',
    'from' => '2007',
    'in' => 'Nov',
    'letter' => 'S',
    'name' => 'Canada',
    'offset_from_std' => 0,
    'on' => 'Sun>=1',
    'save' => '0',
    'to' => 'max',
    'type' => undef
  }, 'DateTime::TimeZone::OlsonDB::Rule' )
]
;
sub _rules { $rules }


1;
