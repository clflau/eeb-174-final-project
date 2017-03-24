#!/bin/bash/

# This bash script takes the output of the swissprot webscraping and grabs only the swissprot ID

tail -n +2 $1 | cut -f 1 > ./data/accID.txt

echo "Results stored in ./data/accID.txt"

