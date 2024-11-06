# Define the Server (Backend)
server <- function(input, output) {
  
  dna_sequence <- reactive({
    gene_dna(length = input$n_bases, base_probs = c(input$prob_A, input$prob_T, input$prob_G, input$prob_C))
  })
  
  rna_sequence <- reactive({
    transcribe_dna(dna_sequence())
  })
  
  prot_sequence <- reactive({
    translate_rna(rna_sequence())
  })
  
  plot_aa_freq <- reactive({
    aa_count(prot_sequence())
  })
  
  
  output$dna <- renderText({
    dna_sequence()
    })
  
  output$rna <- renderText({
    rna_sequence()
  })
  
  output$protein <- renderText({
    prot_sequence()
  })
  
  #output$aaPlot <- renderPlot({
   # plot_aa_freq()
    #})
}

