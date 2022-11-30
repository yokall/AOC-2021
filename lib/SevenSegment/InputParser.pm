package SevenSegment::InputParser;

use strict;
use warnings;

use SevenSegment::NoteEntry;

sub parse {
    my $input_note_entries = shift;

    my @parsed_note_entries;
    foreach my $input_note_entry ( @{$input_note_entries} ) {
        my ( $raw_unique_signal_patterns, $raw_four_digits )
            = split( / \| /, $input_note_entry );

        my @unique_signal_patterns
            = split( / /, $raw_unique_signal_patterns );
        my @four_digits = split( / /, $raw_four_digits );

        my $parsed_note_entry = SevenSegment::NoteEntry->new(
            unique_signal_patterns => \@unique_signal_patterns,
            four_digits            => \@four_digits
        );

        push( @parsed_note_entries, $parsed_note_entry );
    }

    return \@parsed_note_entries;
}

1;
