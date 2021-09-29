#!/usr/bin/bash
#SBATCH -p short -C xeon -N 1 -n 2 --mem 96gb --out logs/ASTRAL.%A.log


module load ASTRAL
module unload miniconda2
module load miniconda3
INDIR=gene_trees
OUTDIR=gene_trees_coalescent
PREF=TumorMyco
mkdir -p $OUTDIR
for type in FT_WAG FT_LG FT_JTT; do
    if [ ! -f $OUTDIR/$type.trees ]; then
	cat $INDIR/*.$type.tre | perl -p -e "s/\'//g; my \$c = tr/,/,/; if (\$c < 4) {\$_=''}" | grep "bin\." > $OUTDIR/$type.trees
    fi
    if [ ! -f $OUTDIR/$PREF.$type.ASTRAL.tre ]; then
	echo -i $OUTDIR/$type.trees -t 3 -o $OUTDIR/$PREF.$type.ASTRAL.tre
	java -jar $ASTRALJAR -i $OUTDIR/$type.trees -t 3 -o $OUTDIR/$PREF.$type.ASTRAL.tre
    fi
done

#if [ 0 ]; then
#if [ ! -f $OUTDIR/RAxML.trees ]; then
#	cat $INDIR/RAxML_bestTree.* > $OUTDIR/RAxML.trees
#fi
#if [ ! -f $OUTDIR/$PREF.RAxML.ASTRAL.tre ]; then
#	# could add bootstrapping sub-sampling since there are bootstrap trees in the folder too
#	java -jar $ASTRALJAR -i $OUTDIR/RAxML.trees -t 3 -o $OUTDIR/$PREF.RAxML.ASTRAL.tre
#fi

#fi

module unload miniconda2
module load miniconda3

for file in $(ls $OUTDIR/*.ASTRAL.tre); do b=$(basename $file .tre); perl ../PHYling_unified/util/rename_tree_nodes.pl $file prefix.tab > $OUTDIR/$b.long.tre; done
