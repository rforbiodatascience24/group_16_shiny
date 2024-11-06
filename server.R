# Define the Server (Backend)
server <- function(input, output) {
  
  # Reactive DNA sequence generation
  dna_sequence <- reactive({
    gene_dna(length = input$n_bases, base_probs = c(input$prob_A, input$prob_T, input$prob_G, input$prob_C))
  })
  
  # Reactive base counts for DNA sequence
  n_counts <- reactive({
    base_freqs(dna_sequence())
  })
  
  # Reactive RNA transcription from DNA
  rna_sequence <- reactive({
    transcribe_dna(dna_sequence())
  })
  
  # Reactive protein translation from RNA
  prot_sequence <- reactive({
    translate_rna(rna_sequence())
  })
  
  # Reactive amino acid frequency plot from protein
  plot_aa_freq <- reactive({
    aa_count(prot_sequence())
  })
  
  # Outputs for displaying DNA, base counts, RNA, protein, and amino acid plot
  output$dna <- renderText({
    dna_sequence()
    })
  
  output$baseCount <- renderTable({
   n_counts() 
  })
  
  output$rna <- renderText({
    rna_sequence()
  })
  
  output$protein <- renderText({
    prot_sequence()
  })
  
  output$aaPlot <- renderPlot({
   plot_aa_freq()
  })
}

