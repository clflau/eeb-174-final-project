###eye correlation###

#Are the expression of eye genes correlated?

eye_genes <- read.csv("mean_eye_counts.csv", sep = "\t", as.is = T)
dim(eye_genes)

# name the rows
rownames(eye_genes) <- eye_genes$X
colnames(eye_genes)
eye_genes <- eye_genes[, -1]
head(eye_genes)

# initialize matrix
gene_corrs <- matrix(NA, nrow = nrow(eye_genes), ncol = nrow(eye_genes))
rownames(gene_corrs) <- rownames(eye_genes)
colnames(gene_corrs) <- rownames(eye_genes)
head(gene_corrs)

# fill correlation matrix
for (ii in rownames(eye_genes)){
  for (jj in rownames(eye_genes)) {
    corr = cor(as.numeric(eye_genes[ii, ]), 
               as.numeric(eye_genes[jj, ]))
    gene_corrs[ii, jj] <- corr
  }
}

library(corrplot)
pdf("eye_genes_corr_heatmap.pdf", width = 15, height = 15)
corrplot(gene_corrs, type = "lower")
dev.off()

#=============================
# ratios

eye_genes_ratios <- eye_genes / rowSums(eye_genes)

heatmap(as.matrix(eye_genes_ratios), Colv = NA) # normalized by total expression per gene across all stages

heatmap(as.matrix(eye_genes), Colv = NA)

# heatmap of all cluster3 genes
cluster3 <- read.csv("mean_cluster3_counts.csv", sep = "\t", as.is = T)
dim(cluster3)

rownames(cluster3) <- cluster3$X
colnames(cluster3)
cluster3 <- cluster3[, -1]
head(cluster3)

library(matrixStats)
library(gplots)
# Center the data (log2(tmm+1)-log2(median))
row_median_vector <- rowMedians(as.matrix(cluster3 + 1))
cluster3_cent <- log2(cluster3 + 1) - log2(row_median_vector)
head(cluster3_cent)
pdf("cluster3_heatmap_centered.pdf", width = 15, height = 15)
heatmap.2(as.matrix(cluster3_cent), col = redgreen(75), Colv = NA, dendrogram = "row", labRow = "", trace = "none")
dev.off()

# Center around row means?
cluster3_centr <- cluster3 / rowMeans(cluster3)
head(cluster3_centr)
heatmap(as.matrix(cluster3_centr), Colv = NA, labRow = "")

# Log2?
# cluster3_log2 <- log2(cluster3+0.001)
# head(cluster3_log2)
# heatmap(as.matrix(cluster3_log2), Colv = NA, labRow = "")

library(gplots)
pdf("cluster3_heatmap.pdf", width = 15, height = 15)
heatmap.2(as.matrix(cluster3_centr), scale = "row", Colv = NA, dendrogram = "row", trace = "none")
dev.off()

#check distribution of row sums
quantile(rowSums(cluster3))
cluster3_subset <- cluster3[rowSums(cluster3) > 5000, ]
nrow(cluster3_subset)

#=======================

### correlation of eye genes with the rest of cluster 3###
cluster3 <- read.csv("mean_cluster3_counts.csv", sep = "\t", as.is = T)
dim(cluster3)

rownames(cluster3) <- cluster3$X
colnames(cluster3)
cluster3 <- cluster3[, -1]
head(cluster3)

gene_corrs_c3 <- matrix(NA, nrow = nrow(cluster3), ncol = nrow(eye_genes))
rownames(gene_corrs_c3) <- rownames(cluster3)
colnames(gene_corrs_c3) <- rownames(eye_genes)
head(gene_corrs_c3)
pval.df <- matrix(NA, nrow = nrow(cluster3), ncol = nrow(eye_genes))
rownames(pval.df) <- rownames(cluster3)
colnames(pval.df) <- rownames(eye_genes)

for (ii in rownames(cluster3)){
  for (jj in rownames(eye_genes)) {
    pval <- cor.test(as.numeric(cluster3[ii, ]), 
                     as.numeric(eye_genes[jj, ]))$p.value
    pval.df[ii, jj] <- pval
    # only retain significant values
    
    # if (pval.df[ii, jj] < 0.05){
    #   gene_corrs_c3[ii, jj] <- corr
    # }
    }
}
View(pval.df)
pval.df[!complete.cases(pval.df), ]

corr <- cor(as.numeric(cluster3[ii, ]), 
            as.numeric(eye_genes[jj, ]))


pdf("eye_genes-clust3_corr_heatmap.pdf", width = 15, height = 15)
corrplot(gene_corrs_c3, type = "lower")
dev.off()


###TEST###
#testing correlation
xx <- c(4, 3, 2, 4, 16)
yy <- c(2, 3, 4, 3, 8)
plot(xx)
plot(yy)
plot(yy ~ xx)
cor(xx, yy)
p_value <- cor.test(xx, yy)$p.value

