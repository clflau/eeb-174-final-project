source("lineplot_stages.R")

lineplot_stages("mean_pou_gene_counts_evm_replaced.csv", "POU")
ggsave("POU_genes_lineplot.pdf")

source("hierarchical_clustering.R")
pdf(file = "POU_genes_heatmap.pdf", width = 12, height = 8)
heatmap.cordist("mean_pou_gene_counts_evm_replaced.csv")
dev.off()


pdf(file = "Usher_heatmap.pdf", width = 12, height = 8)
heatmap.cordist("mean_usher_counts_evm_replaced.csv")
dev.off()


pdf(file = "Cluster3_heatmap.pdf", width = 12, height = 8)
heatmap.cordist("mean_cluster3_counts_evm_replaced.csv")
dev.off()
