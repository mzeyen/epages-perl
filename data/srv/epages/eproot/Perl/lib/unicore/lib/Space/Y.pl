# !!!!!!!   DO NOT EDIT THIS FILE   !!!!!!!
# This file is machine-generated by lib/unicore/mktables from the Unicode
# database, Version 5.2.0.  Any changes made here will be lost!

# !!!!!!!   INTERNAL PERL USE ONLY   !!!!!!!
# This file is for internal use by the Perl program only.  The format and even
# the name or existence of this file are subject to change without notice.
# Don't use it directly.

# This file returns the 26 code points in Unicode Version 5.2.0 that match
# any of the following regular expression constructs:
#
#         \p{White_Space=Yes}
#         \p{WSpace=Y}
#         \p{Space=T}
#         \p{Is_White_Space=True}
#         \p{Is_WSpace=Yes}
#         \p{Is_Space=Y}
#
#         \p{White_Space}
#         \p{Is_White_Space}
#         \p{WSpace}
#         \p{Is_WSpace}
#
#         \p{Space}
#         \p{Is_Space}
#
#     Meaning: \s including beyond ASCII plus vertical tab
#
# perluniprops.pod should be consulted for the syntax rules for any of these,
# including if adding or subtracting white space, underscore, and hyphen
# characters matters or doesn't matter, and other permissible syntactic
# variants.  Upper/lower case distinctions never matter.
#
# A colon can be substituted for the equals sign, and anything to the left of
# the equals (or colon) can be combined with anything to the right.  Thus,
# for example,
#         \p{Is_Space: Yes}
# is also valid.
#
# The format of the lines of this file is: START\tSTOP\twhere START is the
# starting code point of the range, in hex; STOP is the ending point, or if
# omitted, the range has just one code point.  Numbers in comments in
# [brackets] indicate how many code points are in the range.

return <<'END';
0009    000D     # [5]
0020
0085
00A0
1680
180E
2000    200A     # [11]
2028    2029     # [2]
202F
205F
3000
END
