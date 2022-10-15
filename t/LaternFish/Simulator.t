#!/usr/bin/perl

use Test2::V0;

use lib 'lib';

use LaternFish::Simulator;

subtest
  'load_starting_school should return the fish counts grouped by timer' => sub {
    my $starting_fish = [ 3, 4, 3, 1, 2 ];

    my $simulator = LaternFish::Simulator->new();

    $simulator->load_starting_school($starting_fish);

    my $expected_timer_groups = {
        1 => 1,
        2 => 1,
        3 => 2,
        4 => 1
    };

    is( $simulator->timer_groups, $expected_timer_groups );
  };

subtest
  'simulate_days should update the timer counts as fish age and reproduce' =>
  sub {
    my $starting_fish = [ 3, 4, 3, 1, 2 ];

    my $simulator = LaternFish::Simulator->new();

    $simulator->load_starting_school($starting_fish);

    my $number_of_days = 18;
    $simulator->simulate_days($number_of_days);

    my $expected_timer_groups = {
        0 => 3,
        1 => 5,
        2 => 3,
        3 => 2,
        4 => 2,
        5 => 1,
        6 => 5,
        7 => 1,
        8 => 4,
    };

    is( $simulator->timer_groups, $expected_timer_groups );
  };

subtest
  'fish_count should return the current number of fish from the timer groups'
  => sub {
    my $starting_fish = [ 3, 4, 3, 1, 2 ];

    my $simulator = LaternFish::Simulator->new();

    $simulator->load_starting_school($starting_fish);

    is( $simulator->fish_count(), 5 );
  };

done_testing();
