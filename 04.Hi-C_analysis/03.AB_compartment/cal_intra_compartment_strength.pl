#!/usr/bin/perl
use strict;
use List::Util qw/max min sum/;

open(IN1,"$ARGV[0]") || die "Can't open IN1!\n";
open(IN2,"$ARGV[1]") || die "Can't open IN2!\n";
open(OUT,">$ARGV[2]") || die "Can't open OUT!\n";

my (%Macro_A,%Macro_B,%Micro_A,%Micro_B,%hash1,%hash2);
my (@PCA1,@PCA2,@PCA3);
while(<IN1>){
	chomp;
	next if(/^chr/);
	my @tmp=split /\s+/,$_;
	next if($tmp[0] eq "Z" || $tmp[0] eq "W");
	next if($tmp[2] eq "");
	if($tmp[0]<=10 && $tmp[0] ne "4a"){
		$hash1{$tmp[0]}{$tmp[1]}=$tmp[2];
		push(@PCA1,$tmp[2]);
	}
	else{
		$hash2{$tmp[0]}{$tmp[1]}=$tmp[2];
		push(@PCA2,$tmp[2]);
	}
	push(@PCA3,$tmp[2]);
}

my ($macro_a,$macro_b,$micro_a,$micro_b);
my ($genome_a,$genome_b);
my $number1=$#PCA1+1;
my $number2=$#PCA2+1;
my $number3=$#PCA3+1;
my ($count1,$count2,$count3);
foreach my $key(sort {$a <=> $b} @PCA1){
	$count1++;
	if($count1<=$number1*0.3){
		$macro_b=$key;
	}
	if($count1<=$number1*0.7){
		$macro_a=$key;
	}
}
foreach my $key(sort {$a <=> $b} @PCA2){
	$count2++;
	if($count2<=$number2*0.3){
		$micro_b=$key;
	}
	if($count2<=$number2*0.7){
		$micro_a=$key;
	}
}
foreach my $key(sort {$a <=> $b} @PCA3){
	$count3++;
	if($count3<=$number3*0.25){
		$genome_a=$key;
	}
	if($count3<=$number3*0.75){
		$genome_b=$key;
	}
}

foreach my $chr(sort {$a <=> $b} keys %hash1){
	foreach my $win(sort {$a <=> $b} keys %{$hash1{$chr}}){
		if($hash1{$chr}{$win}<=$genome_b){
			$Macro_B{$chr}{$win}=$hash1{$chr}{$win};
		}
		elsif($hash1{$chr}{$win}>=$genome_a){
			$Macro_A{$chr}{$win}=$hash1{$chr}{$win};
		}
	}
}
foreach my $chr(sort {$a <=> $b} keys %hash2){
	foreach my $win(sort {$a <=> $b} keys %{$hash2{$chr}}){
		if($hash2{$chr}{$win}<=$genome_b){
			$Micro_B{$chr}{$win}=$hash2{$chr}{$win};
		}
		elsif($hash2{$chr}{$win}>=$genome_a){
			$Micro_A{$chr}{$win}=$hash2{$chr}{$win};
		}
	}
}
my ($Macro_AA_sum,$Macro_AA_num,$Macro_BB_sum,$Macro_BB_num,$Macro_AB_sum,$Macro_AB_num);
my ($Micro_AA_sum,$Micro_AA_num,$Micro_BB_sum,$Micro_BB_num,$Micro_AB_sum,$Micro_AB_num);
while(<IN2>){
	chomp;
	my @tmp=split /\s+/,$_;
	next unless($tmp[0] eq $tmp[3] && $tmp[0] ne "Z" && $tmp[0] ne "W");
	if($tmp[0]<=10 && $tmp[0] ne "4a"){
		if(exists $Macro_A{$tmp[0]}{$tmp[1]} && exists $Macro_A{$tmp[3]}{$tmp[4]}){
			$Macro_AA_sum+=$tmp[-1];
			$Macro_AA_num++;
		}
		elsif(exists $Macro_A{$tmp[0]}{$tmp[1]} && exists $Macro_B{$tmp[3]}{$tmp[4]}){
			$Macro_AB_sum+=$tmp[-1];
			$Macro_AB_num++;
		}
		elsif(exists $Macro_B{$tmp[0]}{$tmp[1]} && exists $Macro_B{$tmp[3]}{$tmp[4]}){
			$Macro_BB_sum+=$tmp[-1];
			$Macro_BB_num++;
		}
		elsif(exists $Macro_B{$tmp[0]}{$tmp[1]} && exists $Macro_A{$tmp[3]}{$tmp[4]}){
			$Macro_AB_sum+=$tmp[-1];
			$Macro_AB_num++;
		}
	}
	else{
		if(exists $Micro_A{$tmp[0]}{$tmp[1]} && exists $Micro_A{$tmp[3]}{$tmp[4]}){
			$Micro_AA_sum+=$tmp[-1];
			$Micro_AA_num++;
		}
		elsif(exists $Micro_A{$tmp[0]}{$tmp[1]} && exists $Micro_B{$tmp[3]}{$tmp[4]}){
			$Micro_AB_sum+=$tmp[-1];
			$Micro_AB_num++;
		}
		elsif(exists $Micro_B{$tmp[0]}{$tmp[1]} && exists $Micro_B{$tmp[3]}{$tmp[4]}){
			$Micro_BB_sum+=$tmp[-1];
			$Micro_BB_num++;
		}
		elsif(exists $Micro_B{$tmp[0]}{$tmp[1]} && exists $Micro_A{$tmp[3]}{$tmp[4]}){
			$Micro_AB_sum+=$tmp[-1];
			$Micro_AB_num++;
		}
	}
}
my ($Macro_AA_ave,$Macro_AB_ave,$Macro_BB_ave);
my ($Micro_AA_ave,$Micro_AB_ave,$Micro_BB_ave);
$Macro_AA_ave=$Macro_AA_sum/$Macro_AA_num if($Macro_AA_num!=0);
$Macro_AB_ave=$Macro_AB_sum/$Macro_AB_num if($Macro_AB_num!=0);
$Macro_BB_ave=$Macro_BB_sum/$Macro_BB_num if($Macro_BB_num!=0);
$Micro_AA_ave=$Micro_AA_sum/$Micro_AA_num if($Micro_AA_num!=0);
$Micro_AB_ave=$Micro_AB_sum/$Micro_AB_num if($Micro_AB_num!=0);
$Micro_BB_ave=$Micro_BB_sum/$Micro_BB_num if($Micro_BB_num!=0);
print OUT "Macro:\n";
#print OUT "Cutoff\t$macro_a\t$macro_b\n";
print OUT "AA\t$Macro_AA_sum\t$Macro_AA_num\t$Macro_AA_ave\n";
print OUT "AB\t$Macro_AB_sum\t$Macro_AB_num\t$Macro_AB_ave\n";
print OUT "BB\t$Macro_BB_sum\t$Macro_BB_num\t$Macro_BB_ave\n\n";
print OUT "Micro:\n";
#print OUT "Cutoff\t$micro_a\t$micro_b\n";
print OUT "AA\t$Micro_AA_sum\t$Micro_AA_num\t$Micro_AA_ave\n";
print OUT "AB\t$Micro_AB_sum\t$Micro_AB_num\t$Micro_AB_ave\n";
print OUT "BB\t$Micro_BB_sum\t$Micro_BB_num\t$Micro_BB_ave\n";
