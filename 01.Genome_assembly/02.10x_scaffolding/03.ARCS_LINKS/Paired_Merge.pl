#!/usr/bin/perl
use strict;

open(IN1,"$ARGV[0]") || die "Can't open IN1!\n";
open(IN2,"$ARGV[1]") || die "Can't open IN2!\n";
open(OUT,">$ARGV[2]") || die "Can't open OUT!\n";

my %hash;
my $line1;
my $head;
while(<IN1>){
	chomp;
	$line1++;
	if($line1>4){
		$line1=1;
	}
	if($line1==1){
		$head=$_;
		$hash{$head}=$_;
	}
	else{
		$hash{$head}.="\n$_";
	}
}

my $line2;
my $head2;
while(<IN2>){
	chomp;
	$line2++;
	if($line2>4){
		$line2=1;
	}
	if($line2==1){
		if($head2 ne ""){
			print OUT "$hash{$head2}\n";
		}
		$head2=$_;
		print OUT "$_\n";
	}
	else{
		print OUT "$_\n";
	}
}
print OUT "$hash{$head2}\n";
