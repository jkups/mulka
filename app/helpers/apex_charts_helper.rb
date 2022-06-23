# frozen_string_literal :true

module ApexChartsHelper
  PRIMARY_CHART_COLOR = "#BA5B99"
  SECONDARY_CHART_COLOR = "#9CA3AF"
  NO_DATA = "There's no data to plot."
  RADIAL_CHART_HEIGHT = 350
  CHART_HEIGHT = 319
  MARKER_SIZE = 5

  def area_chart_options
    {
      height: CHART_HEIGHT,
      data_labels: false,
      markers: {size: MARKER_SIZE},
      yaxis: {show: false},
      colors: PRIMARY_CHART_COLOR,
      no_data: {text: NO_DATA, style: {color: SECONDARY_CHART_COLOR}}
    }
  end

  def radial_chart_options
    {
      legend: false,
      height: RADIAL_CHART_HEIGHT,
      colors: PRIMARY_CHART_COLOR,
      plot_options: {
        radial_bar: {
          data_labels: {
            name: {font_size: "14px", offset_y: -10, color: SECONDARY_CHART_COLOR},
            value: {font_size: "32px", font_weight: 600, offset_y: 5}
          }
        }
      }
    }
  end
end
