#!/usr/bin/bash -l
#SBATCH -p batch -N 1 -n 32 --mem 24gb

CPU=8
#if [ $SLURM_CPUS_ON_NODE ]; then
#  CPU=$SLURM_CPUS_ON_NODE
#fi

module load busco
module load parallel

parallel -j 4 busco --in {} -o {.}.ascomycota -l ascomycota_odb10 -m geno -c $CPU ::: $(ls *.fa)

