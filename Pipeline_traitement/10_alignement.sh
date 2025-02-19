cd /mnt/c/Users/prisc/Documents/Etudes/RNA_melanome_rawdata/
mkdir -p out/05_salmon_quantification/

#salmon quant
#--seqBias will enable it to learn and correct for sequence-specific biases in the input data
#--GCbias will enable it to learn and correct for fragment-level GC biases in the input data
#--validateMapping is  now the default mapping strategy, add this option will not change the command

salmon quant -i ../RNA_SEQ/out/salmon_index/human_cdna.salmon_index \
             -l A \
             -p 13 \
             -1 out/03_trimming/output_trim/SRR14004962_trim_R1.fastq.gz \
             -2 out/03_trimming/output_trim/SRR14004962_trim_R2.fastq.gz \
             -o out/05_salmon_quantification/SRR14004962.salmon \
             --seqBias \
             --gcBias