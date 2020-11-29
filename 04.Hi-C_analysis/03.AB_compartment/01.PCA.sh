#!/bin/bash

#SBATCH --job-name=emu.macro.cool
#SBATCH --partition=basic
#SBATCH --cpus-per-task=1
#SBATCH --mem=5000
#SBATCH --mail-type=ALL
#SBATCH --output=emu.macro.cool.o
#SBATCH --error=emu.macro.cool.e

export PATH=/home/user/liu/miniconda3/bin:$PATH

hicAdjustMatrix --matrix emu.40Kb.cool --action keep --chromosomes 1 2 3 4 5 6 7 8 9 10 4a -o emu.40Kb.macro.cool
cooler balance emu.40Kb.macro.cool
cooltools call-compartments emu.40Kb.macro.cool --contact-type cis -o emu.40Kb.macro --reference-track emu.40Kb.macro.GC
