setwd("~/Desktop/eeb-177/final-proj")

cluster3.df <- read.csv("mean_cluster3_counts.csv", sep = "\t", as.is = T)
head(cluster3.df)
# rownames(cluster3.df) <- cluster3.df$X
nondup <- cluster3.df[!duplicated(cluster3.df$X), ]
dim(nondup)
dim(cluster3.df)
rownames(nondup) <- nondup$X
head(nondup)
grp <- nondup$X
grp <- cbind(grp, rep(as.numeric(0), length(grp))) # initiallize a column for factor, fill col with zeros
eye_genes <- read.csv("eye_dev_enrichment_genes.txt", as.is = T)
eye_rows <- which(grp[, 1] %in% eye_genes$X.These.are.gene.IDs.identified.as.driving.eye.development.enrichment.in.cluster.3)
for(ii in eye_rows){
  grp[ii, 2] <- 1
} # replace zeros with ones for eye genes
grp <- as.data.frame(grp)
head(grp)
nondup <- nondup[, -1] # get rid of col X

# DAPC
library(adegenet)
dapc_eye <- dapc(nondup, grp = grp$V2)
scatter.dapc(dapc_eye)
summary(dapc_eye)
##### Does not work! Posterior group assignment zero in the eye genes group

# Just stright up PCA?
# Remove all rows with all zeros
keep_rows <- which(rowSums(nondup) != 0)
nondup <- nondup[keep_rows, ]

# Center the data (log2(tmm+1)-log2(median))
row_median_vector <- rowMedians(as.matrix(nondup + 1))
nondup_cent <- log2(nondup + 1) - log2(row_median_vector)

# eye_pca <- dudi.pca(nondup)
eye_pca <- dudi.pca(nondup_cent)

# Log transform without centering
eye_pca <- dudi.pca(log2(nondup + 1))

summary(eye_pca)
s.corcircle(eye_pca$co)
s.label(eye_pca$tab)
res <- scatter(eye_pca, clab.row = 0)
screeplot(eye_pca)



#duplicates??!!
dup <- cluster3.df$X[duplicated(cluster3.df$X)]

temp <- cluster3.df[1:6,]
rownames(temp) <- temp$X
temp
anyDuplicated(cluster3.df)

for (gene in cluster3.df$X){
  if (duplicated(gene)== F)
    print(gene)
  }




###########################################
# non-averaged data

cluster3_all <- read.csv("cluster3_counts.txt", sep = "\t", as.is = T)
head(cluster3_all)
cl3.pca <- dudi.pca(log2(cluster3_all + 1))
summary(cl3.pca)
s.corcircle(cl3.pca$co)
s.label(cl3.pca$tab)
scatter(cl3.pca, clab.row = 0)
screeplot(eye_pca)
