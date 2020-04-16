##### --- helpers ------- #####
#' @export make_dropdown
#' @noRd 


make_dropdown <- function(drop_id, drop_label, drop_choices) {
  selectizeInput(inputId = drop_id,
                 label = drop_label,
                 choices = drop_choices)
}