#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

open(IN1,"$ARGV[0]") || die "Can't open IN1!\n";
open(IN2,"$ARGV[1]") || die "Can't open IN2!\n";
open(OUT,">$ARGV[2]") || die "Can't open OUT!\n";

my %Window;
while(<IN1>){
	chomp;
	my @tmp=split /\s+/,$_;
	$Window{$tmp[-1]}="$tmp[0]\t$tmp[1]";
}

my %Interaction;
while(<IN2>){
	chomp;
	my @tmp=split /\s+/,$_;
	my ($chr1,$pos1)=split /\t/,$Window{$tmp[0]};
	my ($chr2,$pos2)=split /\t/,$Window{$tmp[1]};
	next unless(($chr1 eq "Z" || $chr1 eq "W") && ($chr2 eq "Z" || $chr2 eq "W"));
	if($chr1 eq "Z" && ($pos1+40000)<=27200000 && $pos1>=22400000){
		my $index1=($pos1-22400000)/40000;
		if($chr2 eq "Z"){
			if(($pos2+40000)<=27200000 && $pos2>=22400000){
				my $index2=($pos2-22400000)/40000;
				for(my $i=0;$i<=95;$i++){
					if($i<=$index1 && $i+24>=$index1){
						$Interaction{$chr1}{$i}{1}+=$tmp[-1];
					}
					unless($i<=$index2 && $i+24>=$index2){
						$Interaction{$chr2}{$i}{1}+=$tmp[-1];
					}
				}
			}
			elsif($pos2>=27200000){
				for(my $i=0;$i<=95;$i++){
					if($i<=$index1 && $i+24>=$index1){
						$Interaction{$chr1}{$i}{2}+=$tmp[-1];
					}
				}
			}
		}
	}
	elsif($chr1 eq "Z" && ($pos1+40000)>27200000){
		if($chr2 eq "W"){
			if($pos2>=3200000){
				my $index2=($pos2-3200000)/40000;
				for(my $i=0;$i<=90;$i++){
					if($i<=$index2 && $i+24>=$index2){
						$Interaction{$chr2}{$i}{2}+=$tmp[-1];
					}
				}
			}
		}
	}
	elsif($chr1 eq "W" && $pos1>=3200000){
		my $index1=($pos1-3200000)/40000;
		if($chr2 eq "W"){
			if($pos2>=3200000){
				my $index2=($pos2-3200000)/40000;
				for(my $i=0;$i<=90;$i++){
					if($i<=$index1 && $i+24>=$index1){
						$Interaction{$chr1}{$i}{1}+=$tmp[-1];
					}
					unless($i<=$index2 && $i+24>=$index2){
						$Interaction{$chr2}{$i}{1}+=$tmp[-1];
					}
				}
			}
		}
	}
}

foreach my $chr(sort {$a cmp $b} keys %Interaction){
	foreach my $win(sort {$a <=> $b} keys %{$Interaction{$chr}}){
		print OUT "$chr\t$win\t$Interaction{$chr}{$win}{1}\t$Interaction{$chr}{$win}{2}\n";
	}
}
