#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
#' 


app_server <- function( input, output, session ) {
  # List the first level callModules here
  
  dropdown_choices <- reactive({
    if (input$vars == "dataset1") {
      x <- colnames(dataset1)[3]
      y <- colnames(dataset1)[8]
      c <- y # probably redundant, but for clarity
      var_list <- list("first_var" = x, "second_var" = y, "third_var" = c)
    }
    
    if (input$vars == "dataset2") {
      x <- colnames(dataset2)[3]
      f <- colnames(dataset2)[c(4,5)]
      c <- f # probably redundant, but for clarity
      var_list <- list("first_var" = x, "first_var" = f, "third_var" = c)
    }
    return(var_list)
  })
  
  #' @import ggplot2
  what_to_plot <- eventReactive(input$plotButton, {
    
    first_var <- sym(from_module()[[1]])
    second_var <- sym(from_module()[[2]])
    third_var <- sym(from_module()[[3]])
    
    
    if (input$vars == "dataset1") {
    plt <- ggplot(dataset1) +
      aes( x = !!first_var, y = !!second_var, color = !!third_var ) +
      geom_point()
    } else plt <- ggplot(dataset2) +
      aes( x = !!first_var, fill = !!second_var, color = !!third_var) +
      geom_histogram(position = "dodge", bins = 15) +
      facet_grid(rows = third_var) +
      theme(legend.position = "none")
    
    return(plt)
  })

# call module
from_module <- callModule(module = mod_select_module_server, 
                          id = "select_module_ui_1",
                          choices = dropdown_choices)


output$plot <- renderPlot({ what_to_plot() })
}
