HTMLWidgets.widget({
  name: "highchartStock",

  type: "output",

  factory: function (el, width, height) {
    // TODO: define shared variables for this instance

    return {
      renderValue: function (x) {
        // TODO: code to render the widget, e.g.
        //el.innerText = x.message;
        // split the data set into ohlc and volume

        var data = x.data,
          ohlc = [],
          volume = [],
          dataLength = data.length,
          symbolName = x.data[0]["symbol"],
          i = 0;

        for (i; i < dataLength; i += 1) {
          ohlc.push([
            data[i]["date"], // the date
            data[i]["open"], // open
            data[i]["high"], // high
            data[i]["low"], // low
            data[i]["close"] // close
          ]);

          volume.push([
            data[i]["date"], // the date
            data[i]["volume"] // the volume
          ]);
        }

        Highcharts.stockChart(el.id, {
          title: {
            text: symbolName
          },
          yAxis: [
            {
              labels: {
                align: "left"
              },
              height: "80%",
              resize: {
                enabled: true
              }
            },
            {
              labels: {
                align: "left"
              },
              top: "80%",
              height: "20%",
              offset: 0
            }
          ],
          tooltip: {
            shape: "square",
            headerShape: "callout",
            borderWidth: 0,
            shadow: false,
            positioner: function (width, height, point) {
              var chart = this.chart,
                position;

              if (point.isHeader) {
                position = {
                  x: Math.max(
                    // Left side limit
                    chart.plotLeft,
                    Math.min(
                      point.plotX + chart.plotLeft - width / 2,
                      // Right side limit
                      chart.chartWidth - width - chart.marginRight
                    )
                  ),
                  y: point.plotY
                };
              } else {
                position = {
                  x: point.series.chart.plotLeft,
                  y: point.series.yAxis.top - chart.plotTop
                };
              }

              return position;
            }
          },
          series: [
            {
              type: "candlestick",
              id: "stock-ohlc",
              name: symbolName + "Stock Price",
              data: ohlc
            },
            {
              type: "column",
              id: "stock-volume",
              name: symbolName + "Volume",
              data: volume,
              yAxis: 1
            }
          ],
          responsive: {
            rules: [
              {
                condition: {
                  maxWidth: 800
                },
                chartOptions: {
                  rangeSelector: {
                    inputEnabled: false
                  }
                }
              }
            ]
          }
        });
      },

      resize: function (width, height) {
        // TODO: code to re-render the widget with a new size
      }
    };
  }
});
