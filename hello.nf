#!/usr/bin/env nextflow
/*
 * Parâmetros do Pipeline
 */
params.greeting = "Olá mundo!"
/*
 * Use echo para exibir 'Hello World!'
 */
process sayHello {

    publishDir 'results', mode: 'copy'

    input:
        val greeting

    output:
        path "${greeting}-output.txt"

    script:
    """
    echo '$greeting' > '$greeting-output.txt'
    """
}

/*
 * Use um utilitário de substituição de texto para converter a saudação em maiúsculas
 */
process convertToUpper {

    publishDir 'results', mode: 'copy'

    input:
        path input_file

    output:
        path "UPPER-${input_file}"

    script:
    """
    cat '$input_file' | tr '[a-z]' '[A-Z]' > UPPER-${input_file}
    """
}
workflow {

    greeting_ch = Channel.of('hello','bonjour',)
    // emita uma saudação
    sayHello(greeting_ch)
    convertToUpper(sayHello.out)
}
    
