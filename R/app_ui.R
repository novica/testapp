#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinydashboard
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here 
  dashboardPage(    
    dashboardHeader(title = "test app"),
    dashboardSidebar(
      sidebarMenu(id = "sidebar",
        menuItem("Dataset 1", tabName = "dataset1", icon = icon("chart-bar")),
        menuItem("Dataset 2", tabName = "dataset2", icon = icon("chart-area"))
      )
    ),
      
    dashboardBody(
      tabItems(
        tabItem(tabName = "dataset1",
                h2("Dataset Random Lab Values Info 2020"),
                fluidRow(
                  box(plotOutput("plot1")),
                  
                  box(
                    "Box content here", br(), "More box content",
                    sliderInput("slider", "Slider input:", 1, 100, 50),
                    textInput("text", "Text input:")
                  )
                ),
                fluidRow(
                  box(plotOutput("plot2")),
                  
                  box(
                    "Box content here", br(), "More box content",
                    sliderInput("slider", "Slider input:", 1, 100, 50),
                    textInput("text", "Text input:")
                  )
                )
        ),
        
        tabItem(tabName = "dataset2",
                h2("Dataset Patient Level Info 2020"),
                fluidRow(
                  box(plotOutput("plot3")),
                  
                  box(
                    "Box content here", br(), "More box content",
                    sliderInput("slider", "Slider input:", 1, 100, 50),
                    textInput("text", "Text input:")
                  )
                ),
                fluidRow(
                  box(plotOutput("plot4")),
                  
                  box(
                    "Box content here", br(), "More box content",
                    sliderInput("slider", "Slider input:", 1, 100, 50),
                    textInput("text", "Text input:")
                  )
                )
        )
      )
    )
  )
 )
}



#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
 
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'testapp'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

