package Date::Manip::TZ::asgaza00;
# Copyright (c) 2008-2011 Sullivan Beck.  All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

# This file was automatically generated.  Any changes to this file will
# be lost the next time 'tzdata' is run.
#    Generated on: Fri Apr 15 08:12:12 EDT 2011
#    Data version: tzdata2011f
#    Code version: tzcode2011e

# This module contains data from the zoneinfo time zone database.  The original
# data was obtained from the URL:
#    ftp://elsie.nci.nih.gov/pub

=pod

=head1 NAME

Date::Manip::TZ::asgaza00 - Support for the Asia/Gaza time zone

=head1 SYNPOSIS

This module contains data from the Olsen database for the time zone. It
is not intended to be used directly (other Date::Manip modules will
load it as needed).

=cut

use strict;
use warnings;
require 5.010000;

our (%Dates,%LastRule);
END {
   undef %Dates;
   undef %LastRule;
}

our ($VERSION);
$VERSION='6.23';
END { undef $VERSION; }

%Dates         = (
   1    =>
     [
        [ [1,1,2,0,0,0],[1,1,2,2,17,52],'+02:17:52',[2,17,52],
          'LMT',0,[1900,9,30,21,42,7],[1900,9,30,23,59,59],
          '0001010200:00:00','0001010202:17:52','1900093021:42:07','1900093023:59:59' ],
     ],
   1900 =>
     [
        [ [1900,9,30,21,42,8],[1900,9,30,23,42,8],'+02:00:00',[2,0,0],
          'EET',0,[1940,5,31,21,59,59],[1940,5,31,23,59,59],
          '1900093021:42:08','1900093023:42:08','1940053121:59:59','1940053123:59:59' ],
     ],
   1940 =>
     [
        [ [1940,5,31,22,0,0],[1940,6,1,1,0,0],'+03:00:00',[3,0,0],
          'EET',1,[1942,10,31,20,59,59],[1942,10,31,23,59,59],
          '1940053122:00:00','1940060101:00:00','1942103120:59:59','1942103123:59:59' ],
     ],
   1942 =>
     [
        [ [1942,10,31,21,0,0],[1942,10,31,23,0,0],'+02:00:00',[2,0,0],
          'EET',0,[1943,3,31,23,59,59],[1943,4,1,1,59,59],
          '1942103121:00:00','1942103123:00:00','1943033123:59:59','1943040101:59:59' ],
     ],
   1943 =>
     [
        [ [1943,4,1,0,0,0],[1943,4,1,3,0,0],'+03:00:00',[3,0,0],
          'EET',1,[1943,10,31,20,59,59],[1943,10,31,23,59,59],
          '1943040100:00:00','1943040103:00:00','1943103120:59:59','1943103123:59:59' ],
        [ [1943,10,31,21,0,0],[1943,10,31,23,0,0],'+02:00:00',[2,0,0],
          'EET',0,[1944,3,31,21,59,59],[1944,3,31,23,59,59],
          '1943103121:00:00','1943103123:00:00','1944033121:59:59','1944033123:59:59' ],
     ],
   1944 =>
     [
        [ [1944,3,31,22,0,0],[1944,4,1,1,0,0],'+03:00:00',[3,0,0],
          'EET',1,[1944,10,31,20,59,59],[1944,10,31,23,59,59],
          '1944033122:00:00','1944040101:00:00','1944103120:59:59','1944103123:59:59' ],
        [ [1944,10,31,21,0,0],[1944,10,31,23,0,0],'+02:00:00',[2,0,0],
          'EET',0,[1945,4,15,21,59,59],[1945,4,15,23,59,59],
          '1944103121:00:00','1944103123:00:00','1945041521:59:59','1945041523:59:59' ],
     ],
   1945 =>
     [
        [ [1945,4,15,22,0,0],[1945,4,16,1,0,0],'+03:00:00',[3,0,0],
          'EET',1,[1945,10,31,22,59,59],[1945,11,1,1,59,59],
          '1945041522:00:00','1945041601:00:00','1945103122:59:59','1945110101:59:59' ],
        [ [1945,10,31,23,0,0],[1945,11,1,1,0,0],'+02:00:00',[2,0,0],
          'EET',0,[1946,4,15,23,59,59],[1946,4,16,1,59,59],
          '1945103123:00:00','1945110101:00:00','1946041523:59:59','1946041601:59:59' ],
     ],
   1946 =>
     [
        [ [1946,4,16,0,0,0],[1946,4,16,3,0,0],'+03:00:00',[3,0,0],
          'EET',1,[1946,10,31,20,59,59],[1946,10,31,23,59,59],
          '1946041600:00:00','1946041603:00:00','1946103120:59:59','1946103123:59:59' ],
        [ [1946,10,31,21,0,0],[1946,10,31,23,0,0],'+02:00:00',[2,0,0],
          'EET',0,[1957,5,9,21,59,59],[1957,5,9,23,59,59],
          '1946103121:00:00','1946103123:00:00','1957050921:59:59','1957050923:59:59' ],
     ],
   1957 =>
     [
        [ [1957,5,9,22,0,0],[1957,5,10,1,0,0],'+03:00:00',[3,0,0],
          'EEST',1,[1957,9,30,20,59,59],[1957,9,30,23,59,59],
          '1957050922:00:00','1957051001:00:00','1957093020:59:59','1957093023:59:59' ],
        [ [1957,9,30,21,0,0],[1957,9,30,23,0,0],'+02:00:00',[2,0,0],
          'EET',0,[1958,4,30,21,59,59],[1958,4,30,23,59,59],
          '1957093021:00:00','1957093023:00:00','1958043021:59:59','1958043023:59:59' ],
     ],
   1958 =>
     [
        [ [1958,4,30,22,0,0],[1958,5,1,1,0,0],'+03:00:00',[3,0,0],
          'EEST',1,[1958,9,30,20,59,59],[1958,9,30,23,59,59],
          '1958043022:00:00','1958050101:00:00','1958093020:59:59','1958093023:59:59' ],
        [ [1958,9,30,21,0,0],[1958,9,30,23,0,0],'+02:00:00',[2,0,0],
          'EET',0,[1959,4,30,22,59,59],[1959,5,1,0,59,59],
          '1958093021:00:00','1958093023:00:00','1959043022:59:59','1959050100:59:59' ],
     ],
   1959 =>
     [
        [ [1959,4,30,23,0,0],[1959,5,1,2,0,0],'+03:00:00',[3,0,0],
          'EEST',1,[1959,9,29,23,59,59],[1959,9,30,2,59,59],
          '1959043023:00:00','1959050102:00:00','1959092923:59:59','1959093002:59:59' ],
        [ [1959,9,30,0,0,0],[1959,9,30,2,0,0],'+02:00:00',[2,0,0],
          'EET',0,[1960,4,30,22,59,59],[1960,5,1,0,59,59],
          '1959093000:00:00','1959093002:00:00','1960043022:59:59','1960050100:59:59' ],
     ],
   1960 =>
     [
        [ [1960,4,30,23,0,0],[1960,5,1,2,0,0],'+03:00:00',[3,0,0],
          'EEST',1,[1960,9,29,23,59,59],[1960,9,30,2,59,59],
          '1960043023:00:00','1960050102:00:00','1960092923:59:59','1960093002:59:59' ],
        [ [1960,9,30,0,0,0],[1960,9,30,2,0,0],'+02:00:00',[2,0,0],
          'EET',0,[1961,4,30,22,59,59],[1961,5,1,0,59,59],
          '1960093000:00:00','1960093002:00:00','1961043022:59:59','1961050100:59:59' ],
     ],
   1961 =>
     [
        [ [1961,4,30,23,0,0],[1961,5,1,2,0,0],'+03:00:00',[3,0,0],
          'EEST',1,[1961,9,29,23,59,59],[1961,9,30,2,59,59],
          '1961043023:00:00','1961050102:00:00','1961092923:59:59','1961093002:59:59' ],
        [ [1961,9,30,0,0,0],[1961,9,30,2,0,0],'+02:00:00',[2,0,0],
          'EET',0,[1962,4,30,22,59,59],[1962,5,1,0,59,59],
          '1961093000:00:00','1961093002:00:00','1962043022:59:59','1962050100:59:59' ],
     ],
   1962 =>
     [
        [ [1962,4,30,23,0,0],[1962,5,1,2,0,0],'+03:00:00',[3,0,0],
          'EEST',1,[1962,9,29,23,59,59],[1962,9,30,2,59,59],
          '1962043023:00:00','1962050102:00:00','1962092923:59:59','1962093002:59:59' ],
        [ [1962,9,30,0,0,0],[1962,9,30,2,0,0],'+02:00:00',[2,0,0],
          'EET',0,[1963,4,30,22,59,59],[1963,5,1,0,59,59],
          '1962093000:00:00','1962093002:00:00','1963043022:59:59','1963050100:59:59' ],
     ],
   1963 =>
     [
        [ [1963,4,30,23,0,0],[1963,5,1,2,0,0],'+03:00:00',[3,0,0],
          'EEST',1,[1963,9,29,23,59,59],[1963,9,30,2,59,59],
          '1963043023:00:00','1963050102:00:00','1963092923:59:59','1963093002:59:59' ],
        [ [1963,9,30,0,0,0],[1963,9,30,2,0,0],'+02:00:00',[2,0,0],
          'EET',0,[1964,4,30,22,59,59],[1964,5,1,0,59,59],
          '1963093000:00:00','1963093002:00:00','1964043022:59:59','1964050100:59:59' ],
     ],
   1964 =>
     [
        [ [1964,4,30,23,0,0],[1964,5,1,2,0,0],'+03:00:00',[3,0,0],
          'EEST',1,[1964,9,29,23,59,59],[1964,9,30,2,59,59],
          '1964043023:00:00','1964050102:00:00','1964092923:59:59','1964093002:59:59' ],
        [ [1964,9,30,0,0,0],[1964,9,30,2,0,0],'+02:00:00',[2,0,0],
          'EET',0,[1965,4,30,22,59,59],[1965,5,1,0,59,59],
          '1964093000:00:00','1964093002:00:00','1965043022:59:59','1965050100:59:59' ],
     ],
   1965 =>
     [
        [ [1965,4,30,23,0,0],[1965,5,1,2,0,0],'+03:00:00',[3,0,0],
          'EEST',1,[1965,9,29,23,59,59],[1965,9,30,2,59,59],
          '1965043023:00:00','1965050102:00:00','1965092923:59:59','1965093002:59:59' ],
        [ [1965,9,30,0,0,0],[1965,9,30,2,0,0],'+02:00:00',[2,0,0],
          'EET',0,[1966,4,30,22,59,59],[1966,5,1,0,59,59],
          '1965093000:00:00','1965093002:00:00','1966043022:59:59','1966050100:59:59' ],
     ],
   1966 =>
     [
        [ [1966,4,30,23,0,0],[1966,5,1,2,0,0],'+03:00:00',[3,0,0],
          'EEST',1,[1966,9,30,23,59,59],[1966,10,1,2,59,59],
          '1966043023:00:00','1966050102:00:00','1966093023:59:59','1966100102:59:59' ],
        [ [1966,10,1,0,0,0],[1966,10,1,2,0,0],'+02:00:00',[2,0,0],
          'EET',0,[1967,4,30,22,59,59],[1967,5,1,0,59,59],
          '1966100100:00:00','1966100102:00:00','1967043022:59:59','1967050100:59:59' ],
     ],
   1967 =>
     [
        [ [1967,4,30,23,0,0],[1967,5,1,2,0,0],'+03:00:00',[3,0,0],
          'EEST',1,[1967,6,4,20,59,59],[1967,6,4,23,59,59],
          '1967043023:00:00','1967050102:00:00','1967060420:59:59','1967060423:59:59' ],
        [ [1967,6,4,21,0,0],[1967,6,4,23,0,0],'+02:00:00',[2,0,0],
          'IST',0,[1974,7,6,21,59,59],[1974,7,6,23,59,59],
          '1967060421:00:00','1967060423:00:00','1974070621:59:59','1974070623:59:59' ],
     ],
   1974 =>
     [
        [ [1974,7,6,22,0,0],[1974,7,7,1,0,0],'+03:00:00',[3,0,0],
          'IDT',1,[1974,10,12,20,59,59],[1974,10,12,23,59,59],
          '1974070622:00:00','1974070701:00:00','1974101220:59:59','1974101223:59:59' ],
        [ [1974,10,12,21,0,0],[1974,10,12,23,0,0],'+02:00:00',[2,0,0],
          'IST',0,[1975,4,19,21,59,59],[1975,4,19,23,59,59],
          '1974101221:00:00','1974101223:00:00','1975041921:59:59','1975041923:59:59' ],
     ],
   1975 =>
     [
        [ [1975,4,19,22,0,0],[1975,4,20,1,0,0],'+03:00:00',[3,0,0],
          'IDT',1,[1975,8,30,20,59,59],[1975,8,30,23,59,59],
          '1975041922:00:00','1975042001:00:00','1975083020:59:59','1975083023:59:59' ],
        [ [1975,8,30,21,0,0],[1975,8,30,23,0,0],'+02:00:00',[2,0,0],
          'IST',0,[1985,4,13,21,59,59],[1985,4,13,23,59,59],
          '1975083021:00:00','1975083023:00:00','1985041321:59:59','1985041323:59:59' ],
     ],
   1985 =>
     [
        [ [1985,4,13,22,0,0],[1985,4,14,1,0,0],'+03:00:00',[3,0,0],
          'IDT',1,[1985,9,14,20,59,59],[1985,9,14,23,59,59],
          '1985041322:00:00','1985041401:00:00','1985091420:59:59','1985091423:59:59' ],
        [ [1985,9,14,21,0,0],[1985,9,14,23,0,0],'+02:00:00',[2,0,0],
          'IST',0,[1986,5,17,21,59,59],[1986,5,17,23,59,59],
          '1985091421:00:00','1985091423:00:00','1986051721:59:59','1986051723:59:59' ],
     ],
   1986 =>
     [
        [ [1986,5,17,22,0,0],[1986,5,18,1,0,0],'+03:00:00',[3,0,0],
          'IDT',1,[1986,9,6,20,59,59],[1986,9,6,23,59,59],
          '1986051722:00:00','1986051801:00:00','1986090620:59:59','1986090623:59:59' ],
        [ [1986,9,6,21,0,0],[1986,9,6,23,0,0],'+02:00:00',[2,0,0],
          'IST',0,[1987,4,14,21,59,59],[1987,4,14,23,59,59],
          '1986090621:00:00','1986090623:00:00','1987041421:59:59','1987041423:59:59' ],
     ],
   1987 =>
     [
        [ [1987,4,14,22,0,0],[1987,4,15,1,0,0],'+03:00:00',[3,0,0],
          'IDT',1,[1987,9,12,20,59,59],[1987,9,12,23,59,59],
          '1987041422:00:00','1987041501:00:00','1987091220:59:59','1987091223:59:59' ],
        [ [1987,9,12,21,0,0],[1987,9,12,23,0,0],'+02:00:00',[2,0,0],
          'IST',0,[1988,4,8,21,59,59],[1988,4,8,23,59,59],
          '1987091221:00:00','1987091223:00:00','1988040821:59:59','1988040823:59:59' ],
     ],
   1988 =>
     [
        [ [1988,4,8,22,0,0],[1988,4,9,1,0,0],'+03:00:00',[3,0,0],
          'IDT',1,[1988,9,2,20,59,59],[1988,9,2,23,59,59],
          '1988040822:00:00','1988040901:00:00','1988090220:59:59','1988090223:59:59' ],
        [ [1988,9,2,21,0,0],[1988,9,2,23,0,0],'+02:00:00',[2,0,0],
          'IST',0,[1989,4,29,21,59,59],[1989,4,29,23,59,59],
          '1988090221:00:00','1988090223:00:00','1989042921:59:59','1989042923:59:59' ],
     ],
   1989 =>
     [
        [ [1989,4,29,22,0,0],[1989,4,30,1,0,0],'+03:00:00',[3,0,0],
          'IDT',1,[1989,9,2,20,59,59],[1989,9,2,23,59,59],
          '1989042922:00:00','1989043001:00:00','1989090220:59:59','1989090223:59:59' ],
        [ [1989,9,2,21,0,0],[1989,9,2,23,0,0],'+02:00:00',[2,0,0],
          'IST',0,[1990,3,24,21,59,59],[1990,3,24,23,59,59],
          '1989090221:00:00','1989090223:00:00','1990032421:59:59','1990032423:59:59' ],
     ],
   1990 =>
     [
        [ [1990,3,24,22,0,0],[1990,3,25,1,0,0],'+03:00:00',[3,0,0],
          'IDT',1,[1990,8,25,20,59,59],[1990,8,25,23,59,59],
          '1990032422:00:00','1990032501:00:00','1990082520:59:59','1990082523:59:59' ],
        [ [1990,8,25,21,0,0],[1990,8,25,23,0,0],'+02:00:00',[2,0,0],
          'IST',0,[1991,3,23,21,59,59],[1991,3,23,23,59,59],
          '1990082521:00:00','1990082523:00:00','1991032321:59:59','1991032323:59:59' ],
     ],
   1991 =>
     [
        [ [1991,3,23,22,0,0],[1991,3,24,1,0,0],'+03:00:00',[3,0,0],
          'IDT',1,[1991,8,31,20,59,59],[1991,8,31,23,59,59],
          '1991032322:00:00','1991032401:00:00','1991083120:59:59','1991083123:59:59' ],
        [ [1991,8,31,21,0,0],[1991,8,31,23,0,0],'+02:00:00',[2,0,0],
          'IST',0,[1992,3,28,21,59,59],[1992,3,28,23,59,59],
          '1991083121:00:00','1991083123:00:00','1992032821:59:59','1992032823:59:59' ],
     ],
   1992 =>
     [
        [ [1992,3,28,22,0,0],[1992,3,29,1,0,0],'+03:00:00',[3,0,0],
          'IDT',1,[1992,9,5,20,59,59],[1992,9,5,23,59,59],
          '1992032822:00:00','1992032901:00:00','1992090520:59:59','1992090523:59:59' ],
        [ [1992,9,5,21,0,0],[1992,9,5,23,0,0],'+02:00:00',[2,0,0],
          'IST',0,[1993,4,1,21,59,59],[1993,4,1,23,59,59],
          '1992090521:00:00','1992090523:00:00','1993040121:59:59','1993040123:59:59' ],
     ],
   1993 =>
     [
        [ [1993,4,1,22,0,0],[1993,4,2,1,0,0],'+03:00:00',[3,0,0],
          'IDT',1,[1993,9,4,20,59,59],[1993,9,4,23,59,59],
          '1993040122:00:00','1993040201:00:00','1993090420:59:59','1993090423:59:59' ],
        [ [1993,9,4,21,0,0],[1993,9,4,23,0,0],'+02:00:00',[2,0,0],
          'IST',0,[1994,3,31,21,59,59],[1994,3,31,23,59,59],
          '1993090421:00:00','1993090423:00:00','1994033121:59:59','1994033123:59:59' ],
     ],
   1994 =>
     [
        [ [1994,3,31,22,0,0],[1994,4,1,1,0,0],'+03:00:00',[3,0,0],
          'IDT',1,[1994,8,27,20,59,59],[1994,8,27,23,59,59],
          '1994033122:00:00','1994040101:00:00','1994082720:59:59','1994082723:59:59' ],
        [ [1994,8,27,21,0,0],[1994,8,27,23,0,0],'+02:00:00',[2,0,0],
          'IST',0,[1995,3,30,21,59,59],[1995,3,30,23,59,59],
          '1994082721:00:00','1994082723:00:00','1995033021:59:59','1995033023:59:59' ],
     ],
   1995 =>
     [
        [ [1995,3,30,22,0,0],[1995,3,31,1,0,0],'+03:00:00',[3,0,0],
          'IDT',1,[1995,9,2,20,59,59],[1995,9,2,23,59,59],
          '1995033022:00:00','1995033101:00:00','1995090220:59:59','1995090223:59:59' ],
        [ [1995,9,2,21,0,0],[1995,9,2,23,0,0],'+02:00:00',[2,0,0],
          'IST',0,[1995,12,31,21,59,59],[1995,12,31,23,59,59],
          '1995090221:00:00','1995090223:00:00','1995123121:59:59','1995123123:59:59' ],
        [ [1995,12,31,22,0,0],[1996,1,1,0,0,0],'+02:00:00',[2,0,0],
          'EET',0,[1996,4,4,21,59,59],[1996,4,4,23,59,59],
          '1995123122:00:00','1996010100:00:00','1996040421:59:59','1996040423:59:59' ],
     ],
   1996 =>
     [
        [ [1996,4,4,22,0,0],[1996,4,5,1,0,0],'+03:00:00',[3,0,0],
          'EEST',1,[1996,9,19,21,59,59],[1996,9,20,0,59,59],
          '1996040422:00:00','1996040501:00:00','1996091921:59:59','1996092000:59:59' ],
        [ [1996,9,19,22,0,0],[1996,9,20,0,0,0],'+02:00:00',[2,0,0],
          'EET',0,[1997,4,3,21,59,59],[1997,4,3,23,59,59],
          '1996091922:00:00','1996092000:00:00','1997040321:59:59','1997040323:59:59' ],
     ],
   1997 =>
     [
        [ [1997,4,3,22,0,0],[1997,4,4,1,0,0],'+03:00:00',[3,0,0],
          'EEST',1,[1997,9,18,21,59,59],[1997,9,19,0,59,59],
          '1997040322:00:00','1997040401:00:00','1997091821:59:59','1997091900:59:59' ],
        [ [1997,9,18,22,0,0],[1997,9,19,0,0,0],'+02:00:00',[2,0,0],
          'EET',0,[1998,4,2,21,59,59],[1998,4,2,23,59,59],
          '1997091822:00:00','1997091900:00:00','1998040221:59:59','1998040223:59:59' ],
     ],
   1998 =>
     [
        [ [1998,4,2,22,0,0],[1998,4,3,1,0,0],'+03:00:00',[3,0,0],
          'EEST',1,[1998,9,17,21,59,59],[1998,9,18,0,59,59],
          '1998040222:00:00','1998040301:00:00','1998091721:59:59','1998091800:59:59' ],
        [ [1998,9,17,22,0,0],[1998,9,18,0,0,0],'+02:00:00',[2,0,0],
          'EET',0,[1999,4,15,21,59,59],[1999,4,15,23,59,59],
          '1998091722:00:00','1998091800:00:00','1999041521:59:59','1999041523:59:59' ],
     ],
   1999 =>
     [
        [ [1999,4,15,22,0,0],[1999,4,16,1,0,0],'+03:00:00',[3,0,0],
          'EEST',1,[1999,10,14,20,59,59],[1999,10,14,23,59,59],
          '1999041522:00:00','1999041601:00:00','1999101420:59:59','1999101423:59:59' ],
        [ [1999,10,14,21,0,0],[1999,10,14,23,0,0],'+02:00:00',[2,0,0],
          'EET',0,[2000,4,20,21,59,59],[2000,4,20,23,59,59],
          '1999101421:00:00','1999101423:00:00','2000042021:59:59','2000042023:59:59' ],
     ],
   2000 =>
     [
        [ [2000,4,20,22,0,0],[2000,4,21,1,0,0],'+03:00:00',[3,0,0],
          'EEST',1,[2000,10,19,20,59,59],[2000,10,19,23,59,59],
          '2000042022:00:00','2000042101:00:00','2000101920:59:59','2000101923:59:59' ],
        [ [2000,10,19,21,0,0],[2000,10,19,23,0,0],'+02:00:00',[2,0,0],
          'EET',0,[2001,4,19,21,59,59],[2001,4,19,23,59,59],
          '2000101921:00:00','2000101923:00:00','2001041921:59:59','2001041923:59:59' ],
     ],
   2001 =>
     [
        [ [2001,4,19,22,0,0],[2001,4,20,1,0,0],'+03:00:00',[3,0,0],
          'EEST',1,[2001,10,18,20,59,59],[2001,10,18,23,59,59],
          '2001041922:00:00','2001042001:00:00','2001101820:59:59','2001101823:59:59' ],
        [ [2001,10,18,21,0,0],[2001,10,18,23,0,0],'+02:00:00',[2,0,0],
          'EET',0,[2002,4,18,21,59,59],[2002,4,18,23,59,59],
          '2001101821:00:00','2001101823:00:00','2002041821:59:59','2002041823:59:59' ],
     ],
   2002 =>
     [
        [ [2002,4,18,22,0,0],[2002,4,19,1,0,0],'+03:00:00',[3,0,0],
          'EEST',1,[2002,10,17,20,59,59],[2002,10,17,23,59,59],
          '2002041822:00:00','2002041901:00:00','2002101720:59:59','2002101723:59:59' ],
        [ [2002,10,17,21,0,0],[2002,10,17,23,0,0],'+02:00:00',[2,0,0],
          'EET',0,[2003,4,17,21,59,59],[2003,4,17,23,59,59],
          '2002101721:00:00','2002101723:00:00','2003041721:59:59','2003041723:59:59' ],
     ],
   2003 =>
     [
        [ [2003,4,17,22,0,0],[2003,4,18,1,0,0],'+03:00:00',[3,0,0],
          'EEST',1,[2003,10,16,20,59,59],[2003,10,16,23,59,59],
          '2003041722:00:00','2003041801:00:00','2003101620:59:59','2003101623:59:59' ],
        [ [2003,10,16,21,0,0],[2003,10,16,23,0,0],'+02:00:00',[2,0,0],
          'EET',0,[2004,4,15,21,59,59],[2004,4,15,23,59,59],
          '2003101621:00:00','2003101623:00:00','2004041521:59:59','2004041523:59:59' ],
     ],
   2004 =>
     [
        [ [2004,4,15,22,0,0],[2004,4,16,1,0,0],'+03:00:00',[3,0,0],
          'EEST',1,[2004,9,30,21,59,59],[2004,10,1,0,59,59],
          '2004041522:00:00','2004041601:00:00','2004093021:59:59','2004100100:59:59' ],
        [ [2004,9,30,22,0,0],[2004,10,1,0,0,0],'+02:00:00',[2,0,0],
          'EET',0,[2005,4,14,21,59,59],[2005,4,14,23,59,59],
          '2004093022:00:00','2004100100:00:00','2005041421:59:59','2005041423:59:59' ],
     ],
   2005 =>
     [
        [ [2005,4,14,22,0,0],[2005,4,15,1,0,0],'+03:00:00',[3,0,0],
          'EEST',1,[2005,10,3,22,59,59],[2005,10,4,1,59,59],
          '2005041422:00:00','2005041501:00:00','2005100322:59:59','2005100401:59:59' ],
        [ [2005,10,3,23,0,0],[2005,10,4,1,0,0],'+02:00:00',[2,0,0],
          'EET',0,[2006,3,31,21,59,59],[2006,3,31,23,59,59],
          '2005100323:00:00','2005100401:00:00','2006033121:59:59','2006033123:59:59' ],
     ],
   2006 =>
     [
        [ [2006,3,31,22,0,0],[2006,4,1,1,0,0],'+03:00:00',[3,0,0],
          'EEST',1,[2006,9,21,20,59,59],[2006,9,21,23,59,59],
          '2006033122:00:00','2006040101:00:00','2006092120:59:59','2006092123:59:59' ],
        [ [2006,9,21,21,0,0],[2006,9,21,23,0,0],'+02:00:00',[2,0,0],
          'EET',0,[2007,3,31,21,59,59],[2007,3,31,23,59,59],
          '2006092121:00:00','2006092123:00:00','2007033121:59:59','2007033123:59:59' ],
     ],
   2007 =>
     [
        [ [2007,3,31,22,0,0],[2007,4,1,1,0,0],'+03:00:00',[3,0,0],
          'EEST',1,[2007,9,12,22,59,59],[2007,9,13,1,59,59],
          '2007033122:00:00','2007040101:00:00','2007091222:59:59','2007091301:59:59' ],
        [ [2007,9,12,23,0,0],[2007,9,13,1,0,0],'+02:00:00',[2,0,0],
          'EET',0,[2008,3,31,21,59,59],[2008,3,31,23,59,59],
          '2007091223:00:00','2007091301:00:00','2008033121:59:59','2008033123:59:59' ],
     ],
   2008 =>
     [
        [ [2008,3,31,22,0,0],[2008,4,1,1,0,0],'+03:00:00',[3,0,0],
          'EEST',1,[2008,8,28,22,59,59],[2008,8,29,1,59,59],
          '2008033122:00:00','2008040101:00:00','2008082822:59:59','2008082901:59:59' ],
        [ [2008,8,28,23,0,0],[2008,8,29,1,0,0],'+02:00:00',[2,0,0],
          'EET',0,[2009,3,26,21,59,59],[2009,3,26,23,59,59],
          '2008082823:00:00','2008082901:00:00','2009032621:59:59','2009032623:59:59' ],
     ],
   2009 =>
     [
        [ [2009,3,26,22,0,0],[2009,3,27,1,0,0],'+03:00:00',[3,0,0],
          'EEST',1,[2009,9,3,22,59,59],[2009,9,4,1,59,59],
          '2009032622:00:00','2009032701:00:00','2009090322:59:59','2009090401:59:59' ],
        [ [2009,9,3,23,0,0],[2009,9,4,1,0,0],'+02:00:00',[2,0,0],
          'EET',0,[2010,3,26,22,0,59],[2010,3,27,0,0,59],
          '2009090323:00:00','2009090401:00:00','2010032622:00:59','2010032700:00:59' ],
     ],
   2010 =>
     [
        [ [2010,3,26,22,1,0],[2010,3,27,1,1,0],'+03:00:00',[3,0,0],
          'EEST',1,[2010,8,10,20,59,59],[2010,8,10,23,59,59],
          '2010032622:01:00','2010032701:01:00','2010081020:59:59','2010081023:59:59' ],
        [ [2010,8,10,21,0,0],[2010,8,10,23,0,0],'+02:00:00',[2,0,0],
          'EET',0,[2011,3,25,22,0,59],[2011,3,26,0,0,59],
          '2010081021:00:00','2010081023:00:00','2011032522:00:59','2011032600:00:59' ],
     ],
   2011 =>
     [
        [ [2011,3,25,22,1,0],[2011,3,26,1,1,0],'+03:00:00',[3,0,0],
          'EEST',1,[2011,9,1,22,59,59],[2011,9,2,1,59,59],
          '2011032522:01:00','2011032601:01:00','2011090122:59:59','2011090201:59:59' ],
        [ [2011,9,1,23,0,0],[2011,9,2,1,0,0],'+02:00:00',[2,0,0],
          'EET',0,[2012,3,30,22,0,59],[2012,3,31,0,0,59],
          '2011090123:00:00','2011090201:00:00','2012033022:00:59','2012033100:00:59' ],
     ],
   2012 =>
     [
        [ [2012,3,30,22,1,0],[2012,3,31,1,1,0],'+03:00:00',[3,0,0],
          'EEST',1,[2012,9,6,22,59,59],[2012,9,7,1,59,59],
          '2012033022:01:00','2012033101:01:00','2012090622:59:59','2012090701:59:59' ],
        [ [2012,9,6,23,0,0],[2012,9,7,1,0,0],'+02:00:00',[2,0,0],
          'EET',0,[2013,3,29,22,0,59],[2013,3,30,0,0,59],
          '2012090623:00:00','2012090701:00:00','2013032922:00:59','2013033000:00:59' ],
     ],
   2013 =>
     [
        [ [2013,3,29,22,1,0],[2013,3,30,1,1,0],'+03:00:00',[3,0,0],
          'EEST',1,[2013,9,5,22,59,59],[2013,9,6,1,59,59],
          '2013032922:01:00','2013033001:01:00','2013090522:59:59','2013090601:59:59' ],
        [ [2013,9,5,23,0,0],[2013,9,6,1,0,0],'+02:00:00',[2,0,0],
          'EET',0,[2014,3,28,22,0,59],[2014,3,29,0,0,59],
          '2013090523:00:00','2013090601:00:00','2014032822:00:59','2014032900:00:59' ],
     ],
   2014 =>
     [
        [ [2014,3,28,22,1,0],[2014,3,29,1,1,0],'+03:00:00',[3,0,0],
          'EEST',1,[2014,9,4,22,59,59],[2014,9,5,1,59,59],
          '2014032822:01:00','2014032901:01:00','2014090422:59:59','2014090501:59:59' ],
        [ [2014,9,4,23,0,0],[2014,9,5,1,0,0],'+02:00:00',[2,0,0],
          'EET',0,[2015,3,27,22,0,59],[2015,3,28,0,0,59],
          '2014090423:00:00','2014090501:00:00','2015032722:00:59','2015032800:00:59' ],
     ],
   2015 =>
     [
        [ [2015,3,27,22,1,0],[2015,3,28,1,1,0],'+03:00:00',[3,0,0],
          'EEST',1,[2015,9,3,22,59,59],[2015,9,4,1,59,59],
          '2015032722:01:00','2015032801:01:00','2015090322:59:59','2015090401:59:59' ],
        [ [2015,9,3,23,0,0],[2015,9,4,1,0,0],'+02:00:00',[2,0,0],
          'EET',0,[2016,3,25,22,0,59],[2016,3,26,0,0,59],
          '2015090323:00:00','2015090401:00:00','2016032522:00:59','2016032600:00:59' ],
     ],
   2016 =>
     [
        [ [2016,3,25,22,1,0],[2016,3,26,1,1,0],'+03:00:00',[3,0,0],
          'EEST',1,[2016,9,1,22,59,59],[2016,9,2,1,59,59],
          '2016032522:01:00','2016032601:01:00','2016090122:59:59','2016090201:59:59' ],
        [ [2016,9,1,23,0,0],[2016,9,2,1,0,0],'+02:00:00',[2,0,0],
          'EET',0,[2017,3,24,22,0,59],[2017,3,25,0,0,59],
          '2016090123:00:00','2016090201:00:00','2017032422:00:59','2017032500:00:59' ],
     ],
   2017 =>
     [
        [ [2017,3,24,22,1,0],[2017,3,25,1,1,0],'+03:00:00',[3,0,0],
          'EEST',1,[2017,8,31,22,59,59],[2017,9,1,1,59,59],
          '2017032422:01:00','2017032501:01:00','2017083122:59:59','2017090101:59:59' ],
        [ [2017,8,31,23,0,0],[2017,9,1,1,0,0],'+02:00:00',[2,0,0],
          'EET',0,[2018,3,30,22,0,59],[2018,3,31,0,0,59],
          '2017083123:00:00','2017090101:00:00','2018033022:00:59','2018033100:00:59' ],
     ],
   2018 =>
     [
        [ [2018,3,30,22,1,0],[2018,3,31,1,1,0],'+03:00:00',[3,0,0],
          'EEST',1,[2018,9,6,22,59,59],[2018,9,7,1,59,59],
          '2018033022:01:00','2018033101:01:00','2018090622:59:59','2018090701:59:59' ],
        [ [2018,9,6,23,0,0],[2018,9,7,1,0,0],'+02:00:00',[2,0,0],
          'EET',0,[2019,3,29,22,0,59],[2019,3,30,0,0,59],
          '2018090623:00:00','2018090701:00:00','2019032922:00:59','2019033000:00:59' ],
     ],
   2019 =>
     [
        [ [2019,3,29,22,1,0],[2019,3,30,1,1,0],'+03:00:00',[3,0,0],
          'EEST',1,[2019,9,5,22,59,59],[2019,9,6,1,59,59],
          '2019032922:01:00','2019033001:01:00','2019090522:59:59','2019090601:59:59' ],
        [ [2019,9,5,23,0,0],[2019,9,6,1,0,0],'+02:00:00',[2,0,0],
          'EET',0,[2020,3,27,22,0,59],[2020,3,28,0,0,59],
          '2019090523:00:00','2019090601:00:00','2020032722:00:59','2020032800:00:59' ],
     ],
   2020 =>
     [
        [ [2020,3,27,22,1,0],[2020,3,28,1,1,0],'+03:00:00',[3,0,0],
          'EEST',1,[2020,9,3,22,59,59],[2020,9,4,1,59,59],
          '2020032722:01:00','2020032801:01:00','2020090322:59:59','2020090401:59:59' ],
        [ [2020,9,3,23,0,0],[2020,9,4,1,0,0],'+02:00:00',[2,0,0],
          'EET',0,[2021,3,26,22,0,59],[2021,3,27,0,0,59],
          '2020090323:00:00','2020090401:00:00','2021032622:00:59','2021032700:00:59' ],
     ],
   2021 =>
     [
        [ [2021,3,26,22,1,0],[2021,3,27,1,1,0],'+03:00:00',[3,0,0],
          'EEST',1,[2021,9,2,22,59,59],[2021,9,3,1,59,59],
          '2021032622:01:00','2021032701:01:00','2021090222:59:59','2021090301:59:59' ],
        [ [2021,9,2,23,0,0],[2021,9,3,1,0,0],'+02:00:00',[2,0,0],
          'EET',0,[2022,3,25,22,0,59],[2022,3,26,0,0,59],
          '2021090223:00:00','2021090301:00:00','2022032522:00:59','2022032600:00:59' ],
     ],
   2022 =>
     [
        [ [2022,3,25,22,1,0],[2022,3,26,1,1,0],'+03:00:00',[3,0,0],
          'EEST',1,[2022,9,1,22,59,59],[2022,9,2,1,59,59],
          '2022032522:01:00','2022032601:01:00','2022090122:59:59','2022090201:59:59' ],
        [ [2022,9,1,23,0,0],[2022,9,2,1,0,0],'+02:00:00',[2,0,0],
          'EET',0,[2023,3,24,22,0,59],[2023,3,25,0,0,59],
          '2022090123:00:00','2022090201:00:00','2023032422:00:59','2023032500:00:59' ],
     ],
   2023 =>
     [
        [ [2023,3,24,22,1,0],[2023,3,25,1,1,0],'+03:00:00',[3,0,0],
          'EEST',1,[2023,8,31,22,59,59],[2023,9,1,1,59,59],
          '2023032422:01:00','2023032501:01:00','2023083122:59:59','2023090101:59:59' ],
        [ [2023,8,31,23,0,0],[2023,9,1,1,0,0],'+02:00:00',[2,0,0],
          'EET',0,[2024,3,29,22,0,59],[2024,3,30,0,0,59],
          '2023083123:00:00','2023090101:00:00','2024032922:00:59','2024033000:00:59' ],
     ],
   2024 =>
     [
        [ [2024,3,29,22,1,0],[2024,3,30,1,1,0],'+03:00:00',[3,0,0],
          'EEST',1,[2024,9,5,22,59,59],[2024,9,6,1,59,59],
          '2024032922:01:00','2024033001:01:00','2024090522:59:59','2024090601:59:59' ],
        [ [2024,9,5,23,0,0],[2024,9,6,1,0,0],'+02:00:00',[2,0,0],
          'EET',0,[2025,3,28,22,0,59],[2025,3,29,0,0,59],
          '2024090523:00:00','2024090601:00:00','2025032822:00:59','2025032900:00:59' ],
     ],
   2025 =>
     [
        [ [2025,3,28,22,1,0],[2025,3,29,1,1,0],'+03:00:00',[3,0,0],
          'EEST',1,[2025,9,4,22,59,59],[2025,9,5,1,59,59],
          '2025032822:01:00','2025032901:01:00','2025090422:59:59','2025090501:59:59' ],
        [ [2025,9,4,23,0,0],[2025,9,5,1,0,0],'+02:00:00',[2,0,0],
          'EET',0,[2026,3,27,22,0,59],[2026,3,28,0,0,59],
          '2025090423:00:00','2025090501:00:00','2026032722:00:59','2026032800:00:59' ],
     ],
   2026 =>
     [
        [ [2026,3,27,22,1,0],[2026,3,28,1,1,0],'+03:00:00',[3,0,0],
          'EEST',1,[2026,9,3,22,59,59],[2026,9,4,1,59,59],
          '2026032722:01:00','2026032801:01:00','2026090322:59:59','2026090401:59:59' ],
        [ [2026,9,3,23,0,0],[2026,9,4,1,0,0],'+02:00:00',[2,0,0],
          'EET',0,[2027,3,26,22,0,59],[2027,3,27,0,0,59],
          '2026090323:00:00','2026090401:00:00','2027032622:00:59','2027032700:00:59' ],
     ],
   2027 =>
     [
        [ [2027,3,26,22,1,0],[2027,3,27,1,1,0],'+03:00:00',[3,0,0],
          'EEST',1,[2027,9,2,22,59,59],[2027,9,3,1,59,59],
          '2027032622:01:00','2027032701:01:00','2027090222:59:59','2027090301:59:59' ],
        [ [2027,9,2,23,0,0],[2027,9,3,1,0,0],'+02:00:00',[2,0,0],
          'EET',0,[2028,3,24,22,0,59],[2028,3,25,0,0,59],
          '2027090223:00:00','2027090301:00:00','2028032422:00:59','2028032500:00:59' ],
     ],
   2028 =>
     [
        [ [2028,3,24,22,1,0],[2028,3,25,1,1,0],'+03:00:00',[3,0,0],
          'EEST',1,[2028,8,31,22,59,59],[2028,9,1,1,59,59],
          '2028032422:01:00','2028032501:01:00','2028083122:59:59','2028090101:59:59' ],
        [ [2028,8,31,23,0,0],[2028,9,1,1,0,0],'+02:00:00',[2,0,0],
          'EET',0,[2029,3,30,22,0,59],[2029,3,31,0,0,59],
          '2028083123:00:00','2028090101:00:00','2029033022:00:59','2029033100:00:59' ],
     ],
   2029 =>
     [
        [ [2029,3,30,22,1,0],[2029,3,31,1,1,0],'+03:00:00',[3,0,0],
          'EEST',1,[2029,9,6,22,59,59],[2029,9,7,1,59,59],
          '2029033022:01:00','2029033101:01:00','2029090622:59:59','2029090701:59:59' ],
        [ [2029,9,6,23,0,0],[2029,9,7,1,0,0],'+02:00:00',[2,0,0],
          'EET',0,[2030,3,29,22,0,59],[2030,3,30,0,0,59],
          '2029090623:00:00','2029090701:00:00','2030032922:00:59','2030033000:00:59' ],
     ],
   2030 =>
     [
        [ [2030,3,29,22,1,0],[2030,3,30,1,1,0],'+03:00:00',[3,0,0],
          'EEST',1,[2030,9,5,22,59,59],[2030,9,6,1,59,59],
          '2030032922:01:00','2030033001:01:00','2030090522:59:59','2030090601:59:59' ],
        [ [2030,9,5,23,0,0],[2030,9,6,1,0,0],'+02:00:00',[2,0,0],
          'EET',0,[2031,3,28,22,0,59],[2031,3,29,0,0,59],
          '2030090523:00:00','2030090601:00:00','2031032822:00:59','2031032900:00:59' ],
     ],
   2031 =>
     [
        [ [2031,3,28,22,1,0],[2031,3,29,1,1,0],'+03:00:00',[3,0,0],
          'EEST',1,[2031,9,4,22,59,59],[2031,9,5,1,59,59],
          '2031032822:01:00','2031032901:01:00','2031090422:59:59','2031090501:59:59' ],
        [ [2031,9,4,23,0,0],[2031,9,5,1,0,0],'+02:00:00',[2,0,0],
          'EET',0,[2032,3,26,22,0,59],[2032,3,27,0,0,59],
          '2031090423:00:00','2031090501:00:00','2032032622:00:59','2032032700:00:59' ],
     ],
);

%LastRule      = (
   'zone'   => {
                'dstoff' => '+03:00:00',
                'stdoff' => '+02:00:00',
               },
   'rules'  => {
                '03' => {
                         'flag'    => 'last',
                         'dow'     => '6',
                         'num'     => '0',
                         'type'    => 'w',
                         'time'    => '00:01:00',
                         'isdst'   => '1',
                         'abb'     => 'EEST',
                        },
                '09' => {
                         'flag'    => 'ge',
                         'dow'     => '5',
                         'num'     => '1',
                         'type'    => 'w',
                         'time'    => '02:00:00',
                         'isdst'   => '0',
                         'abb'     => 'EET',
                        },
               },
);

1;