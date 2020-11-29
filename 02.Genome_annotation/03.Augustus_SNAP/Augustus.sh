#!/bin/bash

#SBATCH --job-name=Augustus
#SBATCH --partition=basic
#SBATCH --cpus-per-task=16
#SBATCH --mem=5000
#SBATCH --mail-type=ALL
#SBATCH --output=Augustus.o
#SBATCH --error=Augustus.e

module load maker
module load augustus
ln -s ../SNAP/genome.ann ./
ln -s ../SNAP/genome.dna ./
cp -r /home/user/liu/Software/Augustus_Config ./
unset AUGUSTUS_CONFIG_PATH
export AUGUSTUS_CONFIG_PATH=/scratch/LiuJing/D_miranda/Annotation/Emu/MAKER/Round1/Emu.03Run.maker.output/Augustus/Augustus_Config
new_species.pl --species=Emu_03run
AUGUSTUS_CONFIG_PATH=/scratch/LiuJing/D_miranda/Annotation/Emu/MAKER/Round1/Emu.03Run.maker.output/Augustus/Augustus_Config
zff2gff3.pl genome.ann | perl -plne 's/\t(\S+)$/\t\.\t$1/' > Emu.HCGeneModel.gff
gff2gbSmallDNA.pl Emu.HCGeneModel.gff ../../../../Emu.03Run.fa 1000 Emu.HCGeneModel.gb
etraining --species=Emu_03run Emu.HCGeneModel.gb --AUGUSTUS_CONFIG_PATH=/scratch/LiuJing/D_miranda/Annotation/Emu/MAKER/Round1/Emu.03Run.maker.output/Augustus/Augustus_Config
/apps/perl/5.28.0/bin/perl /apps/augustus/3.3/scripts/optimize_augustus.pl --AUGUSTUS_CONFIG_PATH=/scratch/LiuJing/D_miranda/Annotation/Emu/MAKER/Round1/Emu.03Run.maker.output/Augustus/Augustus_Config --species=Emu Emu.HCGeneModel.gb -kfold=16 --cpus=16 1>Emu.augustOpt.stdout 2>Emu.augustOpt.stderr
