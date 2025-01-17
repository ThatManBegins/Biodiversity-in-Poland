# # timeline_module.R


timelineModuleUI = function(id) {
  ns = NS(id)
  plotlyOutput(ns("timeline"))
  
}



timelineModuleServer = function(id, data, selected_species, date_range, summary_choice) {
  moduleServer(id, function(input, output, session) {
    ns = session$ns
    
    output$timeline = renderPlotly({
      filtered_data = data %>%
        filter(eventDate >= date_range()$from & eventDate <= date_range()$to) 
      
      if (!is.null(selected_species())) {
        filtered_data = filtered_data %>% filter(scientificName == selected_species())
        
      } else {
        filtered_data = filtered_data %>% filter(scientificName == NA)
        
      }
      
      # Summarize by year or quarter
      timeline_data = filtered_data %>%
        mutate(
          period =  floor_date(ymd(eventDate), unit = summary_choice())
               ) %>%
        group_by(period) %>%
        summarize(count = sum(individualCount)) %>%
        ungroup()
      if (!is.null(selected_species())) {
        plot_ly(timeline_data, x = ~period, y = ~count, type = 'scatter', mode = 'lines+markers')
        
      } else {
        plot_ly() %>%
          layout(
            images = list(
              list(
                source = "meme for the graph.jpg",         # Path or URL of the image
                x = 0.5,                     # x-coordinate (centered on x-axis)
                y = 0.5,                     # y-coordinate (centered on y-axis)
                xref = "paper",              # Reference to the plot paper coordinates (0-1)
                yref = "paper",              # Reference to the plot paper coordinates (0-1)
                sizex = 1,                   # Width of the image
                sizey = 1,                   # Height of the image
                xanchor = "center",          # Anchor position on the x-axis
                yanchor = "middle",          # Anchor position on the y-axis
                layer = "below"              # Place the image below plot elements
              )
            ),
            title = "Meme Plotly Graph",
            xaxis = list(visible = F),  # Hide x-axis
            yaxis = list(visible = F)   # Hide y-axis
          )
      }
    })
    
  })
}

