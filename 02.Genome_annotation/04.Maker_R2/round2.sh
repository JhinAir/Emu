#!/bin/bash

#SBATCH --job-name=MAKER_R2
#SBATCH --partition=basic
#SBATCH --cpus-per-task=16
#SBATCH --mem=50000
#SBATCH --mail-type=ALL
#SBATCH --output=MAKER_R2.o
#SBATCH --error=MAKER_R2.e

module load maker
module load augustus
module load snap

unset AUGUSTUS_CONFIG_PATH
export AUGUSTUS_CONFIG_PATH=/scratch/LiuJing/D_miranda/Annotation/Emu/MAKER/Round1/Emu.03Run.maker.output/Augustus/Augustus_Config

maker maker_opts.round2.ctl maker_bopts.ctl maker_exe.ctl -cpus 16
