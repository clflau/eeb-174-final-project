#!/bin/bash/

# This bash script takes 2 arguments. The first argument is the name of the file that contains the list of evm model IDs to use as query; the second argument is the name of the output file on which the results of this script will write.

list_of_genes=$(tail -n +2 ./data/$1 |cut -d "," -f 1 | sort | uniq)

head -n 1 Aurelia_RSEM_10-18-16.TMM.EXPR.100aa.matrix | cut -c 2- > ./data/$2

for gene in $list_of_genes
	do 
		echo $gene 
		grep -m1 $gene ./Aurelia_RSEM_10-18-16.TMM.EXPR.100aa.matrix >> ./data/$2
done

echo "Results stored in ./data/$2"
