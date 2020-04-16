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
      g <- colnames(dataset1)[c(5,10)]
      f <- g # probably redundant, but for clarity
      var_list <- list("x_var" = x, "group_var" = g, "fill_var" = f)
    }
    
    if (input$vars == "dataset2") {
      x <- colnames(dataset1)[3]
      g <- colnames(dataset1)[c(4,5)]
      f <- g # probably redundant, but for clarity
      var_list <- list("x_var" = x, "group_var" = g, "fill_var" = f)
    }
    return(var_list)
  })
  
  
  #' #' @import ggplot2
  whattoplot <- reactive({
    req(observeEvent(input$plotButton))
      plot <- ggplot(!!rlang::sym(input$vars)) +
        aes(x = !!rlang::sym(from_module()[1]),
            fill = !!rlang::sym(from_module()[2]),
            color = !!rlang::sym(from_module()[3]) +
      geom_histogram(position = "dodge", bins = 15, stat = "count"))
    
    return(plot)
  })
  
  # call module
  from_module <- callModule(mod_select_module_server, "select_module_ui_1",
                            choices = dropdown_choices)
  
  #show what the module processed to the screen
  # output$from_module <- renderText({
  #  vars_for_plot <- c("x_var", "y_var", "fill_var")
  #  # calling the module output as a reactive with ()
  #  paste0(vars_for_plot, " = ", from_module(), collapse = "; ")
  # })
  
  output$plot <- renderPlot({ plot() })
  
}
