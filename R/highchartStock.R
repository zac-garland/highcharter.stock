#' Highcharts Stock Chart
#'
#' A simple wrapper of the highcharts stock gui
#'
#' @import htmlwidgets
#'
#' @export
highchartStock <- function(ticker = "AAPL",..., width = NULL, height = NULL, elementId = NULL) {

  # forward options using x
  x = list(
    data = tidyquant::tq_get(ticker,...) %>% mutate(date = as.numeric(as.POSIXct(date))*1000) %>%
      jsonlite::toJSON()
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'highchartStock',
    x,
    width = width,
    height = height,
    package = 'highchart.stock',
    elementId = elementId
  )
}

#' Shiny bindings for highchartStock
#'
#' Output and render functions for using highchartStock within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a highchartStock
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name highchartStock-shiny
#'
#' @export
highchartStockOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'highchartStock', width, height, package = 'highchart.stock')
}

#' @rdname highchartStock-shiny
#' @export
renderhighchartStock <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, highchartStockOutput, env, quoted = TRUE)
}
