# Generates a random DNA sequence of specified length and base probabilities
gene_dna <- function(length, base_probs = c(0.25, 0.25, 0.25, 0.25)){
  if( length %% 3 != 0 ){
    stop("The argument to the parameter 'l' has to be divisible by 3")
  }
  if( sum(base_probs) != 1 ){
    stop("The probabilities must add up to 1")
  }
  dna_vector <- sample(
    x = c("A", "T", "C", "G"),
    size = length,
    replace = TRUE,
    prob = base_probs)
  dna_string <- paste0(
    x = dna_vector,
    collapse = "")
  return(dna_string)
}

# Transcribes DNA to RNA by replacing "T" with "U"
transcribe_dna <- function(dna){
  rna <- gsub(
    pattern = "T",
    replacement = "U",
    x = dna)
  return(rna)
}

# Translates RNA sequence to protein sequence using codon table
translate_rna <- function(rna){
  if( is.null(rna) || rna == "" ){ return("") }
  l <- nchar(x = rna)
  firsts <- seq(
    from = 1,
    to = l,
    by = 3)
  lasts <- seq(
    from = 3,
    to = l,
    by = 3)
  codons <- substring(
    text = rna,
    first = firsts,
    last = lasts)
  codon_table <- c(
    "UUU" = "F", "UCU" = "S", "UAU" = "Y", "UGU" = "C",
    "UUC" = "F", "UCC" = "S", "UAC" = "Y", "UGC" = "C",
    "UUA" = "L", "UCA" = "S", "UAA" = "_", "UGA" = "_",
    "UUG" = "L", "UCG" = "S", "UAG" = "_", "UGG" = "W",
    "CUU" = "L", "CCU" = "P", "CAU" = "H", "CGU" = "R",
    "CUC" = "L", "CCC" = "P", "CAC" = "H", "CGC" = "R",
    "CUA" = "L", "CCA" = "P", "CAA" = "Q", "CGA" = "R",
    "CUG" = "L", "CCG" = "P", "CAG" = "Q", "CGG" = "R",
    "AUU" = "I", "ACU" = "T", "AAU" = "N", "AGU" = "S",
    "AUC" = "I", "ACC" = "T", "AAC" = "N", "AGC" = "S",
    "AUA" = "I", "ACA" = "T", "AAA" = "K", "AGA" = "R",
    "AUG" = "M", "ACG" = "T", "AAG" = "K", "AGG" = "R",
    "GUU" = "V", "GCU" = "A", "GAU" = "D", "GGU" = "G",
    "GUC" = "V", "GCC" = "A", "GAC" = "D", "GGC" = "G",
    "GUA" = "V", "GCA" = "A", "GAA" = "E", "GGA" = "G",
    "GUG" = "V", "GCG" = "A", "GAG" = "E", "GGG" = "G")
  protein <- paste0(
    x = codon_table[codons],
    collapse = "")
  return(protein)
}

# Simple base counts
base_freqs <- function(dna){
  if (is.null(dna) || dna == "" ){
    return( data.frame(dna_vec = factor(c("A", "C", "G", "T")),
                       Freq = c(0, 0, 0, 0)) ) }
  dna_vec <- strsplit(x = dna,
                      split = "")
  base_counts <- table(dna_vec)
  return( as.data.frame.table(base_counts) )
}

# Creates a bar plot of amino acid counts in a protein sequence
aa_count <- function(seq){
  unique_aa <- seq |>
    stringr::str_split(pattern = stringr::boundary("character"), simplify = TRUE) |>
    as.character() |>
    unique()
  
  counts <- sapply(unique_aa, function(amino_acid) stringr::str_count(string = seq, pattern =  amino_acid)) |>
    as.data.frame()
  
  colnames(counts) <- c("Counts")
  counts[["aa"]] <- rownames(counts)
  
  count_plot <- counts |>
    ggplot2::ggplot(ggplot2::aes(x = unique_aa, y = Counts, fill = aa)) +
    ggplot2::geom_col() +
    ggplot2::theme_bw() +
    ggplot2::theme(legend.position = "none")
  
  return(count_plot)
}