#!/bin/bash
cd /mnt/c/Users/prisc/Documents/

output_dir_trimmed_data=Etudes/RNA_SEQ/out/output_trim
output_dir_report=Etudes/RNA_SEQ/out/report_trimming

mkdir -p $output_dir_trimmed_data $output_dir_report

for full_filenameSE in Etudes/RNA_SEQ/data/data_SRP315214/*gz
do
  #For each SE fastq file
  echo Path : $full_filenameSE treatment:
  
  filenameSE=$(basename $full_filenameSE)
  prefix=${filenameSE/.fastq.gz/}
  
  output_SE_trim="$output_dir_trimmed_data/${prefix}_trim.fastq.gz"
  
  echo Prefix : $prefix
  echo full_filenameSE: $full_filenameSE
  echo output_SE_trim: $output_SE_trim
  
  fastp --thread 7 \
        --qualified_quality_phred 30 \
        --length_required 80 \
        --in1  ${full_filenameSE} \
        --out1 ${output_SE_trim} \
        --html ${output_dir_report}/${prefix}_trim_fastp.html \
        --json ${output_dir_report}/${prefix}_trim_fastp.json \
        --report_title ${prefix}
done