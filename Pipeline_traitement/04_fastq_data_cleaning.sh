#!/bin/bash

cd /mnt/c/Users/prisc/Documents/

# EN SINGLE END

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

# EN PAIRED-END

output_dir_trimmed_data=out/03_trimming/output_trim
output_dir_report=out/03_trimming/report_trimming
input_dir="out/01_raw_rnaseq"

mkdir -p $output_dir_trimmed_data $output_dir_report

cd out/01_raw_rnaseq
file_names=$(echo *_R1.fastq.gz)
samples=$(echo $file_names | sed -e 's/_R1.fastq.gz//g')

cd /mnt/c/Users/prisc/Documents/Etudes/RNA_melanome_rawdata

for s in $samples
do

  echo Prefix : $s
  echo ""
  
  fastp --thread 7 \
        --qualified_quality_phred 30 \
        --detect_adapter_for_pe \
        --in1  ${input_dir}/${s}_R1.fastq.gz \
        --in2  ${input_dir}/${s}_R2.fastq.gz \
        --out1 ${output_dir_trimmed_data}/${s}_trim_R1.fastq.gz \
        --out2 ${output_dir_trimmed_data}/${s}_trim_R2.fastq.gz \
        --html ${output_dir_report}/${s}_trim_fastp.html \
        --json ${output_dir_report}/${s}_trim_fastp.json \
        --report_title ${s}

  echo ""
  echo "============================================================"
  echo ""
done
#--length_required 80 \

# Run time ~ 3min / sample