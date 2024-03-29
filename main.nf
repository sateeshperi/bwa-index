nextflow.enable.dsl=2

params.genome = 's3://ngi-igenomes/igenomes/Homo_sapiens/UCSC/hg38/Sequence/WholeGenomeFasta/genome.fa' // You can specify a default genome file path here if you want

workflow {

    // Step to index the genome
    INDEX_GENOME(params.genome)
}

process INDEX_GENOME {
    container "quay.io/biocontainers/bwa:0.7.17--hed695b0_7"

    tag "$genome"

    input:
    path genome

    output:
    path "*.amb", emit: amb
    path "*.ann", emit: ann
    path "*.bwt", emit: bwt
    path "*.pac", emit: pac
    path "*.sa", emit: sa

    script:
    """
    bwa index $genome
    """
}
