#!/bin/bash

#SBATCH --job-name=Emu.Trinity
#SBATCH --partition=basic
#SBATCH --cpus-per-task=16
#SBATCH --mem=80000
#SBATCH --mail-type=ALL
#SBATCH --output=Emu.Trinity.o
#SBATCH --error=Emu.Trinity.e

module load bowtie2
module load salmon
module load samtools
module load jellyfish

/apps/trinityrnaseq/2.8.4/Trinity --seqType fq --max_memory 80G --samples_file sample.list.R2 --CPU 16 --workdir ./Emu.trinity --output ./Emu.trinity.out/
