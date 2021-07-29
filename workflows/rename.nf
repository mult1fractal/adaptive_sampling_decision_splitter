process rename {
    label 'ubuntu'
    publishDir "${params.output}/renamed_fastqs/", mode: 'copy', pattern: "*.fastq.gz"
    input:
        tuple val(name), path(fastq)       
    output:
        tuple val(name), path("*.fastq.gz"), emit: reads optional true
    script:
        """
        mv ${fastq} ${name}.fastq.gz
        """
}