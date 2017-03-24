#!/bin/bash/

# This bash script finds out which clusters a gene from a list belongs to; effectively, this is the reverse function of gene_cluster_finder.py

list_of_genes=$(cat $1 | sort | uniq)

for gene in $list_of_genes
	do 
		echo $gene >> temp
		grep -m1 $gene Cluster_IDs.txt >> outfile.txt
done
