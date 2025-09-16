process WORDCOUNT {
  input:
    path input_file
  output:
    path "counts.txt"

  script:
    """
    wc -w $input_file > counts.txt
    """
}
