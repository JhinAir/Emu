#!/bin/bash

#SBATCH --job-name=Emu.RepeatMasker
#SBATCH --partition=basic,himem
#SBATCH --cpus-per-task=8
#SBATCH --mem=100000
#SBATCH --mail-type=ALL
#SBATCH --output=Emu.RepeatMasker.o
#SBATCH --error=Emu.RepeatMasker.e

/apps/repeatmasker/4.0.7/RepeatMasker -pa 8 -s -lib combined_repeat_libs.fasta -dir ./OUT/ -e ncbi /scratch/LiuJing/Emu/Emu.R3.fa

