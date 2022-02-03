
setwd("C:\\Users\\Tonmoy\\Desktop\\DATASET BIO\\GSE152641      Count")
library(DESeq2)
#library(DESeq)
# see vignette for suggestions on generating
# count tables from RNA-Seq data
data<-read.delim("C:\\Users\\Tonmoy\\Desktop\\DATASET BIO\\GSE152641      Count\\New Text Document.txt", header =TRUE, row.names=1, sep = ",")
head(data)

# Needs when row names not mentioned. Then the first column will be assigned as row names.
#row.names(data) <- make.names(data[,1],TRUE)
#head(data)

#Drop Samples
data <- data[-c(3:14,24:36)]

data<-as.matrix(data[,])
#data<-data[,-1]

mode(data)<-"integer"

#cnts <- matrix(rnbinom(n=1000, mu=100, size=1/0.5), ncol=10)
cnts<-as.matrix(data)
head(cnts)

#cond <- factor(rep(1:2, each=5))
#cond <- factor(c(2, rep(2:1, each=5)))
#cond <- factor(rep(1:2, c(15,6)) )
#cond <- factor(rep(2:1, c(12,11)))
cond <- c(1,1,1,1,1,2,2,2,2,1,1,1,2,1,2,1,1,2,1,1,2,1,2,2,2,2,1,1,2,2,1,2,1,1,1,2,2,1,1,1,1,1,1,1,1,1)
cond <- factor(cond)
class(cond)
cond

# object construction
dds<- DESeqDataSetFromMatrix(cnts, DataFrame(cond), ~ cond)

###Filtering
keep <- rowSums(counts(dds)) >= 10  ##no of row usually
dds <- dds[keep,]
# standard analysis
dds2 <- DESeq(dds)
res <- results(dds2)

# an alternate analysis: likelihood ratio test
ddsLRT <- DESeq(dds, test="LRT", reduced= ~ 1)
resLRT <- results(ddsLRT)
#setwd("/home/dm20/Desktop/Recent_work/Bioinformatics/P_2nd/C19")

write.csv(res,"GSE42546_res_signaturedata_depression.csv" )
write.csv(resLRT,"GSE42546_resLRT_signaturedata_depression.csv" )

