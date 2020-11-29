#!/bin/bash

#SBATCH --job-name=chrZ.TADs.plot
#SBATCH --partition=basic
#SBATCH --cpus-per-task=4
#SBATCH --mem=50000
#SBATCH --mail-type=ALL
#SBATCH --output=chrZ.TADs.plot.o
#SBATCH --error=chrZ.TADs.plot.e

hicPlotTADs --tracks Emu.track.ini -o Emu.chrZ.hic_track.pdf --region Z:1-10000000
