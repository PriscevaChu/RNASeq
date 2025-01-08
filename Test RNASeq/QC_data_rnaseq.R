setwd("C:/Users/prisc/Documents/Etudes/RNA_SEQ/data")

# install.packages("BiocManager")
# BiocManager::install("SRAdb")
# BiocManager::install("sraR")

library("SRAdb")

if( ! file.exists('SRAmetadb.sqlite.gz') ) {
  sra_dbname <- getSRAdbFile()
} else { 
  sra_dbname <- 'SRAmetadb.sqlite.gz'
}




library("fastqcr")

gse <- getGEO("GSE153946", destdir = "C:/Users/prisc/Documents/Etudes/RNA_SEQ/data/data_bibs")

library(jsonlite)

data <- fromJSON("C:/Users/prisc/Desktop/SRR14267546.lite.1")


sqlfile <- getSRAdbFile()

sra_con <- dbConnect(SQLite(), sqlfile)

