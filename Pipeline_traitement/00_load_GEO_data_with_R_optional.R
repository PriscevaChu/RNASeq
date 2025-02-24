# Packages et fonctions pour le télécharmeent de données GEO en r 
# (ne permet pas d'importer les données brutes)

# install.packages("BiocManager")
# BiocManager::install("SRAdb")
# BiocManager::install("sraR")
library("SRAdb")
library("fastqcr")
library("jsonlite")


if( ! file.exists('SRAmetadb.sqlite.gz') ) {
  sra_dbname <- getSRAdbFile()
} else { 
  sra_dbname <- 'SRAmetadb.sqlite.gz'
}

gse <- getGEO("GSE153946", destdir = "C:/Users/prisc/Documents/Etudes/RNA_SEQ/data/data_bibs")

data <- fromJSON("C:/Users/prisc/Desktop/SRR14267546.lite.1")

sqlfile <- getSRAdbFile()

sra_con <- dbConnect(SQLite(), sqlfile)

