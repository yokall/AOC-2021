#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

use_ok("DayOne::DepthProcessor");

my $test_input = [
	199,
	200,
	208,
	210,
	200,
	207,
	240,
	269,
	260,
	263,
];

subtest 'part_one - should return 7 for the test input' => sub {
	is(DayOne::DepthProcessor::part_one($test_input), 7);
};

subtest 'part_two - should return 5 for the test input' => sub {
	is(DayOne::DepthProcessor::part_two($test_input), 5);
};

done_testing();
