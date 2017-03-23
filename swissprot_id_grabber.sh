#!/bin/bash/

# This bash script takes the output fasta file of gene search on swissprot and grabs only the swissprot ID

cat $1 | grep -F '>' | cut -d "|" -f 2 > $2.txt



