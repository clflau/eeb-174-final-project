# This python script is a function that takes a txt file containing some gene IDs as argument, and searches for the expression counts of these genes in the transcriptome of Aurelia, and outputs a file of the count data for those genes.

data_list = []
def GeneCountFinder():
	import sys
	import re
	with open(sys.argv[1]) as gene_quarry:
		quarry_list = gene_quarry.readlines()
		with open("/home/eeb177-student/Desktop/eeb-177/final-proj/Aurelia_counts_testfile.matrix", "r") as express_matrix: #open testfile to test script
			for line in express_matrix:
				for ii in quarry_list:
					if re.match(ii, line):
						data_elem = re.match(re.escape(ii) + r'.*$', line)
						data_list.append(data_elem.group(0))
	return data_list

GeneCountFinder()

ticker = 0
outfile = open("genes_counts_of_interest.txt", "w")
while ticker < len(data_list):
    outfile.write(data_list[ticker] + "\n")
    ticker = ticker + 1

outfile.close()


