#!/usr/bin/bash -l
#SBATCH -p short -N 1 -n 48 -C ryzen
module load wu-blast
module load workspace/scratch
CPU=48
mkdir -p pep
fixname() {
	FILE=$1
	NAME=$(basename $1 | perl -p -e 's/\.ascomycota\S*$//')
	perl -p -e "s/>/>$NAME|/; s/:/_/g; s/[\(\)\']//g" $FILE/run_ascomycota_odb10/busco_sequences/*/*.faa  > $SCRATCH/$NAME.aa
	nrdb -o pep/$NAME.aa.fasta $SCRATCH/$NAME.aa
}

export -f fixname

parallel -j $CPU fixname ::: $(ls -d ../Bins/bin.*.ascomycota)

parallel -j $CPU fixname ::: $(ls -d ../Comparison/*.ascomycota)
find pep -size 0 | xargs rm

