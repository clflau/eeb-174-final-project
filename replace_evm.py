
# coding: utf-8

# In[25]:

# This python script replaces gene model names in expression count files with the Swissprot annotations (if available)
# Swissprot annotations are the top blastx hits of the gene model sequences; these are stored in the annotation.csv file

# The annotation.csv file is created using the following shell pipeline:
# cat trinotate_annotation_report.11_8_16.csv | cut -d "," -f 1,3 | sed 's/\"//g' > annotation.csv

# This script requires the following files:
# annotation.csv - contains the gene model names and top blastx Swissprot hits
# an expression count file - contains the expression data of genes models


import sys
import re
import csv

with open("annotation.csv", newline = "\n") as annotations:
    annotations.readline()
    annotation_reader = csv.reader(annotations, delimiter = ",")
    # create dictionary of annotations
    model_name_list = []
    sprot_anno_list = []
    for row in annotation_reader:
        model_name_list.append(row[0])
        sprot_anno_list.append(row[1])
    annotations_dict = {}
    for ii in range(len(model_name_list)):
        annotations_dict[model_name_list[ii]] = sprot_anno_list[ii]


# In[55]:

with open(sys.argv[1], newline = "\n") as count_file: # replace with sys.argv[1] later
    header_line = count_file.readline().strip()
    count_reader = csv.reader(count_file, delimiter='\t')
    # pseudocode
    # for each row in count_reader, use row[0] as key in annotations_dict to find corresponding dict value
    # if the returning dict value is '.', do nothing, continue to next row
    # if the returning dict value is NOT '.', replace row[0] with that dict value
    new_row_list = []
    for row in count_reader:
        if annotations_dict[row[0]] != '.':
            row[0] = annotations_dict[row[0]]
            new_row_list.append(row)
        else:
            new_row_list.append(row)

# What if multiple gene models Blast matched to the same Swissprot?            

first_item = []  # make list of all gene model/Swissprot annotations          
for item in new_row_list:
    first_item.append(item[0])
        
        
from collections import defaultdict

def list_duplicates(list_with_dups):
    tally = defaultdict(list)
    for i,item in enumerate(list_with_dups):
        tally[item].append(i)
    dup_list = []
    for key, index in tally.items():
        if len(index) > 1:
            dup_list.append(index)
    return dup_list

dup_list = list_duplicates(first_item)

# for all duplicate Swissprot names, add in a number at the end to make them all different
for item in dup_list:
    for ii in item:
        new_row_list[ii][0] = new_row_list[ii][0] + "({})".format(ii)            
            
            
            
            
# Write to file            
with open(sys.argv[1][:-4] + "_evm_replaced.csv", "a") as outfile: # replace with sys.argv[1][:-4] + "_evm_replaced.csv"
    outfile.write("\t" + header_line + "\n")
    writer = csv.writer(outfile, delimiter = "\t")
    writer.writerows(new_row_list)

print("Results are stored in " + sys.argv[1][:-4] + "_evm_replaced.csv")

