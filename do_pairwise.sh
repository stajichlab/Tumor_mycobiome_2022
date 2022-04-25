#!/usr/bin/bash
#SBATCH -p short -C xeon -n 96 -N 1 --mem 256gb --out pairwise_minimap2.%A.log

module load minimap2
module load parallel
module load workspace/scratch

CPU=2
#if [ ! -d $SCRATCH ]; then
#	mkdir -p $SCRATCH
#fi
if [ ! -z $SLURM_CPUS_ON_NODE ]; then
	CPU=$SLURM_CPUS_ON_NODE
fi
mkdir -p align
for QUERY in $(ls Bins/*.fa)
do
	Q=$(basename $QUERY .fa)
	parallel --tmpdir $SCRATCH -j $CPU \[ \! -f align/${Q}__{/.}.paf \] \&\& minimap2 --cs=long -x asm20 -t 2 -o align/${Q}__{/.}.paf {} $QUERY ::: $(ls NCBI_fungi/*.fasta)
done

#rmdir $SCRATCH
