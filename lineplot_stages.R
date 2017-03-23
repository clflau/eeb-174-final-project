# Line plot by stages

#' This takes a csv file containing replicate-average TMM expression counts by stages and plots a 
#' line plot of all the genes in the file after log transformation and centering. The function also
#' requires user input on the plot title as the second argument.


lineplot_stages <- function(file, gene_group, plot_mean = T){
  library(matrixStats)
  library(reshape2)
  library(ggplot2)
  
  file_data <- read.csv(file, sep = "\t")
  
  names(file_data) <- c("Gene", "E. Planula", "L. Planula", "Polyp",
                       "E. Strobila", "L. Strobila", "Ephyra", "Juvenile")
  
  # Log transform and center the data 
  row_median_vector <- rowMedians(as.matrix(file_data[2:8] + 1))
  file_data_cent <- log2(file_data[2:8] + 1) - log2(row_median_vector)
  file_data[2:8] <- file_data_cent
  
  # reshape dataframe to "long" version
  
  df1 <- melt(file_data, id = c("Gene"), variable.name = "Stages")
  
  
  p1 <- ggplot() +
    geom_line(data = df1, aes(x = Stages, y = value, group = Gene, color = Gene), alpha = 0.2) +
    geom_point(data = df1, alpha = 0.1, aes(x = Stages, y = value, color = Gene, group = Gene), size = 0.5) +
    theme(legend.position = "none") +
    ggtitle(paste(gene_group, "Genes across stages", sep = " ")) +
    ylab("Centered log2(TMM+1)")
  
  # if plot_mean=T, add in line for mean expression for each stage
  if (!plot_mean) {
    return(p1)
  } else {
    stages <- levels(df1$Stages)
    stage_means <- c()
    for(stage in stages){
      stage_means <- c(stage_means, mean(df1[which(df1$Stages == stage), 3]))
    }
    stage_means <- cbind.data.frame(stages, stage_means)
    stage_means_max <- stage_means[which(stage_means$stage_means == max(stage_means$stage_means)), 1]
    stage_means_min <- stage_means[which(stage_means$stage_means == min(stage_means$stage_means)), 1]
    cat("stage with highest mean expression level:", as.character(stage_means_max), "\n")
    cat("stage with lowest mean expression level:", as.character(stage_means_min), "\n")
  
    p1 <- p1 + geom_line(data = stage_means, aes(x = stages, y = stage_means, group = 1), color = "black", size = 0.8)
    return(p1)
  }
  
  
}