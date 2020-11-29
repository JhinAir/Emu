#!/bin/bash

#SBATCH --job-name=Emu.Chicken.lastal
#SBATCH --partition=basic
#SBATCH --cpus-per-task=4
#SBATCH --mem=10000
#SBATCH --mail-type=ALL
#SBATCH --output=Emu.lastal.o
#SBATCH --error=Emu.lastal.e

export PATH=/home/user/liu/Software/Last/bin:$PATH
export PATH=/home/user/liu/Software/Last/phylogenetic-analysis-and-demographic-history-reconstruction-master:$PATH

lastal -P4 -m100 -E0.05 Emu.db Chicken.fa | last-split -m1 > Emu.Chicken.R1.maf
maf-swap Emu.Chicken.R1.maf | last-split | maf-swap | last-split | maf-sort > Emu.Chicken.R2.maf
perl maf.rename.species.S.pl Emu.Chicken.R2.maf Emu Chicken Emu.Chicken.R3.maf
last-dotplot Emu.Chicken.R3.maf Emu.Chicken.tiff
maf-convert blasttab Emu.Chicken.R3.maf > Emu.Chicken.m8
