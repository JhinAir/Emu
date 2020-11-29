#!/usr/bin/perl
use strict;

open(IN,"$ARGV[0]") || die "Can't open IN!\n";
open(OUT,">$ARGV[1]") || die "Can't open OUT!\n";

my $header;
my $count=0;
while(<IN>){
        chomp;
        if(/^\@CL10/){
                $header=$_;
		$count=0;
        }
        else{
		$count++;
		if($count==1){
			$header.="$_";
		}
		else{
			if($header ne ""){
        	        	print OUT "$header\n$_\n";
                	        $header="";
	                }
        	        else{
                	        print OUT "$_\n";
	                }
		}
        }
}
