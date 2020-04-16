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
      x <- colnames(dataset1)
    }
    
    if (input$vars == "dataset2") {
      x <- colnames(dataset2)
    }
    return(x)
  })
  
  #' last_clicked_button <- reactiveVal(NA)
  #' 
  #' observeEvent(input$makePlot1, {
  #'   last_clicked_button("p1")
  #' })
  #' 
  #' observeEvent(input$makePlot2, {
  #'   last_clicked_button("p2")
  #' })
  #' 
  #' #' @import ggplot2
  #' whattoplot <- reactive({
  #'   req(last_clicked_button())
  #'   if (last_clicked_button() == "p1") {
  #'     x <- ggplot(dataset1) +
  #'       aes(x = !!rlang::sym(input$chooseVar1), 
  #'           fill = !!rlang::sym(input$chooseFill1), 
  #'           color = !!rlang::sym(input$chooseFill1)) +
  #'     geom_histogram(position = "dodge", bins = 15, stat="count")
  #'   } 
  #'   
  #'   if (last_clicked_button() == "p2") { 
  #'     x <- ggplot(dataset2) +
  #'       aes(x = !!rlang::sym(input$chooseVar2), 
  #'           fill = !!rlang::sym(input$chooseFill2), 
  #'           color = !!rlang::sym(input$chooseFill2)) +
  #'       geom_histogram(position = "dodge", bins = 15, stat="count")
  #'   }
  #'   
  #'   return(x)
  #' })
  
  #output$headTable <- renderTable({ ds_head() })
  
  
  # call module
  from_module <- callModule(module = mod_select_module_server,
                            id = "modvars",
                            choices = dropdown_choices)
  
  # show what the module processed to the screen
  output$from_module <- renderText({
    vars_for_plot <- c("x_var", "y_var", "fill_var")
    # calling the module output as a reactive with ()
    paste0(vars_for_plot, " = ", from_module(), collapse = "; ")
  })
  
}
