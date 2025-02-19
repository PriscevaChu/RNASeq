#!/bin/bash
cd /mnt/c/Users/prisc/Documents/Data_RNASEQ/data/references

mkdir -p reference_transcriptome

cd reference_transcriptome

# Download from the FTP server
wget https://ftp.ensembl.org/pub/release-113/fasta/homo_sapiens/cdna/Homo_sapiens.GRCh38.cdna.all.fa.gz

# Decompress the FASTA file
gzip -d Homo_sapiens.GRCh38.cdna.all.fa.gz