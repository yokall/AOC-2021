#!/usr/bin/perl

use Test2::V0;

use FindBin;

use lib "$FindBin::Bin/../../lib";

use SevenSegment::NoteEntry;

# 2	    -> ab		-> a=[cdefg], b=[cdefg], c=[ab], d=[cdefg], e=[cdefg], f=[ab], g=[cdefg]    # set segments 'c' & 'f' options to pair ex. 'ab'

# 3	    -> dab		-> a=[d], b=[cefg], c=[ab], d=[cefg], e=[cefg], f=[ab], g=[cefg]            # whichever wire that isn't in 'c' & 'f' options is segment 'a' ex. 'd'

# 4	    -> eafb		-> a=[d], b=[ef], c=[ab], d=[ef], e=[cg], f=[ab], g=[cg]                    # the pair that isn't in 'c' & 'f' options are the 'b' & 'd' options

# 5.1	-> cdfbe	-> a=[d], b=[ef], c=[a], d=[ef], e=[cg], f=[b], g=[cg]				        # because this has the 'b' & 'd' options and is 5 chars long, it has to be 5.
# 													                                            # therefore whatever the pair we have for c and f is, we know
# 												                                            	# f is in this group and c is the other. In this example we were able to assign the pair 'ab' to c & f
# 											                                            		# f=b so c=a

# 5.2	-> gcdfa	-> a=[d], b=[e], c=[a], d=[f], e=[cg], f=[b], g=[cg]		        		# because this has 1 of the 'b' & 'd' options and 1 of the 'c' & 'f' options and is 5 chars long it has to be 2,
# 												                                            	# therefore whatever the pair we have for c and f are we know c is in this group and f is the other
# 												                                            	# and whatever the pair we have for b and d are we know d is in this group and b is the other
# 											                                            		# In this example we were able to assign the pair 'ab' to c & f
# 												                                            	# f=b so c=a
# 												                                            	# whatever the pair we have for b and d are we know d is in this group and b is the other.
# 												                                            	# d=f so b=e

# 5.3	-> fbcad	-> a=[d], b=[e], c=[a], d=[f], e=[cg], f=[b], g=[cg]	        			# because this has the 'c' & 'f' options and is 5 chars long it has to be 3,
# 												                                            	# therefore whatever the pair we have for b and d is, we know
# 												                                            	# d is in this group and b is the other. In this example we were able to assign the pair 'ef' to b & d
# 												                                            	# d=f so b=e

# 6.1	-> cefabd	-> a=[d], b=[e], c=[a], d=[f], e=[g], f=[b], g=[c]		            		# because this has 'a', 'b' & 'd', 'c' & 'f' and is 6 chars long it has to be 9,
# 											                                            		# therefore whatever letter is left is assigned to g and the other letter is e
# 												                                            	# g=c so e=g

# 6.2	-> cdfgeb	-> a=[d], b=[e], c=[a], d=[f], e=[cg], f=[b], g=[cg]                        # because this has 'a', 'b' & 'd' and is 6 chars long it has to be 6,
# therefore we cant get any further as both 'e' & 'g' are present

# 6.3	-> cagedb	-> a=[d], b=[e], c=[a], d=[f], e=[cg], f=[b], g=[cg]                        # because this has 'a', 'c' & 'f' and is 6 chars long it has to be 0,
#                                                                                               # therefore we cant get any further as both 'e' & 'g' are present

#   0:      1:      2:      3:      4:
#  aaaa    ....    aaaa    aaaa    ....
# b    c  .    c  .    c  .    c  b    c
# b    c  .    c  .    c  .    c  b    c
#  ....    ....    dddd    dddd    dddd
# e    f  .    f  e    .  .    f  .    f
# e    f  .    f  e    .  .    f  .    f
#  gggg    ....    gggg    gggg    ....

#   5:      6:      7:      8:      9:
#  aaaa    aaaa    aaaa    aaaa    aaaa
# b    .  b    .  .    c  b    c  b    c
# b    .  b    .  .    c  b    c  b    c
#  dddd    dddd    ....    dddd    dddd
# .    f  e    f  .    f  e    f  .    f
# .    f  e    f  .    f  e    f  .    f
#  gggg    gggg    ....    gggg    gggg

subtest
    'deduce_segment_mappings should figure out the segment mappings between the wires and the segments'
    => sub {
    my $unique_signal_patterns = [
        'acedgfb', 'cdfbe', 'gcdfa',  'fbcad', 'dab', 'cefabd',
        'cdfgeb',  'eafb',  'cagedb', 'ab',
    ];

    my $four_digits = [ 'cdfeb', 'fcadb', 'cdfeb', 'cdbaf', ];

    my $note_entry = SevenSegment::NoteEntry->new(
        unique_signal_patterns => $unique_signal_patterns,
        four_digits            => $four_digits
    );

    $note_entry->deduce_segment_mappings();

    my $expected_segment_mappings = {
        a => 'c',
        b => 'f',
        c => 'g',
        d => 'a',
        e => 'b',
        f => 'd',
        g => 'e',
    };

    is( $note_entry->segment_mappings, $expected_segment_mappings );
    };

done_testing();
