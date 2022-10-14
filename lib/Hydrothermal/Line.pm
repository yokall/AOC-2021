package Hydrothermal::Line;

use Moose;

has 'start_point' => (
    is  => 'ro',
    isa => 'HashRef[Str]',
);

has 'end_point' => (
    is  => 'ro',
    isa => 'HashRef[Str]',
);

has 'points' => (
    is      => 'ro',
    lazy    => 1,
    builder => '_build_points',
);

has 'is_diagonal' => (
    is      => 'ro',
    isa     => 'Bool',
    lazy    => 1,
    builder => '_build_is_diagonal',
);

sub _build_points {
    my $self = shift;

    my @points;

    my $add_to_x =
        ( $self->start_point->{x} == $self->end_point->{x} ) ? 0
      : ( $self->start_point->{x} < $self->end_point->{x} )  ? 1
      :                                                        -1;
    my $add_to_y =
        ( $self->start_point->{y} == $self->end_point->{y} ) ? 0
      : ( $self->start_point->{y} < $self->end_point->{y} )  ? 1
      :                                                        -1;

    my $x = $self->start_point->{x};
    my $y = $self->start_point->{y};

    push( @points, { x => $x, y => $y } );

    do {
        $x += $add_to_x;
        $y += $add_to_y;

        push( @points, { x => $x, y => $y } );

    } while ( $x != $self->end_point->{x}
        || $y != $self->end_point->{y} );

    return \@points;
}

sub _build_is_diagonal {
    my $self = shift;

    return ( $self->start_point->{x} != $self->end_point->{x}
          && $self->start_point->{y} != $self->end_point->{y} );
}

1;
