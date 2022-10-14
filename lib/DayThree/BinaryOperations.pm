package DayThree::BinaryOperations;

use strict;
use warnings;

sub create_binary_number_from_least_common_bit {
    my $list_of_binary_numbers = shift;
    my $position               = shift;

    my %bit_counts;

    foreach my $binary_number ( @{$list_of_binary_numbers} ) {
        my @chars = split( //, $binary_number );
        my $start = $position // 0;

        # uncoverable condition false
        my $limit = $position // $#chars;

        for ( my $i = $start ; $i <= $limit ; $i++ ) {
            $bit_counts{$i} += $chars[$i];
        }
    }

    my $number_of_binary_numbers      = scalar( @{$list_of_binary_numbers} );
    my $half_number_of_binary_numbers = $number_of_binary_numbers / 2;
    my $result;
    foreach my $position ( sort { $a <=> $b } keys %bit_counts ) {
        $result .=
          ( int( $bit_counts{$position} ) < $half_number_of_binary_numbers )
          ? 1
          : 0;
    }

    return $result;
}

sub invert_binary_number {
    my $binary_number = shift;

    my $inverted_binary_number;

    foreach my $char ( split( //, $binary_number ) ) {
        $inverted_binary_number .= $char ? 0 : 1;
    }

    return $inverted_binary_number;
}

sub binary_to_decimal {
    my $binary_number = shift;

    return oct( "0b" . $binary_number );
}

sub filter_by_bit {
    my $list_of_binary_numbers = shift;
    my $position               = shift;
    my $bit_value              = shift;

    my @filtered_list;
    foreach my $binary_number ( @{$list_of_binary_numbers} ) {
        if ( substr( $binary_number, $position, 1 ) eq $bit_value ) {
            push @filtered_list, $binary_number;
        }
    }

    return \@filtered_list;
}

1;
