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

    this
