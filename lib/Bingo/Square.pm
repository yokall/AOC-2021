package Bingo::Square;

use Moose;

has 'number' => (
    is  => 'ro',
    isa => 'Int',
);

has 'marked' => (
    is      => 'rw',
    default => 0,
    isa     => 'Bool',
    reader  => 'is_marked',
);

1;
