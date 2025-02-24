#!/bin/bash

cd /mnt/c/Users/prisc/Documents

# Dossier contenant les fastq
dir_fastq="Data_RNASEQ/data/data_SRP315214"

# Dossier où mettre les résultats
dir_results="Data_RNASEQ/data/data_SRP315214/QC_fastq/"

echo "running fastqc"
fastqc -o $dir_results "${dir_fastq}*.fastq.gz"