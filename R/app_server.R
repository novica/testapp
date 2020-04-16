#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # List the first level callModules here
  
  dropdown_choices <- reactive({
    if (input$vars == "dataset1") {
      x <- colnames(dataset1)[c(3,8)]
      f <- colnames(dataset1)[c(5,10)]
      c <- f # probably redundant, but for clarity
      var_list <- list("x_var" = x, "fill_var" = f, "color_var" = c)
    }
    
    if (input$vars == "dataset2") {
      x <- colnames(dataset2)[3]
      f <- colnames(dataset2)[c(4,5)]
      c <- f # probably redundant, but for clarity
      var_list <- list("x_var" = x, "fill_var" = f, "color_var" = c)
    }
    return(var_list)
  })
  
  #' @import ggplot2
  what_to_plot <- eventReactive(input$plotButton, {
    
    x_var <- rlang::sym(from_module()[[1]])
    g_var <- rlang::sym(from_module()[[2]])
    f_var <- rlang::sym(from_module()[[3]])
    
    
    if (input$vars == "dataset1") {
    plt <- ggplot(dataset1) +
      aes( x = !!x_var, fill = !!g_var, color = !!f_var) +
      geom_histogram(position = "dodge", bins = 15)
    } else plt <- ggplot(dataset2) +
      aes( x = !!x_var, fill = !!g_var, color = !!f_var) +
      geom_histogram(position = "dodge", bins = 15)
    
    return(plt)
  })

# call module
from_module <- callModule(module = mod_select_module_server, 
                          id = "select_module_ui_1",
                          choices = dropdown_choices)


output$plot <- renderPlot({ what_to_plot() })
}
