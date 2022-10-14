package Hydrothermal::LineDefinitionParser;

use strict;
use warnings;

use Hydrothermal::Line;

sub parse_input {
    my $input = shift;

    my @lines;
    foreach my $line_definition (@$input) {
        my ( $start_x, $start_y, $end_x, $end_y )
            = $line_definition =~ /(\d+),(\d+) -> (\d+),(\d+)/;

        push(
            @lines,
            Hydrothermal::Line->new(
                start_point => { x => $start_x, y => $start_y },
                end_point   => { x => $end_x,   y => $end_y }
            )
        );
    }

    return \@lines;
}

1;
