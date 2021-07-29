process decision_plotting {
    publishDir "${params.output}/plots", mode: 'copy', pattern: "*.svg"
    label 'ggplot2'
    input:
        tuple val(name), path(read_until)       
    output:
        tuple val(name), path("*.svg")
    script:
        """
        decision_plotting.R
        mv decision_plot.svg ${name}_decision_plot.svg
        """
}