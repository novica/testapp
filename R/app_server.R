#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # List the first level callModules here

  ds_head <- reactive({
    validate(need(!is.null(input$dataset), 
                  "Hi there, please select dataset."))
    if (input$dataset == "dataset1") {
      x <- head(dataset1)
    } else {
      x <- head(dataset2)
    }
    
    return(x)    
    })
  
  choose_vars <- reactive({
    validate(need(!is.null(input$dataset), "Waiting for dataset..."))
    
    if (input$dataset == "dataset1") {
    x <- tagList( selectInput(inputId =  "chooseVar1", 
                label = "Variables", choices =  c("AVAL", "BMRKR1")),
    
    selectInput(inputId =  "chooseFill1", 
                label =  "Variables", choices = c("AVISIT", "LBTESTCD")),
    
    actionButton(inputId = "makePlot2", label = "Plot")
      )
    } else {
      x <- tagList(selectInput(inputId =  "chooseVar2", 
                       label = "Variables", choices =  c("AGE", "RACE")),
      
      selectInput(inputId =  "chooseFill2", 
                  label =  "Variables", choices = c("SEX", "ACTARM")),
      
      actionButton(inputId = "makePlot2", label = "Plot")
      )
    }
    
    return(x)
  })
  
  output$headTable <- renderTable({ ds_head() })
  
  output$makePlot <- renderUI({ choose_vars() })
    
  
  
}
