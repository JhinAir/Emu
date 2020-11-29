#!/usr/bin/perl
use strict;

open(IN,"-|","samtools view $ARGV[0]") || die "Can't open IN!\n";
my $chr=$ARGV[1];
open(OUT,">$ARGV[2]") || die "Can't open OUT!\n";

my %BarCode;
my (%BarCodeNum1,%BarCodeNum2);
while(<IN>){
	chomp;
	my @tmp=split /\s+/,$_;
	next unless($tmp[2] eq $chr);
	next if($tmp[4]<50);
	my ($read,$barcode)=split /\//,$tmp[0];
	$BarCodeNum1{$barcode}++;
	if(exists $BarCode{$barcode}){
		if($tmp[3]<$BarCode{$barcode}{1} && $tmp[3]>$BarCode{$barcode}{1}-50000){
			$BarCode{$barcode}{1}=$tmp[3];
			$BarCodeNum2{$barcode}++;
		}
		elsif($tmp[3]>$BarCode{$barcode}{2} && $tmp[3]<$BarCode{$barcode}{2}+50000){
			$BarCode{$barcode}{2}=$tmp[3];
		}
	}
	else{
		$BarCode{$barcode}{1}=$tmp[3];
		$BarCode{$barcode}{2}=$tmp[3];
	}
}

foreach my $bar(sort {$a cmp $b} keys %BarCode){
	print OUT "$chr\t$bar\t$BarCodeNum1{$bar}\t$BarCodeNum2{$bar}\t$BarCode{$bar}{1}\t$BarCode{$bar}{2}\n";
}
