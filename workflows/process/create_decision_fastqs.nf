process create_decision_fastqs {
    publishDir "${params.output}/fastqs_separated/", mode: 'copy', pattern: "*.fastq.gz"
    label 'seqkit'
    input:
        tuple val(name), path(fastq), path(readuntil), path(readuntil), path(readuntil)
        //3 times readuntil caus file gets "used"
    output:
        tuple val(name), path("*.fastq.gz")
    script:
        """
        for i in *.txt ; do
            decision=\$(echo "\$i" | cut -d "_" -f1 )
            ### easier names rejected not_rejected
            	if [[ "\$decision" == "unblock"* ]]
	        then 
	            decision="rejected"
	        elif [[ "\$decision" == "stop"* ]]
	        then
	            decision="accepted"
	        else
	            decision="undecided"
	        fi

            seqkit grep --pattern-file \$i ${fastq} >> "\$decision"_${name}.fastq
            gzip "\$decision"_${name}.fastq           
        done

        cat accepted*${name}.fastq.gz undecided*${name}.fastq.gz > unrejected_${name}.fastq.gz
        """
}
// https://bioinformatics.cvr.ac.uk/essential-awk-commands-for-next-generation-sequence-analysis/
