library(ggplot2)
library(dplyr)
library(scales)

p_bubble <- read.csv(file = "H:\\Bioinformatics\\Habib Sir\\Diagram\\Ontologies\\GO Molecular Function 2021\\WIKI.csv")

p_bubble <- mutate(p_bubble, Log10Pvalue = -log10(PValue))

p_bubble_subset <- p_bubble[1:10,]

#size<-Log10AdjPValue +100 
ggplot(p_bubble_subset, aes(x = Log10Pvalue, y=reorder(Signalling_Pathways, (Log10Pvalue)))) + geom_point(aes(size = Log10Pvalue), colour = "springgreen")#"royalblue1", springgreen2


