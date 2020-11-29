#!/usr/bin/perl
use strict;

open(IN,"gzip -dc $ARGV[0] |") || die "Can't open IN!\n";
open(OUT,">$ARGV[1]") || die "Can't open OUT!\n";

my $count;
while(<IN>){
        chomp;
	$count++;
	if($count>4){
		$count=1;
	}
        if($count==1){
		my $tmp=(split /\//,$_)[0];
		print OUT "$tmp\n";
        }
	else{
	        print OUT "$_\n";
	}
}
