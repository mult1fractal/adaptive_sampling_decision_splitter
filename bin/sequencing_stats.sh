#!/bin/env bash

## Nanoplot read quality stats to csv

for i in *_read_quality.txt ; do
    samplename=$(basename $i)
    mean_read_length=$(grep -w "Mean read length" $i | cut -d ":" -f2 | tr -d ',' | tr "." "," | tr "," ".")
    mean_read_quality=$(grep -w "Mean read quality" $i | cut -d ":" -f2 | tr -d ',' | tr "." "," | tr "," "."  )
    median_read_length=$(grep -w "Median read length" $i | cut -d ":" -f2 | tr -d ',' | tr "." "," | tr "," "."  )
    median_read_quality=$(grep -w "Median read quality" $i | cut -d ":" -f2 | tr -d ',' | tr "." "," | tr "," "."   )
    number_of_reads=$(grep -w "Number of reads" $i | cut -d ":" -f2 | tr -d ',' | tr "." "," | tr "," "."  )
    read_length_N50=$(grep -w "Read length N50" $i | cut -d ":" -f2 | tr -d ',' | tr "." "," | tr "," "."  )
    total_bases=$(grep -w "Read length N50" $i | cut -d ":" -f2 | tr -d ',' | tr "." "," | tr "," "." )

    ## get experiment deplete or enrich
	if [[ "$i" == *"depletion"* ]]
	then 
	  experiment="depletion"
	elif [[ "$i" == *"enrich"* ]]
	then
	  experiment="enrich"
	else
	  experiment="deep"
	fi
    echo "$samplename|$mean_read_length|$mean_read_quality|$median_read_length|$median_read_quality|$number_of_reads|$read_length_N50|$experiment" >> Sequencing_stats.csv
done

sed -i '1s/.*/samplename|mean_read_length|mean_read_quality|median_read_length|median_read_quality|number_of_reads|read_length_N50|experiment\n&/' Sequencing_stats.csv
