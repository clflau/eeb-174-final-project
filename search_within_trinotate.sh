#!/bin/bash/

# This bash script will batch search within the annotated gene model file for the evm numbers



query=$(cat $1 | sort -g | uniq)

echo "# quarry results using source file: $1" > ./data/outfile.txt

for item in $query
	do 
		echo $item
		grep $item trinotate_annotation_report.11_8_16.csv | cut -d "," -f 1 >> ./data/outfile.txt
done

echo "Results stored in ./data/outfile.txt"
