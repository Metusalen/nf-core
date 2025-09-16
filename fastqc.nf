#!/usr/bin/env nextflow

/*
 * Pipeline de exemplo Nextflow DSL2: FASTQC
 * 
 * Este pipeline executa FastQC em arquivos de entrada FASTQ.
 * Ele gera arquivos de saída .zip e .html na pasta de trabalho.
 */

nextflow.enable.dsl=2   // Ativa DSL2

// ======================
// Processo: FASTQC
// ======================
process FASTQC {
  
  // Recebe como entrada arquivos FASTQ
  input:
    path reads

  // Define os arquivos que serão gerados como saída
  output:
    path "*.zip"
    path "*.html"

  // Script que será executado
  script:
    """
    fastqc $reads
    """
}

// ======================
// Workflow principal
// ======================
workflow {

  // Para testar, cria um arquivo FASTQ dummy
  channel_of_reads = Channel.fromPath("test_reads.fastq")

  // Executa o processo FASTQC com o arquivo dummy
  FASTQC(channel_of_reads)
}

/*
 * Como testar:
 * 1. Crie um arquivo FASTQ de teste chamado test_reads.fastq:
 *    echo -e "@SEQ_ID\nGATTTGGGGTTT\n+\nIIIIIIIIIIII" > test_reads.fastq
 * 2. Execute:
 *    nextflow run fastqc_test.nf
 * 3. Saída esperada:
 *    - test_reads_fastqc.html
 *    - test_reads_fastqc.zip
 */
