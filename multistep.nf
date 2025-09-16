process DOWNLOAD {
  output:
    path "data.txt"

  script:
    """
    echo "nf-core test data" > data.txt
    """
}

process COUNT {
  input:
    path x from DOWNLOAD.out
  output:
    path "lines.txt"

  script:
    """
    wc -l $x > lines.txt
    """
}
