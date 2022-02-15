#!/usr/bin/env perl

use strict;
use warnings;

use lib 'lib';

use DayTwo::MovementProcessor;
use DayTwo::FileReader;

my $depths = DayTwo::FileReader::read_file_to_array('/home/colin/AOC-2021/day-02/files/puzzle_input.txt');

my $part_one_result = DayTwo::MovementProcessor::part_one($depths);

warn "Part one result: $part_one_result";

my $part_two_result = DayTwo::MovementProcessor::part_two($depths);

warn "Part one result: $part_two_result";

