################################################################################
#
#'
#' Initialise built-in Shiny application
#'
#' @return NULL
#'
#' @examples
#' if(interactive()) run_zscorer()
#'
#' @export
#
run_zscorer <- function() {
  appDir <- system.file("zscorer", package = "zscorer")

  if (appDir == "") {
    stop("Could not find Shiny directory. Try re-installing `zscorer`.",
         call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}
