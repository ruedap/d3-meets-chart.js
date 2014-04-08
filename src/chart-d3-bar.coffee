class Chart.D3Bar extends Chart.D3Chart
  'use strict'

  constructor: (selectors, data, options) ->
    super(selectors, data, options)

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
      .key((d) -> d.label)
      .entries(array)

  # TODO: Refactor
  render: ->
    labels = @data.labels
    datasets = @data.datasets
    data = @generateData(labels, datasets)
    return this if _.isEmpty(data)

    x0 = d3.scale.ordinal().domain(labels).rangeRoundBands([0, @width], 0, 0)
    x1 = d3.scale.ordinal().domain(d3.range(datasets.length))
      .rangeRoundBands([0, x0.rangeBand()], 0, 0)
    y = d3.scale.linear().range([@height, 0])
    maxY = d3.max(data, (d) -> d3.max(d.values, (d) -> d.value))
    y.domain([0, maxY]).nice()
    height = @height
    strokeWidth = @options.barStrokeWidth
    datasetElement = @getRootElement()
      .select('.margin-convention-element')
      .selectAll('.dataset')
      .data(data)
      .enter()
      .append('g')
      .attr('class', 'dataset')
      .attr('transform', (d) -> "translate(#{x0(d.key)},0)")
    datasetElement
      .selectAll('rect')
      .data((d, i) -> d.values)
      .enter()
      .append('rect')
      # FIXME: margin to 1 pixel
      .attr('width', (d,i) -> x1.rangeBand() - strokeWidth - 1)
      .attr('x', (d, i) -> x1(i))
      .attr('y', (d, i) -> ~~y(d.value))
      .attr('height', (d) -> height - ~~y(d.value))
      .style('fill', (d) -> d.fillColor)
      .style('stroke', (d) -> d.strokeColor)
      .style('stroke-width', strokeWidth)
    this
