#!/usr/bin/env perl

use strict;
use warnings;

use File::Basename;
use FindBin;

use lib "$FindBin::Bin/../lib";

use Common::FileReader;
use DayTwo::MovementProcessor;

my $depths
    = Common::FileReader::read_file_to_array(
    dirname(__FILE__) . '/../files/02_puzzle_input.txt' );

my $part_one_result = DayTwo::MovementProcessor::part_one($depths);

warn "Part one result: $part_one_result";

my $part_two_result = DayTwo::MovementProcessor::part_two($depths);

warn "Part two result: $part_two_result";

