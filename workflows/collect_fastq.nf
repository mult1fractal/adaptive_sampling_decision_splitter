include { collect_fastq } from './process/collect_fastq'
include { demultiplex } from './process/demultiplex'

workflow collect_fastq_wf {
    take: 
        fastq_dir  
    main:
        if (params.demultiplex && !params.single) { collect_fastq(demultiplex(fastq_dir)) }
        if (!params.demultiplex && params.single) { collect_fastq(fastq_dir) }
        fastq_channel = collect_fastq.out
                            .map { it -> it[1] }
                            .flatten()
                            .map { it -> [ it.simpleName, it ]
       
       // collect_fastq(demultiplexed_fastq_dir.out)
      
       /*  else { fastq_channel = collect_fastq.out
                            .map { it -> it[1] }
                            .flatten()
                            .map { it -> [ it.simpleName, it ] } */

        }

    emit: fastq_channel
} 