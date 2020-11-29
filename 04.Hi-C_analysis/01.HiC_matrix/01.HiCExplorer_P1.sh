#!/bin/bash

#SBATCH --job-name=HiCExplorer_Protocol_P1.sh
#SBATCH --partition=basic
#SBATCH --cpus-per-task=16
#SBATCH --mem=200000
#SBATCH --mail-type=ALL
#SBATCH --output=HiCExplorer_Protocol_P1.sh.o
#SBATCH --error=HiCExplorer_Protocol_P1.sh.e

##############################Part1
##Mapping the RAW files
mkdir mapping/
bwa mem -A 1 -B 4 -E 50 -L 0 -t 16 ../Emu.R3.fa /proj/LiuJing/Emu/HiCdata/emu.hic.clean_R1.fq.gz | samtools view -Shb - > mapping/Emu.hic.R1.bam
bwa mem -A 1 -B 4 -E 50 -L 0 -t 16 ../Emu.R3.fa /proj/LiuJing/Emu/HiCdata/emu.hic.clean_R2.fq.gz | samtools view -Shb - > mapping/Emu.hic.R2.bam

##restrictionCutFile
findRestSite --fasta ../Emu.R3.fa --searchPattern GATC -o Emu.R3.rest_site_positions.bed

##Build Hi-C matrix
mkdir hicMatrix/
hicBuildMatrix --samFiles mapping/Emu.hic.R1.bam mapping/Emu.hic.R2.bam --binSize 10000 --restrictionSequence GATC --outBam hicMatrix/emu.accepted_alignments.bam --outFileName hicMatrix/emu_10kb.h5 --QCfolder hicMatrix/emu_10kb_QC --threads 16 --inputBufferSize 400000

##Merge matrix bins for plotting
hicMergeMatrixBins --matrix hicMatrix/emu_10kb.h5 --numBins 100 --outFileName hicMatrix/emu_1Mb.h5
hicMergeMatrixBins --matrix hicMatrix/emu_10kb.h5 --numBins 5 --outFileName hicMatrix/emu_50kb.h5

##plot
hicPlotMatrix --matrix hicMatrix/emu_1Mb.h5 --log1p --dpi 800 --clearMaskedBins --chromosomeOrder 1 2 3 4 4a 5 6 7 8 9 10 11 12 13 14 15 17 18 20 21 22 23 24 25 26 27 28 33 Z W --colorMap Reds --title "1Mb Hi-C Matrix of Emu whole-genome" --outFileName plots/emu_1Mb.genome.matrix.png

