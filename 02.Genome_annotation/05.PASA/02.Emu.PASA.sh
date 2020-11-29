#!/bin/bash

#SBATCH --job-name=Emu.PASA
#SBATCH --partition=basic
#SBATCH --cpus-per-task=16
#SBATCH --mem=50000
#SBATCH --mail-type=ALL
#SBATCH --output=Emu.PASA.o
#SBATCH --error=Emu.PASA.e

module load sqlite3
module load gmap ucsc blat
module load samtools
export PATH=/scratch/luohao/software/fasta-36.3.8g/bin:$PATH

#/scratch/luohao/software/PASApipeline-v2.3.3/bin/seqclean ./Emu.trinity.out/Trinity.fasta

/scratch/luohao/software/PASApipeline-v2.3.3/Launch_PASA_pipeline.pl -c alignAssembly.config -C -R -g ../Emu.merge.fa -t ./Emu.trinity.out/Trinity.fasta --trans_gtf Emu.stringtie.gtf --ALIGNERS gmap --CPU 16 --TRANSDECODER

/scratch/luohao/software/PASApipeline-v2.3.3/scripts/Load_Current_Gene_Annotations.dbi -c alignAssembly.config -g ../Emu.merge.fa -P ../Lubna/Emu.lubna.gff3

/scratch/luohao/software/PASApipeline-v2.3.3/Launch_PASA_pipeline.pl -c annotationCompare.config -A -g ../Emu.merge.fa -t ./Emu.trinity.out/Trinity.fasta --CPU 16
