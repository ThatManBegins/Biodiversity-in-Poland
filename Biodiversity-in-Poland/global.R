# Loading Libraries

library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(shinyWidgets)
library(fontawesome)
library(leaflet)
library(plotly)
library(dplyr)
library(lubridate)
library(RColorBrewer)


# Loading the data --------------------------------------------------------

load("./data/prepared_data.RData")

# Source modules --------------------------------------------------------
source("./R/modules/search_module.R")
source("./R/modules/date_filter_module.R")
source("./R/modules/summary_choice_module.R")
source("./R/modules/map_module.R")
source("./R/modules/timeline_module.R")


