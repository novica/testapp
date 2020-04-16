#' select_module UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_select_module_ui <- function(id){
  ns <- NS(id)
 
  uiOutput(outputId = ns("chooseVar"))
   
}
    
#' select_module Server Function
#'
#' @noRd 
mod_select_module_server <- function(input,output, session,
                                       choices) {
  
  ns <- session$ns
  
  vars_for_plot <- c("x_var", "group_var", "fill_var")
  
  
  drop_widgets <- reactive({
    lapply(vars_for_plot, function(x)
      make_dropdown(
        drop_id = ns(x),
        drop_label = x,
        drop_choices = choices()
      ))
  })
  
  
  output$dropdowns <- renderUI({
    tagList(
      column(4, wellPanel(h4("Filter variables"), drop_widgets() )),
    )
  })
  
  selected_vars <- reactive({
    lapply(vars_for_plot, function(x) req(input[[x]]) )
    selected_values <- lapply(vars_for_plot, function(x) input[[x]] )
  })
  
  return(reactive(selected_vars()))
  
}
    
## To be copied in the UI
# mod_select_module_ui("select_module_ui_1")
    
## To be copied in the server
# callModule(mod_select_module_server, "select_module_ui_1")
#' select_module UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_select_module_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' select_module Server Function
#'
#' @noRd 
mod_select_module_server <- function(input, output, session){
  ns <- session$ns
 
}
    
## To be copied in the UI
# mod_select_module_ui("select_module_ui_1")
    
## To be copied in the server
# callModule(mod_select_module_server, "select_module_ui_1")
 
