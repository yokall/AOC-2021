#!/usr/bin/perl

use Test2::V0;

use lib 'lib';

use Hydrothermal::LineDefinitionParser;

subtest 'parse_input' => sub {
    my $input = [ '0,9 -> 5,9', ];

    my @lines = @{ Hydrothermal::LineDefinitionParser::parse_input($input) };

    my $expected_points = [
        { x => 0, y => 9 },
        { x => 1, y => 9 },
        { x => 2, y => 9 },
        { x => 3, y => 9 },
        { x => 4, y => 9 },
        { x => 5, y => 9 },
    ];

    is( scalar(@lines), 1, 'there should be 1 line returned' );

    isa_ok( $lines[0], ["Hydrothermal::Line"],
        'line should be a Hydrothermal::Line' );

    my $actual_points = $lines[0]->points;

    is( $actual_points, $expected_points,
        'points have been calculated correctly' );
};

done_testing();
