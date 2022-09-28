#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

use_ok("DayTwo::MovementProcessor");

my $test_input = [
	'forward 5',
	'down 5',
	'forward 8',
	'up 3',
	'down 8',
	'forward 2',
];

subtest 'part_one - should return 150 for the test input' => sub {
	is(DayTwo::MovementProcessor::part_one($test_input), 150);
};

subtest 'part_two - should return 900 for the test input' => sub {
	is(DayTwo::MovementProcessor::part_two($test_input), 900);
};

done_testing();
