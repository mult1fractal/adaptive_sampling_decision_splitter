process readcount {
    publishDir "${params.output}/stats/", mode: 'copy', pattern: "readcounts.csv"
    label 'ubuntu'
    input:
        path(fastq)
    output:
        path("readcounts.csv")
    script:
        """
        for i in *.fastq.gz ; do
        simplename=\$(basename \$i )
        all_lines=\$(zcat \$i* |wc -l)

        if [[ "\$i" == *"depletion"* ]]
	    then 
	        experiment="deplete"
	    elif [[ "\$i" == *"enrich"* ]]
	    then
	        experiment="enrich"
	    else
	        experiment="deep"
	    fi


        echo \$simplename,"\$(( \$all_lines / 4 ))",\$experiment >>readcounts.csv
        done

        sed -i '1s/.*/Samplename,reads,experiment\\n&/' readcounts.csv
        """
}