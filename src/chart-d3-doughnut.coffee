# Concrete class for doughnut chart
class Chart.D3Doughnut extends Chart.D3Pie
  'use strict'

  getInnerRadius: (outerRadius, options) ->
    ~~(outerRadius * (options.percentageInnerCutout / 100))

  renderPie: (data, options) ->
    super(data, options, 'doughnut')

  setDefaultColors: (data) ->
    super(data, _defaultColors())

  _defaultColors = ->
    [
      '#f7464a', '#46bfbd', '#fdb45c', '#949fb1', '#4d5360',
      '#42b3e5', '#ecf0f1', '#bae1fa', '#e277b7', '#9b59b6'
    ]
