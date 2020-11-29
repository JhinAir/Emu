#!/usr/bin/perl
use strict;

open(IN1,"gzip -dc $ARGV[0] |") || die "Can't open IN1!\n";
open(IN2,"gzip -dc $ARGV[1] |") || die "Can't open IN2!\n";
open(OUT,">$ARGV[2]") || die "Can't open OUT!\n";

my %hash;
my $count=0;
my $read;
while(<IN1>){
	chomp;
	$count++;
	if($count>4){
		$count=1;
	}
	if($count==1){
		$read=$_;
		$hash{$read}=$_;
	}
	else{
		$hash{$read}.="\n$_";
	}
}

$count=0;
while(<IN2>){
	chomp;
	$count++;
	if($count>4){
		$count=1;
	}
	if($count==1){
		$read=$_;
		print OUT "$hash{$read}\n";
		print OUT "$_\n";
	}
	else{
		print OUT "$_\n";
	}
}
