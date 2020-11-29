#!/bin/bash

#SBATCH --job-name=Emu.3D_DNA
#SBATCH --partition=basic
#SBATCH --cpus-per-task=16
#SBATCH --mem=200000
#SBATCH --mail-type=ALL
#SBATCH --output=Emu.3D_DNA.o
#SBATCH --error=Emu.3D_DNA.e

/home/user/liu/Software/3d-dna-master/run-asm-pipeline.sh ../references/Emu.scaffold.fasta ../Emu_HiCReads/aligned/merged_nodups.txt
