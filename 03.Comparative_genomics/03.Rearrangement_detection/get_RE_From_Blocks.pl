#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

open(IN,"$ARGV[0]") || die "Can't open IN!\n";
open(OUT,">$ARGV[1]") || die "Can't open OUT!\n";

my (%hash,%blocks);
my %Direction;
my (%Order1,%Order2);
while(<IN>){
	chomp;
	my @tmp=split /\s+/,$_;
	$Direction{$tmp[0]}{$tmp[3]}{$tmp[-1]}+=$tmp[-2];
	$hash{$tmp[0]}{$tmp[3]}{$tmp[4]}=$_;
	$blocks{$tmp[0]}{$tmp[3]}{$tmp[4]}=$tmp[-2];
	$Order1{$tmp[0]}{$tmp[3]}++;
	$Order2{$tmp[0]}{$tmp[3]}{$Order1{$tmp[0]}{$tmp[3]}}=$tmp[4];
}

print OUT "turtle_chr\tstart\tend\tq_chr\tq_start\tq_end\tt_len\tq_len\tstrand\tsv\n";
foreach my $chr1(sort {$a <=> $b} keys %Direction){
	foreach my $chr2(sort {$a <=> $b} keys %{$Direction{$chr1}}){
		my $tmp_direct;
		if($Direction{$chr1}{$chr2}{1}>$Direction{$chr1}{$chr2}{-1}){
			$tmp_direct=1;
		}
		else{
			$tmp_direct=-1;
		}
		my (@tmp1,@tmp2,@tmp3);
		foreach my $count(sort {$a <=> $b} keys %{$Order2{$chr1}{$chr2}}){
			my $pos=$Order2{$chr1}{$chr2}{$count};
			my $strand=(split /\s+/,$hash{$chr1}{$chr2}{$pos})[-1];
			my $len=$blocks{$chr1}{$chr2}{$pos};
			push(@tmp1,$pos);
			push(@tmp2,$strand);
			push(@tmp3,$len);
		}
		my %SV=&find_sv(\@tmp1,\@tmp2,\@tmp3,$tmp_direct);
		foreach my $count(sort {$a <=> $b} keys %{$Order2{$chr1}{$chr2}}){
			my $pos=$Order2{$chr1}{$chr2}{$count};
			print OUT "$hash{$chr1}{$chr2}{$pos}\t$SV{$pos}\n";
		}
	}
}

sub find_sv{
	my ($aa,$bb,$cc,$dd)=@_;
	my (%tmp_hash1,%tmp_hash2);
	my $tmp_count=0;
	my %iloveyou;
	for(my $i=0;$i<=$#{$aa};$i++){
		$tmp_hash1{$i}=$aa->[$i];
		$iloveyou{$aa->[$i]}=1;
	}
	if($dd==1){
		foreach my $key(sort {$a <=> $b} keys %iloveyou){
			$tmp_hash2{$key}=$tmp_count;
			$tmp_count++;
		}
	}
	else{
		foreach my $key(sort {$b <=> $a} keys %iloveyou){
			$tmp_hash2{$key}=$tmp_count;
			$tmp_count++;
		}
	}
	my $large;##largest block
	my %tmp_block;
	for(my $i=0;$i<=$#{$cc};$i++){
		if($cc->[$i]>$large){
			$large=$cc->[$i];
		}
		$tmp_block{$cc->[$i]}=$i;
	}
	my %Inversion;##inv
	for(my $i=0;$i<=$#{$bb};$i++){
		$Inversion{$aa->[$i]}=($bb->[$i])*$dd;
	}
	my (%tmp_pos,%Trans);
	$tmp_pos{$large}=1;
	$Trans{$tmp_hash1{$tmp_block{$large}}}=0;
	foreach my $len(sort {$b <=> $a} keys %tmp_block){
		next if($len==$large);
		my $pos=$tmp_hash1{$tmp_block{$len}};
		my $real_index=$tmp_block{$len};
		my $expect_index=$tmp_hash2{$pos};
		my $judge=0;
		foreach my $block(sort {$b <=> $a} keys %tmp_pos){
			my $index1=$tmp_block{$block};##real index
			my $index2=$tmp_hash2{$tmp_hash1{$index1}};##expect index
			unless(($real_index<$index1 && $expect_index<$index2) || ($real_index>$index1 && $expect_index>$index2)){
				$judge=1;
			}
		}
		if($judge==0){
			$Trans{$pos}=0;##no trans
			$tmp_pos{$len}=1;
		}
		else{
			$Trans{$pos}=1;##trans
		}
	}
	my %output;
	foreach my $pos(keys %Inversion){
		if($Inversion{$pos}==1 && $Trans{$pos}==0){
			$output{$pos}="Normal";
		}
		elsif($Inversion{$pos}==1 && $Trans{$pos}==1){
			$output{$pos}="TRANS";
		}
		elsif($Inversion{$pos}==-1 && $Trans{$pos}==0){
			$output{$pos}="INV";
		}
		else{
			$output{$pos}="INV_TRANS";
		}
	}
	return(%output);
}
