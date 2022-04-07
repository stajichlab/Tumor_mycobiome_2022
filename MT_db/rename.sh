perl -i -p -e 's/>(\S+\s+\S+\s+\S+\s+CDS translation )\[([^\]]+)\]/>$2 $1/' atp6.pep
