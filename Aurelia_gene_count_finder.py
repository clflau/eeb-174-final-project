# This python script is a function that takes a txt file containing some gene IDs as argument, and searches for the expression counts of these genes in the transcriptome of Aurelia, and outputs a file of the count data for those genes.

data_list = []
def GeneCountFinder():
	import sys
	import re
	with open(sys.argv[1]) as gene_quarry:
		quarry_list = gene_quarry.readlines()
		formatted_quarry_list = []
		for elem in quarry_list[1:]:
			formatted_quarry_list.append(elem.replace("\n", ""))
		print("Quarrying: " + str(formatted_quarry_list))
		with open("/home/eeb177-student/Desktop/eeb-177/final-proj/Aurelia_RSEM_10-18-16.TMM.EXPR.100aa.matrix", "r") as express_matrix: 
			for line in express_matrix:
				for ii in formatted_quarry_list:
					if re.search(ii, line):
						data_elem = re.search(ii + r'.*$', line)
						data_list.append(data_elem.group(0))
	return data_list

quarry_result = GeneCountFinder()

ticker = 0
outfile = open("genes_counts_of_interest.txt", "w")
while ticker < len(quarry_result):
    outfile.write(quarry_result[ticker] + "\n")
    ticker = ticker + 1

outfile.close()


