process FASTQC {
  input:
    path reads
  output:
    path "*.zip"
    path "*.html"

  script:
    """
    fastqc $reads
    """
}
