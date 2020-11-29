#!/usr/bin/perl
use strict;

open(IN,"$ARGV[0]") || die "Can't open IN!\n";
open(OUT,">$ARGV[1]") || die "Can't open OUT!\n";

my $line;
while(<IN>){
	chomp;
	$line++;
	if($line>4){
		$line=1;
	}
	if($line==2 || $line==4){
		my $len=length($_)-1;
		my $seq=substr($_,1,$len);
		print OUT "$seq\n";
	}
	else{
		print OUT "$_\n";
	}
}
