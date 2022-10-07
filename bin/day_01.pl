#!/usr/bin/env perl

use strict;
use warnings;

use lib '../lib';

use Common::FileReader;
use DayOne::DepthProcessor;

my $depths = Common::FileReader::read_file_to_array('../files/01_puzzle_input.txt');

my $part_one_result = DayOne::DepthProcessor::part_one($depths);

warn "Part one result: $part_one_result";

my $part_two_result = DayOne::DepthProcessor::part_two($depths);

warn "Part two result: $part_two_result";

