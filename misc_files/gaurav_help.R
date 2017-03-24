# with Clive
cluster3 <- read.csv("mean_cluster3_counts.csv", sep = "\t", as.is = T)

# get rid of dups
cluster3 <- cluster3[!duplicated(cluster3$X), ]

# name the rows
rownames(cluster3) <- cluster3$X
colnames(cluster3)
cluster3 <- cluster3[, -1]
head(cluster3)

# subset to one gene only
early_planula <- cluster3$early.planula
early_planula <- early_planula[1:50]
names(early_planula) <- rownames(cluster3)[1:50]
early_planula
early_planula["evm.model.Seg100.4"]

# make an empty matrix
gene_ratios <- matrix(NA, nrow = length(early_planula), ncol = length(early_planula))
rownames(gene_ratios) <- names(early_planula)
colnames(gene_ratios) <- names(early_planula)


# write a loop that iterates over all genes in early_planula
for (current_gene in names(early_planula)) {
  # now, go through every other gene
  for (other_gene in names(early_planula)) {
    # expression_ratios <- early_planula[current_gene]/(early_planula[other_gene]+.000001)
    gene_ratios[current_gene,other_gene] <- expression_ratios
  }
}






#------------------------
# work with correlations instead of ratios

cluster3sub <- cluster3[1:50, ]

cor(as.numeric(cluster3sub["evm.model.Seg100.4", 1:7]), 
    as.numeric(cluster3sub["evm.model.Seg1080.4", 1:7]))


# make an empty matrix
gene_corrs <- matrix(NA, nrow = length(early_planula), ncol = length(early_planula))
rownames(gene_corrs) <- names(early_planula)
colnames(gene_corrs) <- names(early_planula)

for (current_gene in rownames(cluster3sub)){
  for (other_gene in rownames(cluster3sub)) {
    corr = cor(as.numeric(cluster3sub[current_gene, 1:7]), 
               as.numeric(cluster3sub[other_gene, 1:7]))
    gene_corrs[current_gene, other_gene] <- corr
  }
}

library(corrplot)

pdf("heatmap_for_clive.pdf", width = 15, height = 15)
corrplot(gene_corrs, type = "lower")
dev.off()
