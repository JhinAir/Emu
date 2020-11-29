#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

open(IN,"$ARGV[0]") || die "Can't open IN!\n";
my $spe1=$ARGV[1];
my $spe2=$ARGV[2];
open(OUT,">$ARGV[3]") || die "Can't open OUT!\n";

my $num1=length($spe1);
my $num2=length($spe2);
my $tmp_num;
if($num1>$num2){
	$tmp_num=$num1-$num2;
}
else{
	$tmp_num=$num2-$num1;
}
my $char;
for(my $i=1;$i<=$tmp_num;$i++){
	$char.=" ";
}

print OUT "##maf version=1 scoring=last\n";
my $line;
while(<IN>){
	chomp;
	next if(/^#/);
	if(/^a/){
		print OUT "$_\n";
		$line=0;
	}
	elsif(/^s/){
		$line++;
		s/\>//g;
		my @tmp=split /\s/,$_,3;
		if($line==1){
			print OUT "$tmp[0] $spe1.$tmp[1]";
			if($num1<$num2){
				print OUT "$char";
			}
			print OUT "  $tmp[2]\n";
		}
		else{
			print OUT "$tmp[0] $spe2.$tmp[1]";
			if($num1>$num2){
				 print OUT "$char";
			}
			print OUT " $tmp[2]\n";
		}
	}
	elsif(/^p/){
		next;
	}
	else{
		print OUT "$_\n";
	}
}
