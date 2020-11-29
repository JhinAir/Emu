#!/bin/bash

#SBATCH --job-name=get20K_TAD
#SBATCH --partition=basic
#SBATCH --cpus-per-task=4
#SBATCH --mem=5000
#SBATCH --mail-type=ALL
#SBATCH --output=get20K_TAD.o
#SBATCH --error=get20K_TAD.e

export PATH=/home/user/liu/miniconda3/bin:$PATH
hicFindTADs --matrix ../hicMatrix/emu_20kb.corrected.h5 --minDepth 60000 --maxDepth 200000 --numberOfProcessors 4 --step 20000 --thresholdComparisons 0.05 --outPrefix emu_20Kb.TADs --correctForMultipleTesting fdr
