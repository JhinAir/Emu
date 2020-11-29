#!/bin/bash

#SBATCH --job-name=HiCExplorer_Protocol_P2.sh
#SBATCH --partition=basic
#SBATCH --cpus-per-task=8
#SBATCH --mem=50000
#SBATCH --mail-type=ALL
#SBATCH --output=HiCExplorer_Protocol_P2.sh.o
#SBATCH --error=HiCExplorer_Protocol_P2.sh.e

hicMergeMatrixBins --matrix hicMatrix/emu_10kb.h5 --numBins 2 --outFileName hicMatrix/emu_20kb.h5

##############################Part2
##Correct Hi-C Matrix
hicCorrectMatrix correct --chromosomes 1 2 3 4 4a 6 7 8 9 10 11 12 13 14 15 17 18 20 21 22 23 24 25 26 27 28 33 Z W --matrix hicMatrix/emu_20kb.h5 --filterThreshold -2 2 --perchr --outFileName hicMatrix/emu_20kb.corrected.h5

##Plot the corrected Hi-C matrix
hicPlotMatrix --matrix hicMatrix/emu_20kb.corrected.h5 --log1p --dpi 400 --clearMaskedBins --chromosomeOrder 1 2 3 4 4a 6 7 8 9 10 11 12 13 14 15 17 18 20 21 22 23 24 25 26 27 28 33 Z W --title "20kb Corrected Hi-C Matrix of Emu whole-genome" --outFileName plots/emu_50kb.corrected.genome.matrix.png

##Find TADs
mkdir TADs/
hicFindTADs --matrix hicMatrix/emu_20kb.corrected.h5 --minDepth 100000 --maxDepth 200000 --numberOfProcessors 8 --step 20000 --thresholdComparisons 0.05 --outPrefix TADs/emu_20Kb.TADs --correctForMultipleTesting fdr

##Plot TADs
hicPlotTADs --tracks Emu.chrZ.track.ini --region Z:30000000-50000000 --dpi 300 --outFileName TADs/emu_20Kb.TADs.chrZ_30Mb_50Mb.png --title "TADs on of Emu chrZ_30Mb_50Mb"
