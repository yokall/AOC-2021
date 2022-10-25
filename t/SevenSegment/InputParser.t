#!/usr/bin/perl

use Test2::V0;

use FindBin;

use lib "$FindBin::Bin/../../lib";

use SevenSegment::InputParser;

subtest 'parse should return the input as a list on note entries' => sub {
    my $input_note_entries
        = [
        'acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf'
        ];

    my $parsed_note_entries
        = SevenSegment::InputParser::parse($input_note_entries);

    my $parsed_note_entry = $parsed_note_entries->[0];

    isa_ok(
        $parsed_note_entry,
        ['SevenSegment::NoteEntry'],
        'parse note entry is a SevenSegment::NoteEntry'
    );

    my $expected_unique_signal_patterns = [
        'acedgfb', 'cdfbe', 'gcdfa',  'fbcad', 'dab', 'cefabd',
        'cdfgeb',  'eafb',  'cagedb', 'ab',
    ];

    is( $parsed_note_entry->unique_signal_patterns,
        $expected_unique_signal_patterns );

    my $expected_four_digits = [ 'cdfeb', 'fcadb', 'cdfeb', 'cdbaf', ];

    is( $parsed_note_entry->four_digits, $expected_four_digits );
};

done_testing();
