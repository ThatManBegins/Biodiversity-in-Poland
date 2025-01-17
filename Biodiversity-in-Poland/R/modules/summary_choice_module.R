# summary_choice_module.R
summaryChoiceModuleUI = function(id) {
  ns = NS(id)
  radioButtons(
    ns("summary_choice"), 
    "Summarize Timeline By", 
    choices = list("Year" = "year", "Quarter" = "quarter"), 
    selected = "year"
  )
}


summaryChoiceModuleServer = function(id) {
  moduleServer(id, function(input, output, session) {
    ns = session$ns
    
    # Return the selected summary choice as a reactive value
    reactive(input$summary_choice)
  })
}
