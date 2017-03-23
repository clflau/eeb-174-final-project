#!/bin/bash/

# This bash script is functionally equivalent to my Aurelia_gene_count_finder.py python script. It is, however, much more efficient and runs A LOT faster. I also discovered that my python script makes errors, as in some gene entries will be duplicated. I have not figured out why that is. This bash script should work just fine.

list_of_genes=$(tail -n +2 $1 |cut -d "," -f 1 | sort | uniq)
echo $list_of_genes

head -n 1 Aurelia_RSEM_10-18-16.TMM.EXPR.100aa.matrix | cut -c 2- > $2

for gene in $list_of_genes
	do 
		echo $gene 
		grep -m1 $gene ./Aurelia_RSEM_10-18-16.TMM.EXPR.100aa.matrix >> $2
done
