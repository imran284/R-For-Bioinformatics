#######Volcano plot
library(ggrepel)
p_DEGs <- read.csv(file = "/home/dm20/Desktop/Recent_work/Bioinformatics/DM_3rd_Schizophreniea/code/go (copy).csv")

res_tableOE<-p_DEGs
threshold_OE <- res_tableOE$PValue < 0.05 

res_tableOE$threshold <- threshold_OE 
ggplot(res_tableOE) +
  geom_point(aes(x=Log_FoldChange, y=-log10(PValue), colour=threshold)) +
  ggtitle("Mov10 overexpression") +
  xlab("log2 fold change") + 
  ylab("-log10 adjusted p-value") +
  #scale_y_continuous(limits = c(0,50)) +
  theme(legend.position = "none",
        plot.title = element_text(size = rel(1.5), hjust = 0.5),
        axis.title = element_text(size = rel(1.25)))  

res_tableOE_ordered <- res_tableOE[order(res_tableOE$abs_logFC), ] 

## Create a column to indicate which genes to label
res_tableOE_ordered$genelabels <- ""
res_tableOE_ordered$genelabels[1:10] <- rownames(res_tableOE_ordered)[1:10]

#View(res_tableOE_ordered)

ggplot(res_tableOE_ordered) +
  geom_point(aes(x = Log_FoldChange, y = -log10(PValue), colour = threshold)) +
  geom_text_repel(aes(x = Log_FoldChange, y = -log10(PValue), label = ifelse(genelabels == T, rownames(res_tableOE_ordered),""))) +
  ggtitle("Mov10 overexpression") +
  xlab("log2 fold change") + 
  ylab("-log10 adjusted p-value") +
  theme(legend.position = "none",
        plot.title = element_text(size = rel(1.5), hjust = 0.5),
        axis.title = element_text(size = rel(1.25))) 


#if (!requireNamespace('BiocManager', quietly = TRUE))
#  install.packages('BiocManager')

#BiocManager::install('EnhancedVolcano')
library(EnhancedVolcano)
ras2<-res_tableOE
head(ras2)
#column to index
result <- ras2[-1]
result
row.names(result) <- ras2$Gene_symbol
result
EnhancedVolcano(ras2,
                lab = row.names(ras2),
                x = 'Log_FoldChange',
                y = 'PValue',
                legendLabels=c('Not sig.','Log (base 2) FC','p-value',
                               'p-value & Log (base 2) FC'),
              )
