#!/bin/bash

# Se mettre dans le bon dossier dans l appli pour utiliser la commande fastq-dump
cd /mnt/c/Users/prisc/Documents/Data_RNASEQ

# Dossier contenant les fastq
dir_fastq="out/out_SRP315214/output_trim"

# Dossier où mettre les résultats
dir_results="out/out_SRP315214/report_trimming"

echo "running fastqc"
fastqc -o $dir_results ${dir_fastq}*gz