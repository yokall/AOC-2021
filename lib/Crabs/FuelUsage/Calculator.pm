package Crabs::FuelUsage::Calculator;

use List::Util qw( min max );
use Moose;

has 'strategy' => (
    is      => 'rw',
    does    => 'Crabs::FuelUsage::Interface',
    handles => ['calculate_fuel_usage'],
);

sub calculate_most_fuel_efficient_position {
    my ( $self, $starting_positions ) = @_;

    my $left_most_position  = min( @{$starting_positions} );
    my $right_most_position = max( @{$starting_positions} );

    my %distance_fuel_costs;

    my @position_fuel_costs;
    foreach my $position ( $left_most_position .. $right_most_position ) {
        my $total_fuel_usage;
        foreach my $starting_position ( @{$starting_positions} ) {
            my $distance_to_converge = abs( $position - $starting_position );
            my $fuel_usage
                = exists( $distance_fuel_costs{$distance_to_converge} )
                ? $distance_fuel_costs{$distance_to_converge}
                : $self->strategy->calculate_fuel_usage(
                $distance_to_converge);

            $total_fuel_usage += $fuel_usage;

            $distance_fuel_costs{$distance_to_converge} = $fuel_usage;
        }

        push( @position_fuel_costs, $total_fuel_usage );
    }

    return min(@position_fuel_costs);
}

1;
