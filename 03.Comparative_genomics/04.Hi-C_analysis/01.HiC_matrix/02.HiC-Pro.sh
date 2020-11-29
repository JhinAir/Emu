#!/bin/bash

#SBATCH --job-name=HiC-Pro
#SBATCH --partition=basic,himem
#SBATCH --cpus-per-task=8
#SBATCH --mem=20000
#SBATCH --mail-type=ALL
#SBATCH --mail-user=jhin251614@gmail.com
#SBATCH --output=HiC-Pro.o
#SBATCH --error=HiC-Pro.e

/apps/hicpro/2.10.0/HiC-Pro_2.10.0/bin/HiC-Pro -i /scratch/LiuJing/Emu/TAD/AB/HiC-Pro/rawdata/ -o /scratch/LiuJing/Emu/TAD/AB/HiC-Pro/output -c config-hicpro.txt -s proc_hic -s quality_checks -s merge_persample -s build_contact_maps -s ice_norm
