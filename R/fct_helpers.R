##### --- helpers ------- #####
#' Helper function for preparing dropdown menus
#' @name make_dropdown
#' @param drop_id,drop_label,drop_choices selectize input elements
#' 
#' @export


make_dropdown <- function(drop_id, drop_label, drop_choices) {
  selectizeInput(inputId = drop_id,
                 label = drop_label,
                 choices = drop_choices)
}