#!/usr/bin/env nextflow

/*
 * Pipeline de exemplo Nextflow DSL2: DOWNLOAD + COUNT
 * 
 * Explicação passo a passo:
 * 
 * 1. Ativa DSL2 para modularidade e workflows modernos.
 * 2. Define processos independentes (DOWNLOAD e COUNT).
 * 3. Conecta os processos via workflow, garantindo a ordem de execução.
 */

nextflow.enable.dsl=2   // Ativa o Nextflow DSL2

// ======================
// Processo 1: DOWNLOAD
// ======================
process DOWNLOAD {
  
  // Define o arquivo que será gerado como saída
  output:
    path "data.txt"

  // Script que será executado: cria um arquivo simples de teste
  script:
    """
    echo "nf-core test data" > data.txt
    """
}

// ======================
// Processo 2: COUNT
// ======================
process COUNT {
  
  // Recebe como entrada o arquivo produzido pelo DOWNLOAD
  input:
    path x

  // Define o arquivo que será gerado como saída
  output:
    path "lines.txt"

  // Script que será executado: conta as linhas do arquivo de entrada
  script:
    """
    wc -l $x > lines.txt
    """
}

// ======================
// Workflow principal
// ======================
workflow {
  
  // Executa o DOWNLOAD e guarda a saída em um canal chamado data_ch
  data_ch = DOWNLOAD()
  
  // Executa o COUNT, consumindo a saída de DOWNLOAD
  COUNT(data_ch)
}

/*
 * Resultado esperado:
 * - data.txt: contém a linha "nf-core test data"
 * - lines.txt: contém "1 data.txt" (número de linhas do arquivo)
 */
