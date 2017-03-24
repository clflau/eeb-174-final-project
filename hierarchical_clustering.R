# Hierarchical clustering on correlation, not euclidean distance

heatmap.cordist <- function(file){
  file_data <- read.csv(file, sep = "\t")

  names(file_data) <- c("Gene", "E. Planula", "L. Planula", "Polyp",
                        "E. Strobila", "L. Strobila", "Ephyra", "Juvenile")
  rownames(file_data) <- file_data$Gene
  colnames(file_data)
  file_data <- file_data[, -1]

  # sort on max difference
  min <- apply(file_data, 1, min)
  max <- apply(file_data, 1, max)
  s_file_data <- file_data[order(max - min, decreasing = T), ]

  cor_matrix <- cor(t(s_file_data))
  cor_dist_matrix <- 1-cor_matrix
  plot(cor_dist_matrix, main = "Gene expression pairwise correlation distance", 
       xlab = "row", ylab = "column")
  hc <- hclust(as.dist(cor_dist_matrix), method = "ward.D2")
  # plot(hc, cex = 0.4)

# cut tree at desired height (h = 0.5)
# gene_partition_assignments <- cutree(hc, h=0.5/100*max(hc$height))

  library(gplots)
  hp <- heatmap(as.matrix(s_file_data), Rowv = as.dendrogram(hc), 
                Colv = NA, col = greenred(10), margins = c(6, 6), 
                cexRow = 0.5, cexCol = 0.93)
  return(hp)
}

#####################################################################



