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

    xScale1 = d3.scale.ordinal().rangeRoundBands([0, @width], 0, 0)
    xScale2 = d3.scale.ordinal()
    xAxis = d3.svg.axis().scale(xScale1).orient('bottom')
    xScale1.domain(labels)
    xScale2.domain(d3.range(datasets.length)).rangeRoundBands([0, xScale1.rangeBand()], 0, 0)
    yScale = d3.scale.linear().range([@height, 0])
    maxY = d3.max(data, (d) -> d3.max(d.values, (d) -> d.value))
    yScale.domain([0, maxY]).nice()
    height = @height
    strokeWidth = @options.barStrokeWidth

    @getRootElement()
      .select('.margin-convention-element')
      .append('g')
      .attr('class', 'x axis')
      .attr('transform', "translate(0,#{height})")
      .call(xAxis)

    datasetElement = @getRootElement()
      .select('.margin-convention-element')
      .selectAll('.dataset')
      .data(data)
      .enter()
      .append('g')
      .attr('class', 'dataset')
      .attr('transform', (d) -> "translate(#{xScale1(d.key)},0)")
    datasetElement
      .selectAll('rect')
      .data((d, i) -> d.values)
      .enter()
      .append('rect')
      # FIXME: margin to 1 pixel
      .attr('width', (d,i) -> xScale2.rangeBand() - strokeWidth - 1)
      .attr('x', (d, i) -> xScale2(i))
      .attr('y', (d, i) -> ~~yScale(d.value))
      .attr('height', (d) -> height - ~~yScale(d.value))
      .style('fill', (d) -> d.fillColor)
      .style('stroke', (d) -> d.strokeColor)
      .style('stroke-width', strokeWidth)

    this
