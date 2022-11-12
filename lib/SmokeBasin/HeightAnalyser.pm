package SmokeBasin::HeightAnalyser;

sub low_point {
    my ( $height_map, $x, $y ) = @_;

    my $point       = _get_point( $height_map, $x,     $y );
    my $above_point = _get_point( $height_map, $x,     $y - 1 );
    my $right_point = _get_point( $height_map, $x + 1, $y );
    my $below_point = _get_point( $height_map, $x,     $y + 1 );
    my $left_point  = _get_point( $height_map, $x - 1, $y );

    return 1
      if ( ( $above_point eq undef || $point < $above_point )
        && ( $right_point eq undef || $point < $right_point )
        && ( $below_point eq undef || $point < $below_point )
        && ( $left_point eq undef  || $point < $left_point ) );

    return 0;
}

sub _get_point {
    my ( $height_map, $x, $y ) = @_;

    return undef if ( $x < 0 || $y < 0 );

    return $height_map->[$y]->[$x];
}

1;
