process get_decision {
    publishDir "${params.output}/decision_files", mode: 'copy', pattern: "*_${name}_read_id.txt"
    label 'ubuntu'
    input:
        tuple val(name), path(read_until)
    output:
        path("*_${name}_read_id.txt")
    script:
        """
        ## get all decisions of read until file
        cat ${read_until} | tail -n+2 | cut -d"," -f8 | sort -u > decision_list.txt

        ##  create read- id list per decision
        while read line; do  
            grep -w "\$line" ${read_until} | cut -d"," -f6 | sort -u > "\$line"_${name}_read_id.txt 
            done < decision_list.txt

        ## remove dupes from no decision that are in unblock 
        grep -Fvxf unblock*_read_id.txt no_decision*_read_id.txt > minus-deplete.csv
        ## remove dupes from no decision that are in stop_receiving
        grep -Fvxf stop_*_read_id.txt minus-deplete.csv > no_decision_${name}_read_id.txt
        """
}



// read1 no <<<
// read1 no <<<< no read
// read1 unbl  unblock read
