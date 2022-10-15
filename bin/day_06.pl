#!/usr/bin/env perl

use strict;
use warnings;

use List::Util qw(sum);

my @fish = (
    2, 1, 2, 1, 5, 1, 5, 1, 2, 2, 1, 1, 5, 1, 4, 4, 4, 3, 1, 2, 2, 3, 4, 1,
    1, 5, 1, 1, 4, 2, 5, 5, 5, 1, 1, 4, 5, 4, 1, 1, 4, 2, 1, 4, 1, 2, 2, 5,
    1, 1, 5, 1, 1, 3, 4, 4, 1, 2, 3, 1, 5, 5, 4, 1, 4, 1, 2, 1, 5, 1, 1, 1,
    3, 4, 1, 1, 5, 1, 5, 1, 1, 5, 1, 1, 4, 3, 2, 4, 1, 4, 1, 5, 3, 3, 1, 5,
    1, 3, 1, 1, 4, 1, 4, 5, 2, 3, 1, 1, 1, 1, 3, 1, 2, 1, 5, 1, 1, 5, 1, 1,
    1, 1, 4, 1, 4, 3, 1, 5, 1, 1, 5, 4, 4, 2, 1, 4, 5, 1, 1, 3, 3, 1, 1, 4,
    2, 5, 5, 2, 4, 1, 4, 5, 4, 5, 3, 1, 4, 1, 5, 2, 4, 5, 3, 1, 3, 2, 4, 5,
    4, 4, 1, 5, 1, 5, 1, 2, 2, 1, 4, 1, 1, 4, 2, 2, 2, 4, 1, 1, 5, 3, 1, 1,
    5, 4, 4, 1, 5, 1, 3, 1, 3, 2, 2, 1, 1, 4, 1, 4, 1, 2, 2, 1, 1, 3, 5, 1,
    2, 1, 3, 1, 4, 5, 1, 3, 4, 1, 1, 1, 1, 4, 3, 3, 4, 5, 1, 1, 1, 1, 1, 2,
    4, 5, 3, 4, 2, 1, 1, 1, 3, 3, 1, 4, 1, 1, 4, 2, 1, 5, 1, 1, 2, 3, 4, 2,
    5, 1, 1, 1, 5, 1, 1, 4, 1, 2, 4, 1, 1, 2, 4, 3, 4, 2, 3, 1, 1, 2, 1, 5,
    4, 2, 3, 5, 1, 2, 3, 1, 2, 2, 1, 4
);

# my @fish = ( 3, 4, 3, 1, 2 );

my $number_of_fish = simulate_fish( \@fish, 80 );

warn "Part 1 result: $number_of_fish";

$number_of_fish = simulate_fish( \@fish, 256 );

warn "Part 2 result: $number_of_fish";

sub simulate_fish {
    my $fish_ref       = shift;
    my $number_of_days = shift;

    my @fish = @$fish_ref;

    my %fish_timers;
    foreach my $fish (@fish) {
        $fish_timers{$fish}++;
    }

    for ( 1 .. $number_of_days ) {
        my $number_of_reset_fish;

        foreach my $timer ( sort { $a <=> $b } keys %fish_timers ) {
            my $count = $fish_timers{$timer};

            if ( $timer == 0 ) {
                $number_of_reset_fish = $count;
            }
            else {
                $fish_timers{ $timer - 1 } = $count;
                $fish_timers{$timer} = 0;
            }
        }

        if ($number_of_reset_fish) {
            $fish_timers{8} = $number_of_reset_fish;
            $fish_timers{6} += $number_of_reset_fish;
        }
    }

    return sum( values %fish_timers );
}
