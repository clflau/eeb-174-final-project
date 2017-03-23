#!/bin/bash/

# This bash script will find genes according to how they are annotated

# The Python way?
#python <<end_of_python
#import sys
#import re

#with open(sys.argv[1]) as quarry:
#	for item in quarry:
#		echo item
#		re.search(item, 



#end_of_python





# Just using Shell
quarry=$(cat $1 | sort -g | uniq)

echo "# quarry results using source file: $1" > outfile.txt

for item in $quarry
	do 
		echo $item
		grep $item trinotate_annotation_report.11_8_16.csv >> outfile.txt
done
