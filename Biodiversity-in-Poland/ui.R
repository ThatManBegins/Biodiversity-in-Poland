ui = dashboardPage(

# header ------------------------------------------------------------------

  
  header = dashboardHeader(
    title = NULL,
    titleWidth = 0,
    disable = F,
    .list = NULL,
  leftUi = tagList(
    span( style = "font-size: 30px; 
          color: white;
          font-family:Playfair Display;", 
          "Biodiversity in Poland")
    
  ),
  controlbarIcon = shiny::icon("gears"),
  fixed = F
),

# sidebar -----------------------------------------------------------------


  sidebar = dashboardSidebar(
    disable = T,
    minified = F,
    width = 0
  ),

# body --------------------------------------------------------------------


  body = dashboardBody(
    fluidRow(
      box(
        title = span(
            style = "font-size: 20px;
            color: black;
            font-family:Playfair Display;",
            "Filters"),         
        footer = NULL,
        status = NULL,
        solidHeader = FALSE,
        background = NULL,
        width = 12,
        height = NULL,
        collapsible = TRUE,
        collapsed = FALSE,
        closable = FALSE,
        icon = NULL,
        gradient = FALSE,
        boxToolSize = "sm",
        headerBorder = T,
        label = NULL,
        dropdownMenu = NULL,
        sidebar = NULL,
        id = NULL,
        
        # search module
        searchModuleUI("search"),
        
        # Date Module
        dateFilterModuleUI("date_filter"),
        
        # Plotting frequency
        summaryChoiceModuleUI("summary_choice")
        
        

      )
    ),
    fluidRow(
      box(
        title = span(
          style = "font-size: 20px;
            color: black;
            font-family:Playfair Display;",
          "Map"),         
        footer = NULL,
        status = NULL,
        solidHeader = FALSE,
        background = NULL,
        width = 12,
        height = 500,
        collapsible = FALSE,
        collapsed = FALSE,
        closable = FALSE,
        icon = NULL,
        gradient = FALSE,
        boxToolSize = "sm",
        headerBorder = TRUE,
        label = NULL,
        dropdownMenu = NULL,
        sidebar = NULL,
        id = NULL,
        
        mapModuleUI("map")
      )
      
    ),
    fluidRow(
      box(
        title = span(
          style = "font-size: 20px;
            color: black;
            font-family:Playfair Display;",
          "Timeline"),         
        footer = NULL,
        status = NULL,
        solidHeader = FALSE,
        background = NULL,
        width = 12,
        height = NULL,
        collapsible = FALSE,
        collapsed = FALSE,
        closable = FALSE,
        icon = NULL,
        gradient = FALSE,
        boxToolSize = "sm",
        headerBorder = TRUE,
        label = NULL,
        dropdownMenu = NULL,
        sidebar = NULL,
        id = NULL,
        
        timelineModuleUI("timeline")
      )
      
    )
    ),

# controlbar --------------------------------------------------------------


  controlbar = NULL,

# footer ------------------------------------------------------------------


  footer = dashboardFooter(
    left = "By Harshan Turkay",
    right = "Canada, 2025"
  ),
  title = NULL,
  # skin = "midnight",
  skin = "green-light",
  # "blue-light", "black", "black-light", "purple", "purple-light",
  #          "green", "green-light", "red", "red-light", "yellow", "yellow-light", "midnight",
  options = NULL,
  scrollToTop = T
)