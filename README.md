# **SubSequencesExtractor**
This script extracts subsequences of specified length and distance from a given sequence, such as a chromosome. To use this script, you need FASTA files containing the chromosome or sequence of interest. The files must be in FASTA format and named with a ".fasta" extension, such as "2R.fasta". For instance, if you are working with the **Drosophila suzukii** genome downloaded from NCBI ( ), you can generate the FASTA files for each chromosome using the following command:

`awk -F " |," '/^>/ {s=$7".fa"}; {print > s}' GCF_037355615.1_Dsuz_RU_1.0_genomic.fna`

The resulting files will be in multiline format. To convert these to singleline format, use:

`for i in *.fa; do seqtk seq $i > ${i%.fa}".fasta"; done`

## Running
To run the script, use the command:
`./script.sh 4000 10000`
Here, 4000 is the length of the subsequences and 10000 is the distance between each subsequence. For example, the first subsequence will span from coordinates 1 to 4000, the next will span from 14000 to 18000, and so on. 
The last coordinate will be the length of the sequence, even if the extracted subsequence will not be 4000 nucleotides. The last subsequence may be longer if the total length of the sequence is not an exact multiple of 4000.
