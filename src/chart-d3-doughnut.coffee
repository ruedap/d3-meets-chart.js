# Concrete class for doughnut chart
class Chart.D3Doughnut extends Chart.D3Pie
  'use strict'

  defaultColors: ->
    [
      '#f7464a', '#46bfbd', '#fdb45c', '#949fb1', '#4d5360',
      '#a4d7f4', '#2980b9', '#fddb2f', '#a8dba8'
    ]

  getInnerRadius: (outerRadius, options) ->
    ~~(outerRadius * (options.percentageInnerCutout / 100))

  renderPie: (data, options) ->
    super(data, options, 'doughnut')
