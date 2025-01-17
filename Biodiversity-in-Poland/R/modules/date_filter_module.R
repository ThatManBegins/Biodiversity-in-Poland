# date_filter_module.R
dateFilterModuleUI = function(id) {
  ns = NS(id)
  tagList(
    dateRangeInput(
      ns("date_range"), 
      "Filter by Date Range", 
      start = "2010-01-01",  # Default start date: 3 year ago from today
      end = Sys.Date(),          # Default end date: today
      format = "yyyy-mm-dd"
    )
  )
}


dateFilterModuleServer = function(id) {
  moduleServer(id, function(input, output, session) {
    ns = session$ns
    
    # Return the selected date range as a reactive value
    reactive({
      list(from = input$date_range[1], to = input$date_range[2])
    })
  })
}
