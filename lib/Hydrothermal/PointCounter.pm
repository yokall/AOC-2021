package Hydrothermal::PointCounter;

use strict;
use warnings;

sub tally_points {
    my $lines             = shift;
    my $include_diagonals = shift;

    my %point_counts;
    foreach my $line (@$lines) {
        next if ( $line->is_diagonal && !$include_diagonals );

        foreach my $point ( @{ $line->points } ) {
            $point_counts{ $point->{'x'} . ',' . $point->{'y'} }++;
        }
    }

    return \%point_counts;
}

sub count_overlaping_points {
    my $point_counts = shift;

    my $number_of_overlaps = 0;
    foreach my $count ( values %$point_counts ) {
        $number_of_overlaps++ if ( $count >= 2 );
    }

    return $number_of_overlaps;
}

1;
