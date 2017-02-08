package Algorithm::DataMatrix::Fill;

use strict;
use warnings;
use Carp;
use Data::Dumper;

sub borders {
	use integer;
	my ($w,$h,$regions,$dc,$dr) = @_;
	my @matrix;
	#warn "width = $w, height = $h, datacols = $dc, datarows = $dr, reg = $regions";
	$dc += 2;
	$dr += 2;
	if ($regions == 2) {
		for (0..1) {
			my $rt = $_ * $dr;
			my $rb = ($_+1) * $dr - 1;
			for (0..$w-1) {
				$matrix[$rt][$_] = 1;
				$matrix[$rb][$_] = $_ & 1;
			}
		}
		{
			my $cr = $dc - 1;
			for (0..$h-1) {
				$matrix[$_][$cr] = 1;
				$matrix[$_][0] = ($_ & 1) ? 0 : 1;
			}
		}
	} else {
		my $k = sqrt $regions;
		for (0..$k-1) {
			{
				my $rt = $_ * $dr;
				my $rb = ($_+1) * $dr - 1;
				for (0..$w-1) {
					$matrix[$rt][$_] = 1;
					$matrix[$rb][$_] = $_ & 1;
				}
			}
			{
				my $cl = $_ * $dc;
				my $cr = ($_+1) * $dc - 1;
				for (0..$h-1) {
					$matrix[$_][$cr] = 1;
					$matrix[$_][$cl] = ($_ & 1) ? 0 : 1;
				}
			}
		}
	}
	return \@matrix;
}

sub borders1 {
	my ($w,$h,$dc,$dr,$regions) = @_;
	my @matrix;
	#warn "width = $w, height = $h, datacols = $dc, datarows = $dr, reg = $regions";
	$dc += 2;
	$dr += 2;
	if ($regions == 2) {
		for (0..1) {
			my $rt = $_ * $dr;
			my $rb = ($_+1) * $dr - 1;
			for (0..$w-1) {
				$matrix[$rt][$_] = 1;
				$matrix[$rb][$_] = $_ & 1;
			}
		}
		{
			my $cr = $dc - 1;
			for (0..$h-1) {
				$matrix[$_][$cr] = 1;
				$matrix[$_][0] = ($_ & 1) ? 0 : 1;
			}
		}
	} else {
		my $k = sqrt $regions;
		for (0..$k-1) {
			{
				my $rt = $_ * $dr;
				my $rb = ($_+1) * $dr - 1;
				for (0..$w-1) {
					$matrix[$rt][$_] = 1;
					$matrix[$rb][$_] = $_ & 1;
				}
			}
			{
				my $cl = $_ * $dc;
				my $cr = ($_+1) * $dc - 1;
				for (0..$h-1) {
					$matrix[$_][$cr] = 1;
					$matrix[$_][$cl] = ($_ & 1) ? 0 : 1;
				}
			}
		}
	}
	return \@matrix;
}

sub fill1($$$) {
	my ($col,$row,$ai) = @_;
}

sub new {
	my $self = bless {}, shift;
	warn "new @_";
	@$self{qw( ncol nrow array )} = @_;
	$self->fill();
	return $self;
}

sub module {
	my ($self,$i,$j,$k,$l) = @_;
	#my ($i,$j,$k,$l) = @_;
	if($i < 0) {
		$i += $self->{nrow};
		$j += 4 - ($self->{nrow} + 4) % 8;
	}
	if($j < 0) {
		$j += $self->{ncol};
		$i += 4 - ($self->{ncol} + 4) % 8;
	}
	$self->{array}->[$i * $self->{ncol} + $j] = 10 * $k + $l;
	return;
}

sub utah {
	my ($self,$i,$j,$k) = @_;
    $self->module($i - 2, $j - 2, $k, 1);
    $self->module($i - 2, $j - 1, $k, 2);
    $self->module($i - 1, $j - 2, $k, 3);
    $self->module($i - 1, $j - 1, $k, 4);
    $self->module($i - 1, $j, $k, 5);
    $self->module($i, $j - 2, $k, 6);
    $self->module($i, $j - 1, $k, 7);
    $self->module($i, $j, $k, 8);
    return;
}

sub corner1 {
	my ($self,$i) = @_;
	my ($ncol,$nrow) = @$self{qw( ncol nrow )};
    $self->module($nrow - 1, 0, $i, 1);
    $self->module($nrow - 1, 1, $i, 2);
    $self->module($nrow - 1, 2, $i, 3);
    $self->module(0, $ncol - 2, $i, 4);
    $self->module(0, $ncol - 1, $i, 5);
    $self->module(1, $ncol - 1, $i, 6);
    $self->module(2, $ncol - 1, $i, 7);
    $self->module(3, $ncol - 1, $i, 8);
    return;
}

sub corner2($) { #(int i)
	my ($self,$i) = @_;
	my ($ncol,$nrow) = @$self{qw( ncol nrow )};
    $self->module($nrow - 3, 0, $i, 1);
    $self->module($nrow - 2, 0, $i, 2);
    $self->module($nrow - 1, 0, $i, 3);
    $self->module(0, $ncol - 4, $i, 4);
    $self->module(0, $ncol - 3, $i, 5);
    $self->module(0, $ncol - 2, $i, 6);
    $self->module(0, $ncol - 1, $i, 7);
    $self->module(1, $ncol - 1, $i, 8);
    return;
}

sub corner3($) { #(int i)
	my ($self,$i) = @_;
	my ($ncol,$nrow) = @$self{qw( ncol nrow )};
    $self->module($nrow - 3, 0, $i, 1);
    $self->module($nrow - 2, 0, $i, 2);
    $self->module($nrow - 1, 0, $i, 3);
    $self->module(0, $ncol - 2, $i, 4);
    $self->module(0, $ncol - 1, $i, 5);
    $self->module(1, $ncol - 1, $i, 6);
    $self->module(2, $ncol - 1, $i, 7);
    $self->module(3, $ncol - 1, $i, 8);
    return;
}

sub corner4($) { #(int i)
	my ($self,$i) = @_;
	my ($ncol,$nrow) = @$self{qw( ncol nrow )};
    $self->module($nrow - 1, 0, $i, 1);
    $self->module($nrow - 1, $ncol - 1, $i, 2);
    $self->module(0, $ncol - 3, $i, 3);
    $self->module(0, $ncol - 2, $i, 4);
    $self->module(0, $ncol - 1, $i, 5);
    $self->module(1, $ncol - 3, $i, 6);
    $self->module(1, $ncol - 2, $i, 7);
    $self->module(1, $ncol - 1, $i, 8);
    return;
}

sub fill { # (int ncol; int nrow; int array;) : void
	my $self = shift;
	my ($ncol,$nrow,$array) = @$self{qw( ncol nrow array )};
    my $i = 1;
    my $j = 4;
    my $k = 0;
    #warn Dumper $self;
    for(my $l = 0; $l < $nrow; $l++) {
        for(my $i1 = 0; $i1 < $ncol; $i1++) {
            $array->[$l * $ncol + $i1] = 0;
        }
    }
    do {
        $self->corner1($i++) if $j == $nrow && $k == 0;
        $self->corner2($i++) if $j == $nrow - 2 && $k == 0 && $ncol % 4 != 0;
        $self->corner3($i++) if $j == $nrow - 2 && $k == 0 && $ncol % 8 == 4;
        $self->corner4($i++) if $j == $nrow + 4 && $k == 2 && $ncol % 8 == 0;
        do {
	    	warn "$i $j $k";
            $self->utah($j, $k, $i++) if $j < $nrow && $k >= 0 && $array->[$j * $ncol + $k] == 0;
            #return;
            $j -= 2;
            $k += 2;
        } while($j >= 0 && $k < $ncol);
        $j++;
        $k += 3;
        do {
            $self->utah($j, $k, $i++) if $j >= 0 && $k < $ncol && $array->[$j * $ncol + $k] == 0;
            $j += 2;
            $k -= 2;
        } while($j < $nrow && $k >= 0);
        $j += 3;
        $k++;
    } while($j < $nrow || $k < $ncol);
    $array->[$nrow * $ncol - 1] = $array->[($nrow - 1) * $ncol - 2] = 1
    	if($array->[$nrow * $ncol - 1] == 0);
    return;
}

1;
