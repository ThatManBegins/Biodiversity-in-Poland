# map_module.R
mapModuleUI = function(id) {
  ns = NS(id)
  leafletOutput(ns("map"))
}

mapModuleServer = function(id, data, selected_species, date_range) {
  moduleServer(id, function(input, output, session) {
    ns = session$ns
    
    output$map = renderLeaflet({
      filtered_data = data %>%
        filter(
          eventDate >= date_range()$from & eventDate <= date_range()$to
        ) 
      species_data = if (is.null(selected_species())) {
        filtered_data %>% filter(scientificName == NA)
      } else {
        # Filter data for selected species
        filtered_data %>% filter(scientificName == selected_species())%>%
          arrange(individualCount)
      }
      
      if (!is.null(selected_species())) {
        
        pal = colorNumeric ("YlOrRd", species_data$individualCount)
        
        
        leaflet(data = species_data) %>%
          # addTiles() %>%
           addProviderTiles(providers$CartoDB.Positron) %>%
          addCircleMarkers(lng = ~longitudeDecimal, lat = ~latitudeDecimal,radius = ~coordinateUncertaintyInMeters/500,
                           color = "#03F",
                           weight = 1,
                           opacity = 0.2,
                           fill = TRUE,
                           fillColor = "#03F",
                           fillOpacity = 0.1,
                           popup = ~paste(scientificName, ", Uncertinity:", coordinateUncertaintyInMeters))%>%
          addCircles(radius = 30, weight = 10, color = ~pal(individualCount), lng = ~longitudeDecimal, lat = ~latitudeDecimal,
                     fillColor = ~pal(individualCount), fillOpacity = 0.5, popup = ~paste(scientificName, ", Count:", individualCount) 
          )%>% 
          addLegend(position = "bottomright",
                    pal = pal, values = ~individualCount, labels = "Individual Counts"
          )
        
      } else {

        # Path to your image (local or online)
        image_url = "map meme.jpg"  # Replace with your image URL
        
        # Create the leaflet map with a popup containing the image
        leaflet() %>%
          # addTiles() %>%  # Optional, adds a base map layer
          addProviderTiles(providers$CartoDB.Positron) %>%
          addPopups(
            lng = 19, lat = 49,  # Coordinates where the popup will appear
            popup = paste0("<img src='", image_url, "' width='300px'>")
          ) %>%
          setView(lng = 19, lat = 52, zoom = 6)  # Center the map
        
        
      }
      
    })
  })
}


# mapModuleServer = function(id, data, selected_species, date_range) {
#   moduleServer(id, function(input, output, session) {
#     ns = session$ns
#     
#     output$map = renderLeaflet({
#       filtered_data = data %>%
#         filter(
#           between(observationDate, date_range()$from, date_range()$to)
#         )
#       
#       if (!is.null(selected_species())) {
#         filtered_data = filtered_data %>% filter(vernacularName == selected_species())
#       }
#       
#       leaflet(data = filtered_data) %>%
#         addTiles() %>%
#         addCircleMarkers(~longitude, ~latitude, popup = ~vernacularName)
#     })
#   })
# }
