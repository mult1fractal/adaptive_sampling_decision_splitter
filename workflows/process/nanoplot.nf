process nanoplot {
    label 'nanoplot'
    publishDir "${params.output}/stats/${name}/", mode: 'copy', pattern: "${name}_read_quality_report.html"
    publishDir "${params.output}/stats/${name}/", mode: 'copy', pattern: "${name}_read_quality.txt"
    publishDir "${params.output}/stats/${name}/figures", mode: 'copy', pattern: "*.png"
    publishDir "${params.output}/stats/${name}/vector_figures", mode: 'copy', pattern: "*.pdf"
    
    input:
      tuple val(name), path(reads)
    output:
      tuple val(name), path("*.html"), path("*.pdf"), emit: html optional true
      tuple val(name), path("${name}_read_quality.txt"), path("*.png"), emit: statistics optional true
    script:
      """
      NanoPlot -t ${task.cpus} --fastq ${reads} --title '${name}' --color darkslategrey --N50 --plots hex --loglength -f png --store
      NanoPlot -t ${task.cpus} --pickle NanoPlot-data.pickle --title '${name}' --color darkslategrey --N50 --plots hex --loglength -f pdf
      mv NanoPlot-report.html ${name}_read_quality_report.html
      mv NanoStats.txt ${name}_read_quality.txt
      """
}

/* Comments:
We run nanoplot 2 times to get png and pdf files.
The second time its done via the pickle file of the previous run, to save computing time
*/
