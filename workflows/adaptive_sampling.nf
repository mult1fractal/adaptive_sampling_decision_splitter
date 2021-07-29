include { get_decision } from './process/get_decision'
include { create_decision_fastqs } from './process/create_decision_fastqs'
include { decision_plotting } from './process/decision_plotting'
include { decision_plotting_prepare } from './process/decision_plotting_prepare'


workflow adaptive_sampling_wf {
    take:   fastq_gz
            read_until 

    main:   // create a fastq for unblock, no_decision and stop_receiving
                // rename fastq_gz before with map
           // fastq_gz.flatten()
        
            separated_fastqs = create_decision_fastqs(fastq_gz.combine(get_decision(read_until)))
            separated_fastqs.view()
            //seqkit(separated_fastqs.map { it -> it[1] }
            //                .flatten()
            //                .map { it -> [ it.simpleName, it ] })
            decision_plotting(decision_plotting_prepare(read_until))
            

    emit: separated_fastqs
}