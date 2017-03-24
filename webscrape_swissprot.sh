#!/bin/bash/

# This bash script takes as argument a string to use as the query to the uniprot website. It returns
# a tab separated file with unique protein identifiers to be used to search within the annotated 
# Aurelia gene models

query_url="http://www.uniprot.org/uniprot/?query="
query_url+=$1
query_url+="+AND+reviewed:yes&sort=score&columns=id,entry%20name&format=tab"

curl $query_url > ./data/uniprot-$1.txt
echo "results stored in ./data/uniprot-$1.txt"
