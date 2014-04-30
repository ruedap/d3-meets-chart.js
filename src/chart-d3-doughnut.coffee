# Concrete class for doughnut chart
class Chart.D3Doughnut extends Chart.D3Pie
  'use strict'

  getInnerRadius: (outerRadius, options) ->
    ~~(outerRadius * (options.percentageInnerCutout / 100))
