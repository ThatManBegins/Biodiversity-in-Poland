ui = dashboardPage(

# header ------------------------------------------------------------------

  
  header = dashboardHeader(
    title = NULL,
    titleWidth = 0,
    disable = F,
    .list = NULL,
  leftUi = tagList(

    
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
        title = "Filters",
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
        id = NULL
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
  skin = "midnight",
  # "blue-light", "black", "black-light", "purple", "purple-light",
  #          "green", "green-light", "red", "red-light", "yellow", "yellow-light", "midnight",
  options = NULL,
  scrollToTop = T
)