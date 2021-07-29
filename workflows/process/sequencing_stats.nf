process sequencing_stats {
    publishDir "${params.output}/stats/", mode: 'copy', pattern: "Sequencing_stats.csv"
    label 'ubuntu'
    input:
        path(fastq)
    output:
        path("Sequencing_stats.csv")
    script:
        """
        bash sequencing_stats.sh
        """
}