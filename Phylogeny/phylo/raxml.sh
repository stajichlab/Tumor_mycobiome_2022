#!/bin/bash
#SBATCH --nodes 1 --ntasks 16 --mem 24G --out raxml.log --time 36:00:00 -J raxmlZoopag 

module load RAxML
CPUS=2
if [ ${SLURM_CPUS_ON_NODE} ]; then
 CPUS=${SLURM_CPUS_ON_NODE}
fi
PREF=Kickxello2021LCG.193_taxa.fungi_odb10.aa
raxmlHPC-PTHREADS-SSE3 -s ${PREF}.fasaln -n ${PREF}_Run1 -m PROTGAMMAAUTO -f a -x 1221 -p 7789 -# autoMRE -T $CPUS -o Synfus1
