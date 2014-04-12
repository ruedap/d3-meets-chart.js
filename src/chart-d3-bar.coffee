class Chart.D3Bar extends Chart.D3Chart
  'use strict'

  @adjustRangeBand: (rangeBand) ->
    rangeBand - 1  # Set 1 pixel margin width

  @xAxis: (xScale) ->
    d3.svg.axis().scale(xScale).ticks(10).tickSize(6, 6).orient('bottom')

  @yAxis: (yScale) ->
    d3.svg.axis().scale(yScale).ticks(20).tickSize(6, 0).orient('left')

  @xScale: (domain, max) ->
    d3.scale.ordinal().domain(domain).rangeRoundBands([0, max], 0, 0)

  @yScale: (data, min) ->
    maxY = d3.max(data, (d) -> d3.max(d.values, (d) -> d.value))
    d3.scale.linear().domain([0, maxY]).range([min, 0]).nice()

  @generateData: (labels, datasets) ->
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

  constructor: (selectors, data, options) ->
    margin = top: 13, right: 23, bottom: 24, left: 55
    super(selectors, data, options, margin)

  # TODO: Refactor
  render: =>
    labels = @data.labels
    datasets = @data.datasets
    data = D3Bar.generateData(labels, datasets)
    return this if _.isEmpty(data)

    options = @options
    strokeWidth = @options.barStrokeWidth

    width = @width
    height = @height

    x0Scale = D3Bar.xScale(labels, width)
    x1Scale = D3Bar.xScale(d3.range(datasets.length), x0Scale.rangeBand())
    yScale = D3Bar.yScale(data, height)

    @renderXAxis(x0Scale, height)
    @renderYAxis(yScale)

    datasetElement = @getRootElement()
      .select('.margin-convention-element')
      .append('g')
      .attr('class', 'chart')
      .selectAll('.dataset')
      .data(data)
      .enter()
      .append('g')
      .attr('class', 'dataset')
      .attr('transform', (d) -> "translate(#{x0Scale(d.key)},0)")
    datasetElement
      .selectAll('rect')
      .data((d, i) -> d.values)
      .enter()
      .append('g')
      .attr('class', 'bar')
      .append('rect')
      .attr('x', (d, i) -> x1Scale(i))
      .attr('width', D3Bar.adjustRangeBand(x1Scale.rangeBand()))
      .attr('y', (d, i) -> yScale(d.value))
      .attr('height', (d) -> height - yScale(d.value))
      .style('fill', (d) -> d.fillColor)
    datasetElement
      .selectAll('.bar')
      .append('path')
      .attr 'd', (d, i) ->
        rectBorderPath(d, i, height, x1Scale, yScale, strokeWidth)
      .attr('fill', (d) -> d.strokeColor)
      .attr('stroke-width', strokeWidth)

    @updateStyleBasedOnOptions(options)
    this

  renderXAxis: (xScale, height) =>
    @getRootElement()
      .select('.margin-convention-element')
      .append('g')
      .attr('class', 'scale scale-x')
      .attr('transform', "translate(0,#{height})")
      .call(D3Bar.xAxis(xScale))

  renderYAxis: (yScale) =>
    @getRootElement()
      .select('.margin-convention-element')
      .append('g')
      .attr('class', 'scale scale-y')
      .call(D3Bar.yAxis(yScale))

  updateStyleBasedOnOptions: (options) =>
    @getRootElement()
      .selectAll('.scale line, .scale path')
      .attr('stroke', options.scaleLineColor)
      .attr('fill', 'none')
    @getRootElement()
      .selectAll('.scale text')
      .attr('font-family', options.scaleFontFamily)
      .attr('font-size', options.scaleFontSize)
      .attr('font-style', options.scaleFontStyle)
      .attr('fill', options.scaleFontColor)

  # TODO: test
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
