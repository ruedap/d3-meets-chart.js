class Chart.D3Bar extends Chart.D3Chart
  'use strict'

  constructor: (selectors, data, options) ->
    super selectors, data, options

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
    d3.nest()
      .key (d) -> d.label
      .entries(array)

  render: ->
    data = @generateData(@data.labels, @data.datasets)
    this
