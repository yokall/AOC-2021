package Bingo::Games;

use Data::Dumper;

use Moose;
use Moose::Util::TypeConstraints;

use Bingo::Board;

subtype 'ListOfBoards', as 'ArrayRef[Bingo::Board]';

coerce 'ListOfBoards', from 'ArrayRef[ArrayRef[ArrayRef[Int]]]', via {
    my $board_definitions = $_;

    my @boards;
    foreach my $board_definition (@$board_definitions) {
        my $board = Bingo::Board->new( grid => $board_definition );

        push( @boards, $board );
    }

    return \@boards;
};

has 'boards' => (
    is     => 'ro',
    isa    => 'ListOfBoards',
    coerce => 1,
);

has 'first_winner' => (
    is      => 'rw',
    isa     => 'Int',
    default => 0,
);

has 'last_winner' => (
    is      => 'rw',
    isa     => 'Int',
    default => 0,
);

sub call_numbers {
    my ( $self, $numbers ) = @_;

    foreach my $number (@$numbers) {
        foreach my $board ( @{ $self->boards } ) {
            unless ( $board->has_won() ) {
                $board->mark_number($number);
                if ( $board->has_won() ) {
                    unless ( $self->first_winner ) {
                        $self->first_winner(
                            $board->sum_unmarked_squares() * $number );
                    }

                    $self->last_winner(
                        $board->sum_unmarked_squares() * $number );
                }
            }
        }
    }

    return {
        first_winner => $self->first_winner,
        last_winner  => $self->last_winner
    };
}

1;
