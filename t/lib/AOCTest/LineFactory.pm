package AOCTest::LineFactory;

use strict;
use warnings;

use Hydrothermal::LineDefinitionParser;

sub lines {
    my $line_definitions = [ '0,9 -> 5,9', '0,9 -> 2,9', ];

    my @lines = @{ Hydrothermal::LineDefinitionParser::parse_input(
            $line_definitions) };

    return \@lines;
}

1;
