#!/usr/bin/env bash

for chr in *.fasta
do

length=$( sed -e '1d' $chr | wc -c )

for (( i=1, j=$1; j<=$length; i=i+$1+$2, j=j+$1+$2 )); do echo $i $j >> coordinates_${chr%.fasta}.txt; done

maximum=$(awk 'BEGIN {max = 0} {if ($2>max) max=$2} END {print max}' coordinates_${chr%.fasta}.txt)
echo $maximum
sed -i -e "s/$maximum/$length/" coordinates_${chr%.fasta}.txt

cat coordinates_${chr%.fasta}.txt | while read start stop ; do seqkit subseq -r $start:$stop $chr > "seq_"$start".fna"; sed -i -e "s/>/\>Coord:$start-$stop /g" "seq_"$start".fna"; done

cat seq*.fna > all_seq_${chr%.fasta}.fna
rm -r seq*.fna *.fai

sed -i 's/ /\t/g' coordinates_${chr%.fasta}.txt

awk -F "\t" -v chrname="${chr%.fasta}" '{ FS = OFS = "\t" } {print "Coord",$0,chrname,"FALSE","plus","det","LOC","no","type","code","code1","no1"}' coordinates_${chr%.fasta}.txt > coord_tab_${chr%.fasta}.int.csv

rm -r *.txt

done

cat *.fna > gene.fasta
rm -r *.fna
cat *.int.csv > coordinates_dataset.csv
rm -r *.int.csv
