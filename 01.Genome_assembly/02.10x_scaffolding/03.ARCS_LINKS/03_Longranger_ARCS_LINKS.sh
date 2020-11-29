#!/bin/bash

#SBATCH --job-name=03_Longranger_ARCS_LINKS
#SBATCH --partition=basic
#SBATCH --cpus-per-task=16
#SBATCH --mem=50000
#SBATCH --mail-type=ALL
#SBATCH --output=02_Longranger_ARCS_LINKS.o
#SBATCH --error=02_Longranger_ARCS_LINKS.e

/home/user/liu/Software/longranger-2.2.2/longranger basic --id=Emu_ass --fastqs=/scratch/LiuJing/D_miranda/10XData/02_ARCS_LINKS/10XData/ --sample=Emu10X

gunzip -c Emu_ass/outs/barcoded.fastq.gz | perl -ne 'chomp;$ct++;$ct=1 if($ct>4);if($ct==1){if(/(@\S+)\sBX:Z:(\S{16})/){$flag=1;$head=$1."_".$2;print "$head\n";}else{$flag=0;}}else{print "$_\n" if($flag);}' > CHROMIUM_interleaved.fastq

cat ../01_Scaff10x/Emu.Scaff10x_R2.fa | perl -ne 'chomp;if(/^>/){$ct++;print ">$ct\n";}else{print "$_\n";}' > Emu.Scaff10x_R2-renamed.fa

bwa index Emu.Scaff10x_R2-renamed.fa

cd /scratch/LiuJing/D_miranda/10XData/02_ARCS_LINKS/

gzip -c ../00_Reads/10X_BC_1.fastq > $TMPDIR/10X_BC_1.fastq.gz

gzip -c ../00_Reads/10X_BC_2.fastq > $TMPDIR/10X_BC_2.fastq.gz

echo "gzip done!";

perl merge.pl ../00_Reads/10X_BC_1.fastq.gz ../00_Reads/10X_BC_2.fastq.gz $TMPDIR/CHROMIUM_interleaved.fastq

mv $TMPDIR/10X_BC_1.fastq.gz ../00_Reads/10X_BC_1.fastq.gz

mv $TMPDIR/10X_BC_2.fastq.gz ../00_Reads/10X_BC_2.fastq.gz

rm ../00_Reads/10X_BC_1.fastq ../00_Reads/10X_BC_2.fastq

mv $TMPDIR/CHROMIUM_interleaved.fastq ../00_Reads/

cp Emu.Scaff10x_R2-renamed.fa* $TMPDIR/

bwa mem -t 16 Emu.Scaff10x_R2-renamed.fa -p ../00_Reads/CHROMIUM_interleaved.fastq | samtools view -Sb > $TMPDIR/bwa_aligned_chromium.bam

samtools sort -n $TMPDIR/bwa_aligned_chromium.bam -@ 16 -O BAM -o $TMPDIR/bwa_aligned_chromium_sorted.bam

mv $TMPDIR/bwa_aligned_chromium_sorted.bam ./

echo "sort bam done!";

/home/user/liu/Software/ARCS/bin/arcs -f Emu.Scaff10x_R2-renamed.fa -a AlignmentFile -s 98 -c 5 -l 0 -d 0 -r 0.05 -e 30000 -m 20-10000 -v > arcs.log

/home/user/liu/Software/arcs-master/Examples/makeTSVfile.py Emu.Scaff10x_R2-renamed.fa.scaff_s98_c5_l0_d0_e30000_r0.05_original.gv Emu.Arcs_LINK.R1.tigpair_checkpoint.tsv Emu.Scaff10x_R2-renamed.fa

/home/user/liu/Software/links_v1.8.6/LINKS -f Emu.Scaff10x_R2-renamed.fa -s empty.fof -d 4000 -k 20 -e 0.1 -l 5 -a 0.9 -t 2 -o 0 -z 500 -b Emu.Arcs_LINK.R1 -r -p 0.001 -x 1
