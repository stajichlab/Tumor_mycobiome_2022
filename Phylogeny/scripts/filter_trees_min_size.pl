#!/usr/bin/env perl
use strict;
use Bio::TreeIO;
use Getopt::Long;
# Arguments
# Tree file (with prefix names as the node names)
# Prefix table (from 1KFG/genomes/scripts/make_prefixes.pl)
#  which is tab delimited with 2 columns: 1 is prefix 2 is long name
my $min_count = 5;
GetOptions('m|min:i' => \$min_count);

my $in = Bio::TreeIO->new(-format => 'newick', -fh => \*STDIN);

while( my $tree = $in->next_tree ) {
	my @nodes = grep { $_->is_Leaf } $tree->get_nodes;
	next if @nodes < $min_count;
    Bio::TreeIO->new(-format => 'newick')->write_tree($tree);
    print("\n");
}
