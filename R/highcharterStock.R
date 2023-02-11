#' Highcharts Stock Chart
#'
#' A simple wrapper of the highcharts stock gui
#'
#' @import htmlwidgets
#'
#' @export
highcharterStock <- function(data = jsonlite::fromJSON("https://demo-live-data.highcharts.com/aapl-c.json"), width = NULL, height = NULL, elementId = NULL) {

  # forward options using x
  x = list(
    data = data
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'highcharterStock',
    x,
    width = width,
    height = height,
    package = 'highcharter.stock',
    elementId = elementId
  )
}

#' Shiny bindings for highcharterStock
#'
#' Output and render functions for using highcharterStock within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a highcharterStock
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name highcharterStock-shiny
#'
#' @export
highcharterStockOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'highcharterStock', width, height, package = 'highcharter.stock')
}

#' @rdname highcharterStock-shiny
#' @export
renderHighcharterStock <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, highcharterStockOutput, env, quoted = TRUE)
}
