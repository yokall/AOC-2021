package LaternFish::Simulator;

use List::Util qw(sum);
use Moose;

has 'timer_groups' => (
    is  => 'rw',
    isa => 'HashRef[Int]',
);

sub load_starting_school {
    my ( $self, $starting_fish ) = @_;

    $self->timer_groups( {} );

    foreach my $fish ( @{$starting_fish} ) {
        $self->timer_groups->{$fish}++;
    }
}

sub simulate_days {
    my ( $self, $number_of_days ) = @_;

    for ( 1 .. $number_of_days ) {
        my $number_of_reset_fish;

        foreach my $timer ( sort keys %{ $self->timer_groups } ) {
            my $count = $self->timer_groups->{$timer};

            if ( $timer == 0 ) {
                $number_of_reset_fish = $count;
            }
            else {
                $self->timer_groups->{ $timer - 1 } = $count;
                $self->timer_groups->{$timer} = 0;
            }
        }

        if ($number_of_reset_fish) {
            $self->timer_groups->{8} = $number_of_reset_fish;
            $self->timer_groups->{6} += $number_of_reset_fish;
        }
    }
}

sub fish_count {
    my $self = shift;

    return sum( values %{ $self->timer_groups } );
}

1;
