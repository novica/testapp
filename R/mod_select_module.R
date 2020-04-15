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
mod_select_module_server <- function(input, output, session,
                                     .label, .choices) {
  ns <- session$ns
  
  choose_var <- function(inputID, .label, .choices = NULL){
    selectInput(inputId = session$ns("chooseVar"),  
                label = .label,
                choices = .choices)}
 
  output$chooseVar <- renderUI({choose_var(inputID, .label, .choices)})
  
}
    
## To be copied in the UI
# mod_select_module_ui("select_module_ui_1")
    
## To be copied in the server
# callModule(mod_select_module_server, "select_module_ui_1")
 
