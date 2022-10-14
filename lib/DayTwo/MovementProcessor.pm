package DayTwo::MovementProcessor;

use strict;
use warnings;

sub part_one {
    my $movements = shift;

    my $horizontal_position = 0;
    my $depth               = 0;

    foreach my $movement (@$movements) {
        my ( $command, $value ) = split( ' ', $movement );

        # uncoverable branch false count:3
        if ( $command eq 'forward' ) {
            $horizontal_position += $value;
        }
        elsif ( $command eq 'down' ) {
            $depth += $value;
        }
        elsif ( $command eq 'up' ) {
            $depth -= $value;
        }
    }

    return $horizontal_position * $depth;
}

sub part_two {
    my $movements = shift;

    my $horizontal_position = 0;
    my $depth               = 0;
    my $aim                 = 0;

    foreach my $movement (@$movements) {
        my ( $command, $value ) = split( ' ', $movement );

        # uncoverable branch false count:3
        if ( $command eq 'forward' ) {
            $horizontal_position += $value;
            $depth               += $aim * $value;
        }
        elsif ( $command eq 'down' ) {
            $aim += $value;
        }
        elsif ( $command eq 'up' ) {
            $aim -= $value;
        }
    }

    return $horizontal_position * $depth;
}

1;
