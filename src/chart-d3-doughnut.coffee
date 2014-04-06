class Chart.D3Doughnut extends Chart.D3Pie
  constructor: (selectors, data, options) ->
    super selectors, data, options

  getInnerRadius: (outerRadius, options) ->
    ~~(outerRadius * (options.percentageInnerCutout / 100))
