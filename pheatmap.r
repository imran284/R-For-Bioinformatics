library(ggplot2)
library(dplyr)

p_DEGs <- read.csv(file = "H:\\DOWNLOAD\\Exect gene corr\\Bio file\\common\\UP common logfc .csv")

# SARS Cov-2 DEGs Heatmap
# Custom x and y labels with cexRow and labRow (col respectively)
rnames <- p_DEGs[,1]
mat_data <- data.matrix(p_DEGs[,2:3])
rownames(mat_data) <- rnames

# creates a own color palette from red to green
my_palette <- colorRampPalette(c("Beige", "orange", "gray"))(n = 299)
# (optional) defines the color breaks manually for a "skewed" color transition
col_breaks = c(seq(-1,0,length=100),  # for red
               seq(0.01,0.8,length=100),           # for yellow
               seq(0.81,1,length=100))             # for green
heatmap(mat_data, scale="row", col = my_palette, cexRow = 0.5, Rowv = NA, legend="none")


#mat_data<-as.matrix(All108genes_COVID_ASthema_COPD_CF_IPF_LFCtable)
#mat_data<-as.matrix(p_DEGs)
mat_data
par(mar=c(-1,1))
#pheatmap(mat_data, scale = "row", Rowv = NA, col=my_palette)

#pheatmap
library(pheatmap)
pheatmap(mat_data,  fontsize = 8,treeheight_col = 20)
pheatmap(mat_data,  fontsize = 10,treeheight_col = 20, col=colorRampPalette(c("white","red"))(200))

