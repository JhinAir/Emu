#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

open(IN,"$ARGV[0]") || die "Can't open IN!\n";
open(OUT,">$ARGV[1]") || die "Can't open OUT!\n";

my %Block;
my $block_count;
my ($tmp_chr,$tmp_pos1,$tmp_pos2,$tmp_strand,$tmp_r_chr,$tmp_r_pos1,$tmp_r_pos2);
my $count;
my %INPUT;
my %POS;
while(<IN>){
	chomp;
	my @tmp=split /\s+/,$_;
	next unless($tmp[-2]>=10000);
	my $pos=($tmp[4]+$tmp[5])/2;
	$count++;
	$INPUT{$count}=$_;
	$POS{$tmp[3]}{$pos}=1;
}

foreach my $key(sort {$a <=> $b} keys %INPUT){
	my @tmp=split /\s+/,$INPUT{$key};
	my ($chr,$pos1,$pos2,$strand,$r_chr,$r_pos1,$r_pos2);
	$r_chr=$tmp[0];
	$r_pos1=$tmp[1];
	$r_pos2=$tmp[2];
	$chr=$tmp[3];
	$pos1=$tmp[4];
	$pos2=$tmp[5];
	$strand=$tmp[-1];
	if($tmp_chr eq ""){
		$tmp_r_chr=$r_chr;
		$tmp_r_pos1=$r_pos1;
		$tmp_r_pos2=$r_pos2;
		$tmp_chr=$chr;
		$tmp_pos1=$pos1;
		$tmp_pos2=$pos2;
		$tmp_strand=$strand;
		my $len1=abs($tmp_r_pos1-$tmp_r_pos2)+1;
		my $len2=abs($tmp_pos1-$tmp_pos2)+1;
		$block_count++;
		$Block{$block_count}="$tmp_r_chr\t$tmp_r_pos1\t$tmp_r_pos2\t$tmp_chr\t$tmp_pos1\t$tmp_pos2\t$len1\t$len2\t$tmp_strand";
	}
	else{
		if(($tmp_r_chr eq $r_chr) && ($tmp_chr eq $chr) && ($tmp_strand eq $strand)){
			my $mid1=($pos1+$pos2)/2;
			my $mid2=($tmp_pos1+$tmp_pos2)/2;
			my $judge=0;
			foreach my $ttt(sort {$a <=> $b} keys %{$POS{$chr}}){
				if(($ttt>$mid1 && $ttt<$mid2) || ($ttt<$mid1 && $ttt>$mid2)){
					$judge=1;
				}
			}
			if((($strand==1 && $tmp_pos2<=$pos1) || ($strand==-1 && $tmp_pos2>=$pos1)) && $judge!=1){
				my @arr1=($tmp_pos1,$tmp_pos2,$pos1,$pos2);
				my @arr2=sort {$a <=> $b} @arr1;
				$tmp_pos1=$arr2[0];
				$tmp_pos2=$arr2[-1];
				$tmp_r_pos1=$tmp_r_pos1;
				$tmp_r_pos2=$r_pos2;
				delete $POS{$chr}{$mid1};
				delete $POS{$chr}{$mid2};
				my $mid3=($tmp_pos1+$tmp_pos2)/2;
				$POS{$chr}{$mid3}=1;
				my $len1=abs($tmp_r_pos1-$tmp_r_pos2)+1;
				my $len2=abs($tmp_pos1-$tmp_pos2)+1;
				$Block{$block_count}="$tmp_r_chr\t$tmp_r_pos1\t$r_pos2\t$tmp_chr\t$tmp_pos1\t$tmp_pos2\t$len1\t$len2\t$tmp_strand";
			}
			else{
				$tmp_r_pos1=$r_pos1;
				$tmp_r_pos2=$r_pos2;
				$tmp_chr=$chr;
				$tmp_pos1=$pos1;
				$tmp_pos2=$pos2;
				$tmp_strand=$strand;
				my $len1=abs($tmp_r_pos1-$tmp_r_pos2)+1;
				my $len2=abs($tmp_pos1-$tmp_pos2)+1;
				$block_count++;
				$Block{$block_count}="$tmp_r_chr\t$tmp_r_pos1\t$tmp_r_pos2\t$tmp_chr\t$tmp_pos1\t$tmp_pos2\t$len1\t$len2\t$tmp_strand";
			}
		}
		else{
			$tmp_r_chr=$r_chr;
			$tmp_r_pos1=$r_pos1;
			$tmp_r_pos2=$r_pos2;
			$tmp_chr=$chr;
			$tmp_pos1=$pos1;
			$tmp_pos2=$pos2;
			$tmp_strand=$strand;
			my $len1=abs($tmp_r_pos1-$tmp_r_pos2)+1;
			my $len2=abs($tmp_pos1-$tmp_pos2)+1;
			$block_count++;
			$Block{$block_count}="$tmp_r_chr\t$tmp_r_pos1\t$tmp_r_pos2\t$tmp_chr\t$tmp_pos1\t$tmp_pos2\t$len1\t$len2\t$tmp_strand";
		}
	}
}

foreach my $key(sort {$a <=> $b} keys %Block){
	my @tmp=split /\t/,$Block{$key};
	next unless($tmp[-2]>=50000);
	print OUT "$Block{$key}\n";
}

