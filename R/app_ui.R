#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here 
    fluidPage(
      
      # Application title
      titlePanel("Test app for interview"),
      
      # Sidebar with a slider input for number of bins 
      sidebarLayout(
        sidebarPanel(
          selectInput(inputId =  "vars", label =  "Select Dataset:",
                      choices =  c("Lab Values" = "dataset1",
                        "Patient Info" = "dataset2"),
                      selected = FALSE,
                      multiple = FALSE,
                      selectize = FALSE, size = 2 ), 
          
          # call the module ui
          mod_select_module_ui("modvars"),
          
          # render what the module processed 
          textOutput("from_module")
        
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
          #tableOutput(outputId = "headTable"),
          plotOutput(outputId = "plot")
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

