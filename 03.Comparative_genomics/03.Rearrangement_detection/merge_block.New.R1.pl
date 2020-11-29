#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

open(IN,"$ARGV[0]") || die "Can't open IN!\n";
my $win1=$ARGV[1];
my $win2=$ARGV[2];
open(OUT,">$ARGV[3]") || die "Can't open OUT!\n";

my ($tmp_q_chr,$tmp_q_start,$tmp_q_end,$tmp_r_chr,$tmp_r_start,$tmp_r_end,$tmp_strand);
my %Block;
my $block_count;
while(<IN>){
	chomp;
	my @tmp=split /\s+/,$_;
	next if($tmp[0] eq "W" || $tmp[2]<80 || $tmp[3]<60);
	my ($q_chr,$q_start,$q_end,$r_chr,$r_start,$r_end,$strand);
	$q_chr=$tmp[0];
	$q_start=$tmp[6];
	$q_end=$tmp[7];
	$r_chr=$tmp[1];
	$r_start=$tmp[8];
	$r_end=$tmp[9];
	if($q_start<$q_end){
		$strand=1;
	}
	else{
		$strand=-1;
	}
	my $judge;
	if($tmp_q_chr eq ""){
		$block_count++;
		$tmp_q_chr=$q_chr;
		$tmp_q_start=$q_start;
		$tmp_q_end=$q_end;
		$tmp_r_chr=$r_chr;
		$tmp_r_start=$r_start;
		$tmp_r_end=$r_end;
		$tmp_strand=$strand;
		$judge=0;
	}
	else{
		if($tmp_q_chr eq $q_chr && $tmp_r_chr eq $r_chr && $tmp_strand eq $strand){
			if($strand==1){
				if(($q_start<=$tmp_q_end+$win1 && $q_end>=$tmp_q_start-$win1) && ($r_start<=$tmp_r_end+$win1*2 && $r_end>=$tmp_r_start-$win1*2)){
					my @arr1=($q_start,$q_end,$tmp_q_start,$tmp_q_end);
					my @arr11=sort {$a <=> $b} @arr1;
					my @arr2=($r_start,$r_end,$tmp_r_start,$tmp_r_end);
					my @arr22=sort {$a <=> $b} @arr2;
					$tmp_q_start=$arr11[0];
					$tmp_q_end=$arr11[-1];
					$tmp_r_start=$arr22[0];
					$tmp_r_end=$arr22[-1];
					$judge=1;
				}
				else{
					$judge=0;
				}
			}
			else{
				if(($q_end<=$tmp_q_start+$win1 && $q_start>=$tmp_q_end-$win1) && ($r_start<=$tmp_r_end+$win1*2 && $r_end>=$tmp_r_start-$win1*2)){
					my @arr1=($q_start,$q_end,$tmp_q_start,$tmp_q_end);
					my @arr11=sort {$a <=> $b} @arr1;
					my @arr2=($r_start,$r_end,$tmp_r_start,$tmp_r_end);
					my @arr22=sort {$a <=> $b} @arr2;
					$tmp_q_start=$arr11[0];
					$tmp_q_end=$arr11[-1];
					$tmp_r_start=$arr22[0];
					$tmp_r_end=$arr22[-1];
					$judge=1;
				}
				else{
					$judge=0;
				}
			}
		}
		else{
			$judge=0;
		}
		if($judge==0){
			$block_count++;
			$tmp_q_chr=$q_chr;
			$tmp_q_start=$q_start;
			$tmp_q_end=$q_end;
			$tmp_r_chr=$r_chr;
			$tmp_r_start=$r_start;
			$tmp_r_end=$r_end;
			$tmp_strand=$strand;
		}
	}
	$Block{$block_count}="$tmp_q_chr\t$tmp_q_start\t$tmp_q_end\t$tmp_r_chr\t$tmp_r_start\t$tmp_r_end\t$tmp_strand";
}

my $R2_count;
$tmp_q_chr="";
my %Block_R2;
foreach my $count(sort {$a <=> $b} keys %Block){
	my @tmp=split /\t/,$Block{$count};
	my $len1=abs($tmp[4]-$tmp[5])+1;
	my $len2=abs($tmp[1]-$tmp[2])+1;
	next if($len1<1000 || $len2<1000);
	my ($q_chr,$q_start,$q_end,$r_chr,$r_start,$r_end,$strand);
	$q_chr=$tmp[0];
	$q_start=$tmp[1];
	$q_end=$tmp[2];
	$r_chr=$tmp[3];
	$r_start=$tmp[4];
	$r_end=$tmp[5];
	$strand=$tmp[6];
	my $judge;
	if($tmp_q_chr eq ""){
		$R2_count++;
		$tmp_q_chr=$q_chr;
		$tmp_q_start=$q_start;
		$tmp_q_end=$q_end;
		$tmp_r_chr=$r_chr;
		$tmp_r_start=$r_start;
		$tmp_r_end=$r_end;
		$tmp_strand=$strand;
		$judge=0;
	}
	else{
		if($tmp_q_chr eq $q_chr && $tmp_r_chr eq $r_chr && $tmp_strand eq $strand){
			if($strand==1){
				if(($q_start<=$tmp_q_end+$win2 && $q_end>=$tmp_q_start-$win2) && ($r_start<=$tmp_r_end+$win2*2 && $r_end>=$tmp_r_start-$win2*2)){
					my @arr1=($q_start,$q_end,$tmp_q_start,$tmp_q_end);
					my @arr11=sort {$a <=> $b} @arr1;
					my @arr2=($r_start,$r_end,$tmp_r_start,$tmp_r_end);
					my @arr22=sort {$a <=> $b} @arr2;
					$tmp_q_start=$arr11[0];
					$tmp_q_end=$arr11[-1];
					$tmp_r_start=$arr22[0];
					$tmp_r_end=$arr22[-1];
					$judge=1;
				}
				else{
					$judge=0;
				}
			}
			else{
				if(($q_end<=$tmp_q_start+$win2 && $q_start>=$tmp_q_end-$win2) && ($r_start<=$tmp_r_end+$win2*2 && $r_end>=$tmp_r_start-$win2*2)){
					my @arr1=($q_start,$q_end,$tmp_q_start,$tmp_q_end);
					my @arr11=sort {$a <=> $b} @arr1;
					my @arr2=($r_start,$r_end,$tmp_r_start,$tmp_r_end);
					my @arr22=sort {$a <=> $b} @arr2;
					$tmp_q_start=$arr11[0];
					$tmp_q_end=$arr11[-1];
					$tmp_r_start=$arr22[0];
					$tmp_r_end=$arr22[-1];
					$judge=1;
				}
				else{
					$judge=0;
				}
			}
		}
		else{
			$judge=0;
		}
		if($judge==0){
			$R2_count++;
			$tmp_q_chr=$q_chr;
			$tmp_q_start=$q_start;
			$tmp_q_end=$q_end;
			$tmp_r_chr=$r_chr;
			$tmp_r_start=$r_start;
			$tmp_r_end=$r_end;
			$tmp_strand=$strand;
		}
	}
	$Block_R2{$R2_count}="$tmp_q_chr\t$tmp_q_start\t$tmp_q_end\t$tmp_r_chr\t$tmp_r_start\t$tmp_r_end\t$tmp_strand";
}

foreach my $count(sort {$a <=> $b} keys %Block_R2){
	my @tmp=split /\t/,$Block_R2{$count};
	next if($tmp[0] eq "W");
	my $len1=abs($tmp[4]-$tmp[5])+1;
	my $len2=abs($tmp[1]-$tmp[2])+1;
	next if($len1<2000 || $len2<2000);
	print OUT "$tmp[3]\t$tmp[4]\t$tmp[5]\t$tmp[0]\t$tmp[1]\t$tmp[2]\t$len1\t$len2\t$tmp[-1]\n";
}

