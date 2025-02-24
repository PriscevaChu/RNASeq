#!/bin/bash

# Run STAR on one sample
cd /mnt/c/Users/prisc/Documents/Etudes/RNA_melanome_rawdata/out/03_trimming/output_trim

STAR --runThreadN 12 \
     --genomeDir ../../../../../Data_RNASEQ/out/references/star_index \
     --readFilesCommand zcat \
     --readFilesIn SRR14004976_trim_R1.fastq.gz SRR14004976_trim_R2.fastq.gz \
     --outFileNamePrefix ~/apps/res_star/bam/SRR14004976_trim. \
     --outSAMtype BAM SortedByCoordinate \
     --outSAMunmapped Within \
     --outSAMattributes Standard