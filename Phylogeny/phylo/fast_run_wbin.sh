#!/usr/bin/bash
#SBATCH --nodes 1 --ntasks 24 --mem 96gb --time 24:00:00 -p intel --out fasttree_run.%A.log

module load fasttree/2.1.11
module load intel
module unload perl
module unload miniconda2
module load miniconda3
NUM=$(wc -l ../prefix.tab | awk '{print $1}')
source ../config.txt

ALN=../$PREFIX.with_bin.${NUM}_taxa.$HMM.aa.fasaln
TREE1=$PREFIX.with_bin.${NUM}_taxa.$HMM.ft_lg.tre
TREE2=$PREFIX.with_bin.${NUM}_taxa.$HMM.ft_lg_long.tre
TREE3=$PREFIX.with_bin.${NUM}_taxa.$HMM.slow.ft_lg.tre
TREE4=$PREFIX.with_bin.${NUM}_taxa.$HMM.slow.ft_lg_long.tre
if [ ! -s $TREE1 ]; then
	FastTreeMP.dp -lg -gamma < $ALN > $TREE1
	echo "ALN is $ALN"
	if [ -s $TREE1 ]; then
		perl ../PHYling_unified/util/rename_tree_nodes.pl $TREE1 ../prefix.tab > $TREE2
	fi
fi
