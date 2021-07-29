process decision_plotting_prepare {
    publishDir "${params.output}/plots/plot_files/", mode: 'copy', pattern: "*.csv"
    label 'template'
    input:
        tuple val(name), path(read_until)       
    output:
        tuple val(name), path("*.csv")
    script:
        """
        pip install numpy
        pip install pandas
        pip install argparse
        decision_plotting_prepare.py --input ${read_until} --output decision_plot.csv
        """
}