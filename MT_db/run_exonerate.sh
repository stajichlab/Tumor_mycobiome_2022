#!/usr/bin/bash -l
module load exonerate
exonerate -m p2g --ryo ">%ti %td\n%tcs" -q atp6_Mrestricta.pep -t ../Bins/bin.11.fa
