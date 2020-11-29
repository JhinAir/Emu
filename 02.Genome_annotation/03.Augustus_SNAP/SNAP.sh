#!/bin/bash

#SBATCH --job-name=SNAP
#SBATCH --partition=basic
#SBATCH --cpus-per-task=1
#SBATCH --mem=5000
#SBATCH --mail-type=ALL
#SBATCH --output=SNAP.o
#SBATCH --error=SNAP.e

module load maker
module load snap
maker2zff -c 0.8 -e 0.8 -o 0.8 -l 50 -x 0.25 -d ../Emu.03Run_master_datastore_index.log
fathom genome.ann genome.dna -gene-stats > Emu.gene-stats.log
fathom genome.ann genome.dna -validate > Emu.validate.log
fathom genome.ann genome.dna -categorize 1000 > Emu.categorize.log
fathom uni.ann uni.dna -export 1000 -plus > Emu.uni-plus.log
mkdir params && cd params
forge ../export.ann ../export.dna > ../Emu.forge.log
cd ..
hmm-assembler.pl Emu params > Emu.hmm
snap Emu.hmm ../../../../Emu.03Run.fa > Emu.snap
