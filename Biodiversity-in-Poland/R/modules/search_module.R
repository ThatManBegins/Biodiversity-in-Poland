# search_module.R
searchModuleUI = function(id) {
  ns = NS(id)
  tagList(
    textInput(ns("species_search"), "Search for species", placeholder = "Enter vernacular or scientific name"),
    uiOutput(ns("species_dropdown"))
  )
}

searchModuleServer = function(id, data) {
  moduleServer(id, function(input, output, session) {
    ns = session$ns
    
    # Filter species based on search input
    filtered_species = reactive({
      req(input$species_search)
      data %>%
        filter(grepl(input$species_search, vernacularName, ignore.case = TRUE) |
                 grepl(input$species_search, scientificName, ignore.case = TRUE)) %>%
        distinct(vernacularName, scientificName)
    })
    
    # Render species dropdown
    output$species_dropdown = renderUI({
      selectInput(ns("selected_species"), "Select a species",
                  choices = filtered_species()$scientificName,
                  selected = NULL)
    })
    
    # Return the selected species
    reactive(input$selected_species)
  })
}
