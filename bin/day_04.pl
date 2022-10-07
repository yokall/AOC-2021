#!/usr/bin/env perl

use strict;
use warnings;

use lib '../lib';

use Common::FileReader;
use Bingo::InputParser;
use Bingo::Games;

my $puzzle_input
    = Common::FileReader::read_file_to_array('../files/04_puzzle_input.txt');

my $parsed_input
    = Bingo::InputParser::parse_input_file_content($puzzle_input);

my $games = Bingo::Games->new( boards => $parsed_input->{'boards'} );

my $results = $games->call_numbers( $parsed_input->{'called_numbers'} );

warn "Part one result: " . $results->{'first_winner'};
warn "Part two result: " . $results->{'last_winner'};
