#!/usr/bin/perl
use strict;

open(IN,"$ARGV[0]") || die "Can't open IN!\n";
open(OUT,">$ARGV[1]") || die "Can't open OUT!\n";

while(<IN>){
	chomp;
	my @tmp=split /\s+/,$_;
	next if($tmp[2]<50);
	my $len=$tmp[-1]-$tmp[-2]+1;
	print OUT "$tmp[1]\t$tmp[2]\t$len\n";
}
