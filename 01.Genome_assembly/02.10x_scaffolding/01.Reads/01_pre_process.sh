#!/bin/bash

#SBATCH --job-name=00_pre_process
#SBATCH --partition=basic
#SBATCH --cpus-per-task=1
#SBATCH --mem=20000
#SBATCH --mail-type=ALL
#SBATCH --output=00_pre_process.o
#SBATCH --error=00_pre_process.e

cd /scratch/LiuJing/Emu/10XData/00_Reads/

perl Rename.pl /proj/LiuJing/Emu/10XData/00_Reads/10X.Reads.1.fq.gz $TMPDIR/10X.rename.1.fq

perl Rename.pl /proj/LiuJing/Emu/10XData/00_Reads/10X.Reads.2.fq.gz $TMPDIR/10X.rename.2.fq

echo "Rename done!";

/home/user/liu/Software/Scaff10x/scaff_BC-reads-1 $TMPDIR/10X.rename.1.fq $TMPDIR/10X_BC_1.fastq $TMPDIR/10X_BC_1.name > 01_BC_Extract.log

perl correct.1.pl $TMPDIR/10X_BC_1.fastq $TMPDIR/10X_BC_1.fastq.2

mv $TMPDIR/10X_BC_1.fastq.2 $TMPDIR/10X_BC_1.fastq

rm $TMPDIR/10X.rename.1.fq

perl correct.2.pl $TMPDIR/10X_BC_1.name $TMPDIR/10X_BC_1.name.2

mv $TMPDIR/10X_BC_1.name.2 $TMPDIR/10X_BC_1.name

/home/user/liu/Software/Scaff10x/scaff_BC-reads-2 $TMPDIR/10X_BC_1.name $TMPDIR/10X.rename.2.fq $TMPDIR/10X_BC_2.fastq >> 01_BC_Extract.log

rm $TMPDIR/10X.rename.2.fq

echo "scaff_BC-reads done!";

perl rmNmer1.pl $TMPDIR/10X_BC_1.fastq $TMPDIR/10X_BC_1.fastq.2

mv $TMPDIR/10X_BC_1.fastq.2 ./10X_BC_1.fastq

perl rmNmer1.pl $TMPDIR/10X_BC_2.fastq $TMPDIR/10X_BC_2.fastq.2

mv $TMPDIR/10X_BC_2.fastq.2 ./10X_BC_2.fastq

