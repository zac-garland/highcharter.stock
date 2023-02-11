HTMLWidgets.widget({
  name: "highcharterStock",

  type: "output",

  factory: function (el, width, height) {
    // TODO: define shared variables for this instance

    return {
      renderValue: function (x) {
        // TODO: code to render the widget, e.g.
        //el.innerText = x.message;
        Highcharts.stockChart(el.id, {
          rangeSelector: {
            selected: 1
          },

          title: {
            text: "AAPL Stock Price"
          },

          series: [
            {
              name: "AAPL",
              data: x.data,
              tooltip: {
                valueDecimals: 2
              }
            }
          ]
        });
      },

      resize: function (width, height) {
        // TODO: code to re-render the widget with a new size
      }
    };
  }
});
