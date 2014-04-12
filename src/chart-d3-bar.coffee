class Chart.D3Bar extends Chart.D3Chart
  'use strict'

  @adjustRangeBand: (rangeBand) ->
    rangeBand - 1  # Set 1 pixel margin width

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
    xScale2
      .domain(d3.range(datasets.length))
      .rangeBands([0, xScale1.rangeBand()], 0, 0)
    yScale = d3.scale.linear().range([@height, 0])
    yAxis = d3.svg.axis().scale(yScale).orient('left')
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

    @getRootElement()
      .select('.margin-convention-element')
      .append('g')
      .attr('class', 'y axis')
      .attr('transform', "translate(20,0")
      .call(yAxis)

    datasetElement = @getRootElement()
      .select('.margin-convention-element')
      .append('g')
      .attr('class', 'chart')
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
      .append('g')
      .attr('class', 'bar')
      .append('rect')
      .attr('x', (d, i) -> xScale2(i))
      .attr('width', D3Bar.adjustRangeBand(xScale2.rangeBand()))
      .attr('y', (d, i) -> yScale(d.value))
      .attr('height', (d) -> height - yScale(d.value))
      .style('fill', (d) -> d.fillColor)
    datasetElement
      .selectAll('.bar')
      .append('path')
      .attr 'd', (d, i) ->
        rectBorderPath(d, i, height, xScale2, yScale, strokeWidth)
      .attr('fill', (d) -> d.strokeColor)
      .attr('stroke-width', strokeWidth)
    this

  rectBorderPath = (datum, i, h, xScale, yScale, sw) ->
    _x = xScale(i)
    _w = D3Bar.adjustRangeBand(xScale.rangeBand())
    _y = yScale(datum.value)
    _h = h - yScale(datum.value)
    _data = [
      { x: _x, y: h },
      { x: _x, y: _y },
      { x: _x + _w, y: _y },
      { x: _x + _w, y: h },
      { x: _x + _w - sw, y: h },
      { x: _x + _w - sw, y: _y + sw },
      { x: _x + sw, y: _y + sw },
      { x: _x + sw, y: h },
    ]
    d3.svg.line().x((d) -> d.x).y((d) -> d.y)(_data) + 'z'
