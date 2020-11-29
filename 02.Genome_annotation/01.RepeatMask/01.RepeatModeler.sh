#!/bin/bash

#SBATCH --job-name=Emu.RepeatModeler
#SBATCH --partition=basic,himem
#SBATCH --cpus-per-task=8
#SBATCH --mem=100000
#SBATCH --mail-type=ALL
#SBATCH --output=Emu.RepeatModeler.o
#SBATCH --error=Emu.RepeatModeler.e

/apps/repeatmodeler/1.0.10/BuildDatabase -name Emu.repeat_modeler -engine ncbi -batch Emu.batch_file

/apps/repeatmodeler/1.0.10/RepeatModeler -database Emu.repeat_modeler -engine ncbi -pa 7
