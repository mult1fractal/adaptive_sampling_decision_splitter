process pavian_metrics {
    publishDir "${params.output}/stats/", mode: 'copy', pattern: "*.csv"
    label 'ubuntu'
    input:
        path(pavian)
    output:
        path("*.csv")
    script:
        """
        bash pavian_metrics.sh
        """
}