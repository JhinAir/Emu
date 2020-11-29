#!/bin/bash

#SBATCH --job-name=Emu.juicer
#SBATCH --partition=basic
#SBATCH --cpus-per-task=16
#SBATCH --mem=300000
#SBATCH --mail-type=ALL
#SBATCH --output=Emu.juicer.o
#SBATCH --error=Emu.juicer.e

export PATH=/home/user/liu/miniconda3/bin:$PATH
module load bwa
module load samtools

bwa index  ./references/Emu.R3.fa

/scratch/LiuJing/Emu/Juicer_Emu/scripts/juicer.sh -g Emu -s MboI -d /scratch/LiuJing/Emu/Juicer_Emu/Emu_HiCReads -p /scratch/LiuJing/Emu/Juicer_Emu/references/Emu.R3.chrom.sizes -y /scratch/LiuJing/Emu/Juicer_Emu/restriction_sites/Emu_MboI.txt -z /scratch/LiuJing/Emu/Juicer_Emu/references/Emu.R3.fa -D /scratch/LiuJing/Emu/Juicer_Emu -r -t 16

java -jar /scratch/LiuJing/Emu/TAD/AB/HiC-Pro/Juicer/juicer_tools_1.14.08.jar pre -f ./restriction_sites/Emu_MboI.txt -q 0 ./Emu_HiCReads/aligned/merged_nodups.txt emu.inter_0.hic ./references/Emu.R3.chrom.sizes -r 5000,10000,20000,40000,100000,500000,1000000,2000000 -k KR

java -jar /scratch/LiuJing/Emu/TAD/AB/HiC-Pro/Juicer/juicer_tools_1.14.08.jar pre -f ./restriction_sites/Emu_MboI.txt -q 30 ./Emu_HiCReads/aligned/merged_nodups.txt emu.inter_30.hic ./references/Emu.R3.chrom.sizes -r 5000,10000,20000,40000,100000,500000,1000000,2000000 -k KR

