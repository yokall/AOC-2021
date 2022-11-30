package SevenSegment::NoteEntry;

use Moose;

has 'unique_signal_patterns' => (
    is  => 'ro',
    isa => 'ArrayRef[Str]',
);

has 'four_digits' => (
    is  => 'ro',
    isa => 'ArrayRef[Str]',
);

has 'segment_mappings' => (
    is      => 'rw',
    isa     => 'HashRef',
    default => sub {
        return {
            a => [ 'a', 'b', 'c', 'd', 'e', 'f', 'g' ],
            b => [ 'a', 'b', 'c', 'd', 'e', 'f', 'g' ],
            c => [ 'a', 'b', 'c', 'd', 'e', 'f', 'g' ],
            d => [ 'a', 'b', 'c', 'd', 'e', 'f', 'g' ],
            e => [ 'a', 'b', 'c', 'd', 'e', 'f', 'g' ],
            f => [ 'a', 'b', 'c', 'd', 'e', 'f', 'g' ],
            g => [ 'a', 'b', 'c', 'd', 'e', 'f', 'g' ],
        };
    }
);

sub deduce_segment_mappings {
    my $self = shift;

    my @sorted_unique_signal_patterns
        = sort { length $a <=> length $b } @{ $self->unique_signal_patterns };

    foreach my $unique_signal_pattern (@sorted_unique_signal_patterns) {
        my @wires        = split( //, $unique_signal_pattern );
        my %wires_lookup = map { $_ => 1 } @wires;

        if ( length($unique_signal_pattern) == 2 ) {
            $self->segment_mappings->{c} = \@wires;
            my @copy = @wires;
            $self->segment_mappings->{f} = \@copy;
        }
        elsif ( length($unique_signal_pattern) == 3 ) {
            foreach my $wire (@wires) {
                unless (
                    grep( /^$wire$/, @{ $self->segment_mappings->{c} } ) )
                {
                    $self->segment_mappings->{a} = [$wire];
                    last;
                }
            }
        }
        elsif ( length($unique_signal_pattern) == 4 ) {
            my @bd_pair;
            foreach my $wire (@wires) {
                unless (
                    grep( /^$wire$/, @{ $self->segment_mappings->{c} } ) )
                {
                    push( @bd_pair, $wire );
                }
            }

            $self->segment_mappings->{b} = \@bd_pair;
            my @copy = @bd_pair;
            $self->segment_mappings->{d} = \@copy;
        }
        elsif ( length($unique_signal_pattern) == 5 ) {
            my @bd_options
                = @{ _get_options_for_wire_pair( $self, 'b', 'd' ) };
            my @cf_options
                = @{ _get_options_for_wire_pair( $self, 'c', 'f' ) };

            # if wires contains the 2 possibilities for 'b' & 'd',
            # whichever letter of the pair assigned to 'c' & 'f' is present
            # assign it to 'f' and the other to 'c'
            if (   exists( $wires_lookup{ $bd_options[0] } )
                && exists( $wires_lookup{ $bd_options[1] } ) )
            {
                my $f_mapping
                    = exists( $wires_lookup{ $cf_options[0] } )
                    ? $cf_options[0]
                    : $cf_options[1];
                my $c_mapping
                    = exists( $wires_lookup{ $cf_options[0] } )
                    ? $cf_options[1]
                    : $cf_options[0];

                $self->segment_mappings->{f} = [$f_mapping];
                $self->segment_mappings->{c} = [$c_mapping];
            }

            # if wires contains 1 of the 2 possibilities for 'b' & 'd'
            # and 1 of the 2 possibilities for 'c' & 'f'
            # whichever wire of the 'b' & 'd' pair is present,
            # assign it to 'd' and the other wire to 'b'
            # whichever wire of the 'c' & 'f' pair is present,
            # assign it to 'c' and the other wire to 'f'
            elsif (
                (   exists( $wires_lookup{ $bd_options[0] } )
                    xor exists( $wires_lookup{ $bd_options[1] } )
                )
                && ( exists( $wires_lookup{ $cf_options[0] } )
                    xor exists( $wires_lookup{ $cf_options[1] } ) )
                )
            {
                my $d_mapping
                    = exists( $wires_lookup{ $bd_options[0] } )
                    ? $bd_options[0]
                    : $bd_options[1];
                my $b_mapping
                    = exists( $wires_lookup{ $bd_options[0] } )
                    ? $bd_options[1]
                    : $bd_options[0];

                $self->segment_mappings->{b} = [$b_mapping];
                $self->segment_mappings->{d} = [$d_mapping];

                my $c_mapping
                    = exists( $wires_lookup{ $cf_options[0] } )
                    ? $cf_options[0]
                    : $cf_options[1];
                my $f_mapping
                    = exists( $wires_lookup{ $cf_options[0] } )
                    ? $cf_options[1]
                    : $cf_options[0];

                $self->segment_mappings->{c} = [$c_mapping];
                $self->segment_mappings->{f} = [$f_mapping];
            }

            # if wires contains the 2 possibilities for 'c' & 'f',
            # whichever letter of the pair assigned to 'b' & 'd' is present
            # assign it to 'd' and the other to 'b'
            elsif (exists( $wires_lookup{ $cf_options[0] } )
                && exists( $wires_lookup{ $cf_options[1] } ) )
            {
                my $d_mapping
                    = exists( $wires_lookup{ $bd_options[0] } )
                    ? $bd_options[0]
                    : $bd_options[1];
                my $b_mapping
                    = exists( $wires_lookup{ $bd_options[0] } )
                    ? $bd_options[1]
                    : $bd_options[0];

                $self->segment_mappings->{b} = [$b_mapping];
                $self->segment_mappings->{d} = [$d_mapping];
            }
        }
        elsif ( length($unique_signal_pattern) == 6 ) {
            my @bd_options
                = @{ _get_options_for_wire_pair( $self, 'b', 'd' ) };
            my @cf_options
                = @{ _get_options_for_wire_pair( $self, 'c', 'f' ) };

          # if wires contains the 2 possibilities for 'b' & 'd' and 'c' & 'f',
          # whichever letter is not 1 of these wires or the wire for 'a'
          # assign it to 'g' and the other to 'e'
            if (   exists( $wires_lookup{ $bd_options[0] } )
                && exists( $wires_lookup{ $bd_options[1] } )
                && exists( $wires_lookup{ $cf_options[0] } )
                && exists( $wires_lookup{ $cf_options[1] } ) )
            {
                _filter_known_wires_from_e_and_g($self);

                my %eg_options_lookup = map { $_ => 1 } (
                    @{ $self->segment_mappings->{e} },
                    @{ $self->segment_mappings->{g} }
                );
                my @eg_options = keys %eg_options_lookup;

                my $g_mapping
                    = exists( $wires_lookup{ $eg_options[0] } )
                    ? $eg_options[0]
                    : $eg_options[1];

                my $e_mapping
                    = exists( $wires_lookup{ $eg_options[0] } )
                    ? $eg_options[1]
                    : $eg_options[0];

                $self->segment_mappings->{e} = [$e_mapping];
                $self->segment_mappings->{g} = [$g_mapping];
            }
        }
    }

    my %flipped_hash = map { $self->segment_mappings->{$_}->[0] => $_ }
        keys %{ $self->segment_mappings };

    $self->segment_mappings( \%flipped_hash );
}

sub _get_options_for_wire_pair {
    my ( $self, $wire1, $wire2 ) = @_;

    my %options_lookup = map { $_ => 1 } (
        @{ $self->segment_mappings->{$wire1} },
        @{ $self->segment_mappings->{$wire2} }
    );
    my @options = keys %options_lookup;

    return \@options;
}

sub _filter_known_wires_from_e_and_g {
    my $self = shift;

    my $a = $self->segment_mappings->{a}->[0];
    my $b = $self->segment_mappings->{b}->[0];
    my $c = $self->segment_mappings->{c}->[0];
    my $d = $self->segment_mappings->{d}->[0];
    my $f = $self->segment_mappings->{f}->[0];

    my @remaining_wires
        = grep( /^[^$a|$b|$c|$d|$f]$/, @{ $self->segment_mappings->{e} } );

    $self->segment_mappings->{e} = \@remaining_wires;
    my @temp = @remaining_wires;
    $self->segment_mappings->{g} = \@temp;
}

1;