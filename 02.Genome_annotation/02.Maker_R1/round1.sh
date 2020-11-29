#!/bin/bash

#SBATCH --job-name=MAKER_R1
#SBATCH --partition=basic
#SBATCH --cpus-per-task=8
#SBATCH --mem=50000
#SBATCH --mail-type=ALL
#SBATCH --output=MAKER_R1.o
#SBATCH --error=MAKER_R1.e

module load maker

maker maker_opts.round1.ctl maker_bopts.ctl maker_exe.ctl -cpus 8
