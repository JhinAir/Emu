#!/usr/bin/perl
use strict;

open(IN,"$ARGV[0]") || die "Can't open IN!\n";
open(OUT,">$ARGV[1]") || die "Can't open OUT!\n";

my $header;
while(<IN>){
        chomp;
        if(/^\_/){
                print OUT "$header","$_\n";
        }
        else{
                $header=$_;
        }
}
