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
  
  # choose_vars <- reactive({
  #   validate(need(!is.null(input$dataset), "Waiting for dataset..."))
  #   
  #   if (input$dataset == "dataset1") {
  #     x <- tagList( selectInput(inputId =  "chooseVar1", 
  #                               label = "Variables", choices =  c("AVAL", "BMRKR1")),
  #                   
  #                   selectInput(inputId =  "chooseFill1", 
  #                               label =  "Variables", choices = c("AVISIT", "LBTESTCD")),
  #                   
  #                   actionButton(inputId = "makePlot1", label = "Plot")
  #     )
  #   } else {
  #     x <- tagList(selectInput(inputId =  "chooseVar2", 
  #                              label = "Variables", choices =  c("AGE", "RACE")),
  #                  
  #                  selectInput(inputId =  "chooseFill2", 
  #                              label =  "Variables", choices = c("SEX", "ACTARM")),
  #                  
  #                  actionButton(inputId = "makePlot2", label = "Plot")
  #     )
  #   }
  #   
  #   return(x)
  # })
  
  last_clicked_button <- reactiveVal(NA)
  
  observeEvent(input$makePlot1, {
    last_clicked_button("p1")
  })
  
  observeEvent(input$makePlot2, {
    last_clicked_button("p2")
  })
  
  #' @import ggplot2
  whattoplot <- reactive({
    req(last_clicked_button())
    if (last_clicked_button() == "p1") {
      x <- ggplot(dataset1) +
        aes(x = !!rlang::sym(input$chooseVar1), 
            fill = !!rlang::sym(input$chooseFill1), 
            color = !!rlang::sym(input$chooseFill1)) +
      geom_histogram(position = "dodge", bins = 15, stat="count")
    } 
    
    if (last_clicked_button() == "p2") { 
      x <- ggplot(dataset2) +
        aes(x = !!rlang::sym(input$chooseVar2), 
            fill = !!rlang::sym(input$chooseFill2), 
            color = !!rlang::sym(input$chooseFill2)) +
        geom_histogram(position = "dodge", bins = 15, stat="count")
    }
    
    return(x)
  })
  
  output$headTable <- renderTable({ ds_head() })
  
  #output$makePlot <- renderUI({ choose_vars() })
  callModule(
    mod_select_module_server, "select_module_ui_1", 
             .label = "Variables", .choices =  c("AVAL", "BMRKR1"),
    mod_select_module_server, "select_module_ui_2", 
              .label =  "Fill", choices = c("AVISIT", "LBTESTCD"),
    mod_select_module_server, "select_module_ui_3", 
              .label = "Variables", .choices =  c("AGE", "RACE"),
    mod_select_module_server, "select_module_ui_4", 
              .label = "Fill", .choices =  c("SEX", "ACTARM")
    )
  
  output$plot <- renderPlot({
    req(whattoplot())
  })
  
}
