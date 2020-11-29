#!/bin/bash

#SBATCH --job-name=TandomRepeatCount
#SBATCH --partition=basic
#SBATCH --cpus-per-task=1
#SBATCH --mem=100000
#SBATCH --mail-type=ALL
#SBATCH --output=TandomRepeatCount.o
#SBATCH --error=TandomRepeatCount.e

~/Software/trf409.linux64 Emu.fa 2 5 7 80 10 50 2000 -l 8 -h