
library("bslib")
# Define the User Interface (Frontend)
ui <- page_fluid(
  # App title section
  layout_columns(
    col_widths = 12,
    card(
      titlePanel("Virtual Central Dogma"),
      style = "background-color: #f0f0f0; padding: 15px;"
    )),
  
  # About section with app description
  layout_columns(
    col_widths = 12,
    card(
      titlePanel("About"),
      helpText("This app demonstrates the central dogma of molecular biology by simulating DNA transcription and translation. Users can generate a custom DNA sequence, transcribe it to RNA, and translate it into a protein sequence. Explore base composition, visualize amino acid frequencies, and gain insights into genetic information processing.")
    )),
  
  # Input section for generating DNA
  layout_columns(
    col_widths = 12,
    card(
      card_header("Virtual Gene Generator"),
      # Slider for number of bases
      sliderInput(inputId = "n_bases",
                  label = "Number of bases:",
                  min = 1,
                  max = 60,
                  value = 30,
                  width = "100%"),
      
      # Numeric inputs for base probabilities
      layout_columns(
        col_widths = c(3, 3, 3, 3),
        numericInput(inputId = "prob_A",
                     label = "Probability of A",
                     value = 0.25,
                     min = 0,
                     max = 1,
                     step = 0.05),
        numericInput(inputId = "prob_T",
                     label = "Probability of T",
                     value = 0.25,
                     min = 0,
                     max = 1,
                     step = 0.05),
        numericInput(inputId = "prob_C",
                     label = "Probability of C",
                     value = 0.25,
                     min = 0,
                     max = 1,
                     step = 0.05),
        numericInput(inputId = "prob_G",
                     label = "Probability of G",
                     value = 0.25,
                     min = 0,
                     max = 1,
                     step = 0.05)
      ))),
  
  # Output section displaying DNA, RNA, Protein, and analysis results
  layout_columns(
    col_widths = 12,
    card(
      card_header("Virtual Central Dogma"),
      mainPanel(
        # DNA Output
        tags$div(
          tags$h4("DNA"),
          verbatimTextOutput(outputId = "dna")
        ),
        
        # Base Count Table Output
        tags$div(
          tags$h4("Base Count"),
          tableOutput(outputId = "baseCount")
        ),
        
        # RNA Output
        tags$div(
          tags$h4("RNA"),
          verbatimTextOutput(outputId = "rna")
        ),
        
        # Protein Output
        tags$div(
          tags$h4("Protein"),
          verbatimTextOutput(outputId = "protein")
        ),
        
        # Amino Acid Frequency Plot
        tags$div(
          tags$h4("Amino Acid Frequency Plot"),
          plotOutput(outputId = "aaPlot")
        )
      )
    ))
)