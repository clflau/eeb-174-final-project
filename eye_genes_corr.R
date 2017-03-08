# eye correlation

#Are the expression of eye genes correlated?

eye_genes <- read.csv("mean_eye_counts.csv", sep = "\t", as.is = T)
dim(eye_genes)

# name the rows
rownames(eye_genes) <- eye_genes$X
colnames(eye_genes)
eye_genes <- eye_genes[, -1]
head(eye_genes)

gene_corrs <- matrix(NA, nrow = nrow(eye_genes), ncol = nrow(eye_genes))
rownames(gene_corrs) <- rownames(eye_genes)
colnames(gene_corrs) <- rownames(eye_genes)
head(gene_corrs)

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


###TEST###
#testing correlation
xx <- c(2, 8, 10, 16, 18)
yy <- c(4, 16, 20, 16, 4)

plot(yy ~ xx)
cor(xx, yy)
p_value <- cor.test(xx, yy)$p.value

