#!/usr/bin/env perl

use strict;
use warnings;

use File::Basename;
use FindBin;

use lib "$FindBin::Bin/../lib";

use Common::FileReader;
use SevenSegment::InputParser;

my $puzzle_input = Common::FileReader::read_file_to_array(
    dirname(__FILE__) . '/../files/08_puzzle_input.txt' );

# my $puzzle_input = [
#     'be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe',
#     'edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc',
#     'fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg',
#     'fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb',
#     'aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea',
#     'fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb',
#     'dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe',
#     'bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef',
#     'egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb',
#     'gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce',
# ];

my $parsed_note_entries = SevenSegment::InputParser::parse($puzzle_input);

my $number_of_unique_segments = 0;
foreach my $note_entry ( @{$parsed_note_entries} ) {
    foreach my $digit ( @{ $note_entry->four_digits } ) {
        if (   length($digit) == 2
            || length($digit) == 3
            || length($digit) == 4
            || length($digit) == 7 )
        {
            $number_of_unique_segments++;
        }
    }
}

warn "Part 1 answer: $number_of_unique_segments";

my %digit_lookup = (
    cf      => 1,
    acf     => 7,
    bcdf    => 4,
    acdeg   => 2,
    acdfg   => 3,
    abdfg   => 5,
    abcefg  => 0,
    abdefg  => 6,
    abcdfg  => 9,
    abcdefg => 8,
);

my $total;
foreach my $note_entry ( @{$parsed_note_entries} ) {
    $note_entry->deduce_segment_mappings();

    my $output_value;
    foreach my $digit ( @{ $note_entry->four_digits } ) {
        my @mapped_values;
        foreach my $wire ( split( //, $digit ) ) {
            push( @mapped_values, $note_entry->segment_mappings->{$wire} );
        }
        my $mapped_value = join( '', sort(@mapped_values) );

        $output_value .= $digit_lookup{$mapped_value};
    }

    $total += $output_value;
}

warn "Part 2 answer: $total";
