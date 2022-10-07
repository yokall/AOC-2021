package Bingo::InputParser;

use strict;
use warnings;

sub parse_input_file_content {
    my $input_content_ref = shift;

    my @input_content = @$input_content_ref;

    my @called_numbers = split( ',', $input_content[0] );

    my @boards;
    my @board;
    for ( my $i = 2; $i < scalar(@input_content); $i++ ) {
        my $line = $input_content[$i];

        if ( $line eq '' ) {
            my @board_copy = @board;
            push( @boards, \@board_copy );
            @board = ();
        }
        else {
            my @row_of_numbers = $line =~ /(\d+)/g;
            push( @board, \@row_of_numbers );
        }
    }

    push( @boards, \@board );

    return {
        called_numbers => \@called_numbers,
        boards         => \@boards
    };
}

1;
