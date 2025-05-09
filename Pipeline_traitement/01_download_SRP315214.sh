#!/bin/bash

# Lien vers les données
# https://www.ncbi.nlm.nih.gov/Traces/study/?acc=PRJNA722734&o=acc_s%3Aa

# SRA id to download
sra_accessions="SRR14267547
SRR14267548
SRR14267550
SRR14267551
SRR14267552
SRR14267553
SRR14267554
SRR14267555
SRR14267556
SRR14267557
SRR14267558
SRR14267559
SRR14267560
SRR14267561
SRR14267562
SRR14267563
SRR14267564
SRR14267566"

# La méthode la plus rapide est de prefecth les données avant de les télécharger

for SRR in $sra_accessions
do
    echo %time%
    echo "Prefetch $SRR" 
    prefetch "$SRR"
    
    echo "Download $SRR"
    fastq-dump --outdir C:/Users/prisc/Documents/Etudes/RNA_SEQ/data/data_SRP315214 --gzip "$SRR" #--split-files quand PAIRED END (2 reads complémentaires)
    echo "=============================="
done