#!/bin/bash
cd /mnt/c/Users/prisc/Documents/Etudes/RNA_SEQ/data

ref_transcriptome="mnt/c/Users/prisc/Documents/Etudes/RNA_SEQ/data/reference_transcriptome/Homo_sapiens.GRCh38.cdna.all.fa"
mkdir -p ../out/salmon_index

#Documentation https://salmon.readthedocs.io/en/latest/salmon.html#preparing-transcriptome-indices-mapping-based-mode
# salmon index
# -t: the path to the transcriptome file (in FASTA format)
# -i: the path to the folder to store the indices generated
# -k: the length of kmer to use to create the indices (will output all sequences in transcriptome of length k)
# -p: the number of threads
# Thus, a smaller value of k may slightly improve sensitivity.
# We find that a k of 31 seems to work well for reads of 75bp or longer, but you might consider a smaller k if you plan to deal with shorter reads. 


# Download salmon from https://github.com/COMBINE-lab/salmon/releases 
salmon index -k 31 -t $ref_transcriptome -p 7 -i ../out/salmon_index/human_cdna.salmon_index