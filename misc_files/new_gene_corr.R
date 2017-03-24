eye <- read.csv("mean_eye_counts.csv", sep = "\t")
names(eye) <- c("Gene", "E. Planula", "L. Planula", "Polyp",
                "E. Strobila", "L. Strobila", "Ephyra", "Juvenile")
library(matrixStats)
row_median_vector2 <- rowMedians(as.matrix(eye[2:8] + 1))
eye_cent <- log2(eye[2:8] + 1) - log2(row_median_vector2)
eye[2:8] <- eye_cent


# name the rows
rownames(eye) <- eye$Gene
colnames(eye)
eye_genes <- eye[, -1]
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
corrplot(gene_corrs, type = "lower", method="ellipse", order ="AOE")
dev.off()