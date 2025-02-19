#!/bin/bash

# Se mettre dans le bon dossier dans l appli pour utiliser la commande fastq-dump
cd /mnt/c/Users/prisc/Documents/Etudes/RNA_melanome_rawdata/

# Dossier contenant les fastq
dir_fastq="out/03_trimming/output_trim/"

# Dossier où mettre les résultats
dir_results="out/04_QC_fastqc_post_trim"

echo "running fastqc"
fastqc -o "out/04_QC_fastqc_post_trim" ${dir_fastq}*gz