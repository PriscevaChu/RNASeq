cd /mnt/c/Users/prisc/Documents/Data_RNASEQ/out/out_SRP315214
mkdir -p salmon_quantification/

#salmon quant
#--seqBias will enable it to learn and correct for sequence-specific biases in the input data
#--GCbias will enable it to learn and correct for fragment-level GC biases in the input data
#--validateMapping is  now the default mapping strategy, add this option will not change the command

# Add loop over samples

# EN PAIRED-END

sample="xxxxx"

salmon quant -i ../references/salmon_index/human_cdna.salmon_index \
             -l A \
             -p 13 \
             -1 output_trim/${sample}_trim_R1.fastq.gz \
             -2 output_trim/${sample}_trim_R2.fastq.gz \
             -o salmon_quantification/${sample}.salmon \
             --seqBias \
             --gcBias

# EN SINGLE-END