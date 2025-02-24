#!/bin/bash

cd /mnt/c/Users/prisc/Documents/Data_RNASEQ/data/references/reference_genome

wget https://ftp.ensembl.org/pub/release-109/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.chromosome.1.fa.gz
wget https://ftp.ensembl.org/pub/release-109/gtf/homo_sapiens/Homo_sapiens.GRCh38.109.gtf.gz

gunzip Homo_sapiens.GRCh38.dna.chromosome.1.fa.gz
gunzip Homo_sapiens.GRCh38.109.gtf.gz

cd /mnt/c/Users/prisc/Documents/Data_RNASEQ

STAR --runThreadN 7 \
--runMode genomeGenerate \
--genomeDir out/references/star_index \
--genomeFastaFiles data/references/reference_genome/Homo_sapiens.GRCh38.dna.chromosome.1.fa \
--sjdbGTFfile data/references/reference_genome/Homo_sapiens.GRCh38.109.gtf \
--sjdbOverhang 99 \
--genomeSAindexNbases 12 