#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#



server = function(input, output, session) {
  selected_species = searchModuleServer("search", data = Occurence_table_prep)
  date_range = dateFilterModuleServer("date_filter")
  summary_choice = summaryChoiceModuleServer("summary_choice")
  
  mapModuleServer("map", data = Occurence_table_prep, selected_species = selected_species, date_range = date_range)
  timelineModuleServer("timeline", data = Occurence_table_prep, selected_species = selected_species, date_range = date_range, summary_choice = summary_choice)
}