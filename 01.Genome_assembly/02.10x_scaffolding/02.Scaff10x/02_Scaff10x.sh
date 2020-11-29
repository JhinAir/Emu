#!/bin/bash

#SBATCH --job-name=01_Scaff10x
#SBATCH --partition=basic,himem
#SBATCH --cpus-per-task=16
#SBATCH --mem=200000
#SBATCH --mail-type=ALL
#SBATCH --output=01_Scaff10x.o
#SBATCH --error=01_Scaff10x.e

/home/user/liu/Software/Scaff10x/scaff10x -nodes 16 -longread 1 -gap 100 -matrix 2000 -reads 10 -score 20 -edge 50000 -link 8 -block 50000 /proj/LiuJing/D_miranda/Ref/p_ctg.fa ../00_Reads/10X_BC_1.fastq ../00_Reads/10X_BC_2.fastq Emu.Scaff10x_R1.fa > 01_Scaff10x.R1.log

/home/user/liu/Software/Scaff10x/scaff10x -nodes 16 -longread 1 -gap 100 -matrix 2000 -reads 10 -score 20 -edge 50000 -link 8 -block 50000 Emu.Scaff10x_R1.fa ../00_Reads/10X_BC_1.fastq ../00_Reads/10X_BC_2.fastq Emu.Scaff10x_R2.fa >> 01_Scaff10x.R2.log

