# Concrete class
class Chart.D3Line extends Chart.D3Chart
  'use strict'

  constructor: (selectors, data, options) ->
    margin = top: 13, right: 23, bottom: 24, left: 55
    super(selectors, data, options, margin)

  generateData: (labels, datasets) ->
    return if !(labels? and datasets?)
    array = []
    datasets.forEach (ds) ->
      ds.data.map (d, i) ->
        array.push
          value: d
          label: labels[i]
          fillColor: ds.fillColor
          strokeColor: ds.strokeColor
          pointColor: ds.pointColor
          pointStrokeColor: ds.pointStrokeColor
    d3.nest()
      .key((d) -> d.label)
      .entries(array)

  # TODO: enable test
  render: =>
    labels = @data.labels
    datasets = @data.datasets
    data = @generateData(labels, datasets)
    return this if _.isEmpty(data)

    options = @options
    strokeWidth = @options.barStrokeWidth

    chartWidth = @width
    chartHeight = @height

    x0Scale = D3Line.xScale(labels, chartWidth)
    x1Scale = D3Line.xScale(d3.range(datasets.length), x0Scale.rangeBand())
    yScale = D3Line.yScale(data, chartHeight)

    @renderXGrid(x0Scale, chartHeight)
    @renderYGrid(yScale, chartWidth)
    @renderGrid()
    @renderXAxis(x0Scale, chartHeight)
    @renderYAxis(yScale)

    @updateGridTickStyle(options)
    @updateScaleStrokeStyle(options)
    @updateScaleTextStyle(options)

    this
