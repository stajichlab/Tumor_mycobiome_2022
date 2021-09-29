#!/usr/bin/bash -l
#SBATCH -p short -C xeon -N 1 -n 24 --mem 8gb --out logs/gather.log

module load parallel
CPU=24

mkdir -p busco_peps

gather() {
  cat $1/run_ascomycota_odb10/busco_sequences/*/*.faa > busco_peps/$1.aa.fasta
}
export -f gather

parallel -j $CPU gather ::: $(ls -d *.ascomycota)
