#!/usr/bin/env perl

use strict;
use warnings;

use lib 'lib';

use DayOne::DepthProcessor;
use DayOne::FileReader;

my $depths = DayOne::FileReader::read_file_to_array('/home/colin/AOC-2021/day-01/files/puzzle_input.txt');

my $part_one_result = DayOne::DepthProcessor::part_one($depths);

warn "Part one result: $part_one_result";

my $part_two_result = DayOne::DepthProcessor::part_two($depths);

warn "Part one result: $part_two_result";

