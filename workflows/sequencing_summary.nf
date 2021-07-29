include { pycoqc } from './process/pycoqc'

workflow sequencing_summary_wf {
    take: 
        seq_summary  
    main:
        pycoqc(seq_summary)
} 