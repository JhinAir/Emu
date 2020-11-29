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
cooltools compute-expected emu.40Kb.macro.cool --contact-type cis -o emu.40Kb.macro.cis.expected.tsv
cooltools compute-saddle emu.40Kb.macro.cool emu.40Kb.macro.cis.vecs.tsv emu.40Kb.macro.cis.expected.tsv --strength -o emu.40Kb.macro.cis.saddle --fig pdf --qrange 0.02 0.98

cooltools call-compartments emu.40Kb.macro.cool --contact-type trans -o emu.40Kb.macro --reference-track emu.40Kb.macro.GC
cooltools compute-expected emu.40Kb.macro.cool --contact-type trans -o emu.40Kb.macro.trans.expected.tsv
cooltools compute-saddle emu.40Kb.macro.cool emu.40Kb.macro.trans.vecs.tsv emu.40Kb.macro.trans.expected.tsv --strength -o emu.40Kb.macro.trans.saddle --fig pdf --qrange 0.02 0.98

