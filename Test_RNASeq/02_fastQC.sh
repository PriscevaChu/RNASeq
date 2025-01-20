#!/bin/bash

# Se mettre dans le bon dossier dans l appli pour utiliser la commande fastq-dump
cd /mnt/c/Users/prisc/Documents

# Dossier contenant les fastq
dir_fastq="Etudes/RNA_SEQ/data/data_SRP315214"

# Dossier où mettre les résultats
dir_results="Etudes/RNA_SEQ/data/data_SRP315214/QC_fastq/"

echo "running fastqc"
fastqc -o $dir_results "${dir_fastq}*.fastq.gz"