---
editor_options: 
  markdown: 
    wrap: sentence
---

# Biodiversity-in-Poland

## Hosted version

## Overview

This Shiny app visualizes species observation data from Poland, allowing users to:

-   Search for species by their vernacular or scientific names.

-   View species observations on an interactive map.

-   Filter observations by date range.

-   Summarize species observation trends by year or quarter.

The app is modular, meaning each feature is encapsulated in separate modules for easier maintenance and future development.

## App Structure

The app is organized as follows:

Biodiversity-in-Poland/

├── R/

│ ├── modules/

│ │ ├── date_filter_module.R \# Module for the date range filter

│ │ ├── map_module.R \# Module for the map visualization

│ │ ├── search_module.R \# Module for species search functionality

│ │ ├── summary_choice_module.R \# Module for choosing summary granularity (year/quarter)

│ │ └── timeline_module.R \# Module for the timeline visualization

├── tests/

│ └── testthat/ \# Contains unit tests for app functionality

├── www/

│ ├── images/ \# Stores images used in the app

├── data/

│ └── prepared_data.RData \# Preprocessed dataset for use in the app

├── server.R \# Server logic of the Shiny app

├── ui.R \# User interface layout of the Shiny app

├── global.R \# Global settings and app-wide settings

## Getting Started

### Prerequisites

Before running the app, ensure that the following R packages are installed:

-   `shiny`

-   `leaflet`

-   `dplyr`

-   `plotly`

-   `shinydashboard`

-   `shinydashboardPlus`

-   `shinyWidgets`

-   `fontawesome`

-   `lubridate`

-   `RColorBrewer`

To install the required packages, you can run the following command in your R console:

`install.packages(c( "shiny", "shinydashboard", "shinydashboardPlus", "shinyWidgets", "fontawesome", "leaflet", "plotly", "dplyr", "lubridate", "RColorBrewer" ))`

## App Modules

The app uses Shiny modules to break down its functionality into manageable parts.
Each module is located in the `R/modules/` directory and is described below.

### 1. **Search Module (`search_module.R`)**

This module provides the search functionality for species.
Users can input the vernacular name or scientific name of a species, and the app will filter the results accordingly.
Once a species is selected, the app displays its observations on the map and timeline.

### 2. **Map Module (`map_module.R`)**

The map module visualizes species observation locations on an interactive map.
It uses the `leaflet` package for rendering the map and allows users to zoom and pan across Poland to explore species locations.

### 3. **Timeline Module (`timeline_module.R`)**

This module generates a timeline of species observations.
Users can filter observations based on the selected species and date range.
The timeline can be summarized by year or quarter, depending on the user's choice.

### 4. **Date Filter Module (`date_filter_module.R`)**

This module allows users to filter species observations by a specific date range.
The date range is applied both to the map and the timeline, ensuring that only observations within the selected range are displayed.

### 5. **Summary Choice Module (`summary_choice_module.R`)**

This module provides a choice for users to summarize the timeline graph by either year or quarter.
The app will aggregate the observations accordingly, displaying the total count for each period.

## Data

The app uses a preprocessed dataset that contains species observation data.
The dataset is stored in the `data/` directory as `prepared_data.RData`.

To load the dataset into R, the following code is used in the app's `global.R`:

`load("data/prepared_data.RData")`

Make sure that the dataset contains the following fields:

-   `vernacularName`: The common name of the species.

-   `scientificName`: The scientific name of the species.

-   `latitudeDecimal`: Latitude coordinate of the observation.

-   `longitudeDecimal`: Longitude coordinate of the observation.

-   `eventDate`: The date the observation was made.

-   `country`: The country where the observation was recorded (filtered to Poland in the app).

## Customizing the App

To extend or modify the app, you can add or edit the following:

1.  **Adding New Features**: You can create new modules and add them to the app.
    Ensure that each module is self-contained with its own UI and server logic.

2.  **Changing the Data**: If you have a different dataset, modify the preprocessing steps in `global.R` and adjust the dataset fields accordingly.

3.  **Styling the App**: You can customize the look and feel of the app by modifying the UI components in `ui.R`.

## Contributing

This app is private.
Thank you
