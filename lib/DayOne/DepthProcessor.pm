package DayOne::DepthProcessor;

use strict;
use warnings;

sub part_one {
	my $depths_ref = shift;

	my @depths = @$depths_ref;

	my $times_depth_increases = 0;
	for (my $i = 1 ; $i <= $#depths ; $i++) {
		if ($depths[$i] > $depths[$i - 1]) {
			$times_depth_increases++;
		}
	}

	return $times_depth_increases;
}

sub part_two {
	my $depths_ref = shift;

	my @depths = @$depths_ref;

	my $times_depth_increases = 0;
	for (my $i = 3 ; $i <= $#depths ; $i++) {
		my $first_window_sum = $depths[$i - 3] + $depths[$i - 2] + $depths[$i - 1];
		my $second_window_sum = $depths[$i - 2] + $depths[$i - 1] + $depths[$i];
		if ($second_window_sum > $first_window_sum) {
			$times_depth_increases++;
		}
	}

	return $times_depth_increases;
}

1;
