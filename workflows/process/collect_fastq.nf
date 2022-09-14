process collect_fastq {
        label 'ubuntu'
        //publishDir "${params.output}/${name}/", mode: 'copy', pattern: "*.fastq.gz"
    input:
        tuple val(name), path(dir)
    output:
        tuple val(name), path("*.fastq.gz"), emit: reads //optional true
    script:
        if (params.single)
        """
        for i in ${dir}; do
            find -L \${i} -name '*.fastq' -exec cat {} + | gzip > ${params.single}.fastq.gz
            find -L \${i} -name '*.fastq.gz' -exec zcat {} + | gzip >> ${params.single}.fastq.gz
        done

        find . -name "*.fastq.gz" -type 'f' -size -1500k -delete
        """
        else 
        """
        for barcodes in ${dir}/barcode??*; do
            find -L \${barcodes} -name '*.fastq' -exec cat {} + | gzip > \${barcodes##*/}.fastq.gz
            find -L \${barcodes} -name '*.fastq.gz' -exec zcat {} + | gzip >> \${barcodes##*/}.fastq.gz
        done
        ## input doesnt recognize 12a ...so rename it here
        ## mv barcode12a.fastq.gz barcode12.fastq.gz
        find . -name "*.fastq.gz" -type 'f' -size -1500k -delete
        """
}
