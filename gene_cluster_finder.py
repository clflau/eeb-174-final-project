# This script will search the file 'Cluster_IDs.txt' with input from user for a specific gene cluster, and will output the gene IDs of genes within that cluster. 

def gene_cluster_finder():
	import re
	clust_num = input("Enter cluster number (1 to 8): ")
	cluster = "Clust" + clust_num
	gene_IDs = []
	with open("Cluster_IDs.txt") as clusterIDs:
		for line in clusterIDs:
			if re.search(cluster, line):
				cluster_search = re.search(cluster + "\t*(.*)\n", line)
				gene_IDs.append(cluster_search.group(1))
	return gene_IDs


gene_IDs = gene_cluster_finder()

file_name = input("Enter name of file for writing output: ")
ticker = 0
outfile = open("{}.txt".format(str(file_name)), "w")
outfile.write("# Genes of interest\n")
outfile.close()
outfile = open("{}.txt".format(str(file_name)), "a")
while ticker < len(gene_IDs):
    outfile.write(gene_IDs[ticker] + "\n")
    ticker = ticker + 1

outfile.close()

