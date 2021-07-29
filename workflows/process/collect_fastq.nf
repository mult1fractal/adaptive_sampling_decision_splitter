process collect_fastq {
        label 'ubuntu'
        //publishDir "${params.output}/${name}/", mode: 'copy', pattern: "*.fastq.gz"
    input:
        tuple val(name), path(dir)
    output:
        tuple val(name), path("*.fastq.gz"), emit: reads optional true
    script:
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
