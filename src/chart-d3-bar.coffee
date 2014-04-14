class Chart.D3Bar extends Chart.D3Chart
  'use strict'

  # FIXME
  @adjustRangeBand: (rangeBand) ->
    rangeBand - 1  # Set 1 pixel margin width

  @xAxis: (xScale, ticks = 10) ->
    d3.svg.axis().scale(xScale).ticks(ticks).tickSize(3, 3)
      .tickPadding(5).orient('bottom')

  @yAxis: (yScale) ->
    d3.svg.axis().scale(yScale).ticks(20).tickSize(3, 0)
      .tickPadding(7).orient('left')

  @xScale: (domain, max) ->
    d3.scale.ordinal().domain(domain).rangeRoundBands([0, max], 0, 0)

  @yScale: (data, max, min = 0) ->
    maxY = d3.max(data, (d) -> d3.max(d.values, (d) -> d.value))
    d3.scale.linear().domain([0, maxY]).range([max, min]).nice()

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

  @rectBorderPath = (datum, i, chartHeight, xScale, yScale, strokeWidth) ->
    _ch = chartHeight
    _swh = strokeWidth / 2
    _x = xScale(i)
    _w = D3Bar.adjustRangeBand(xScale.rangeBand())
    _y = yScale(datum.value) + _swh
    _data = [
      { x: _x + _swh, y: _ch },
      { x: _x + _swh, y: _y },
      { x: _x + _w - _swh, y: _y },
      { x: _x + _w - _swh, y: _ch },
    ]
    d3.svg.line().x((d) -> d.x).y((d) -> d.y)(_data)

  constructor: (selectors, data, options) ->
    margin = top: 13, right: 23, bottom: 24, left: 55
    super(selectors, data, options, margin)

  getTransitionElement: (duration, options) =>
    @getRootElement()
      .transition()
      .duration(duration)
      .ease(options.animationEasing)

  # TODO: enable test
  render: =>
    labels = @data.labels
    datasets = @data.datasets
    data = D3Bar.generateData(labels, datasets)
    return this if _.isEmpty(data)

    options = @options
    strokeWidth = @options.barStrokeWidth

    chartWidth = @width
    chartHeight = @height

    x0Scale = D3Bar.xScale(labels, chartWidth)
    x1Scale = D3Bar.xScale(d3.range(datasets.length), x0Scale.rangeBand())
    yScale = D3Bar.yScale(data, chartHeight)

    @renderXGrid(x0Scale, chartHeight)
    @renderYGrid(yScale, chartWidth)
    @renderGrid()
    @renderXAxis(x0Scale, chartHeight)
    @renderYAxis(yScale)
    @renderBars(data, x0Scale)
    @renderBar(chartHeight, x1Scale, yScale)
    @renderBarBorder(chartHeight, x1Scale, yScale, strokeWidth)

    @updateGridTickStyle(options)
    @updateScaleStrokeStyle(options)
    @updateScaleTextStyle(options)

    el = @getTransitionElement(@duration(), options)
    @transitBar(el, chartHeight, yScale)
    @transitBarBorder(el, chartHeight)
    this

  renderXGrid: (x0Scale, chartHeight) =>
    x = x0Scale.rangeBand() / 2
    @getRootElement()
      .select('.margin-convention-element')
      .append('g')
      .classed('grid-group': true, 'grid-x-group': true)
      .call(D3Bar.xAxis(x0Scale).tickFormat(''))
      .selectAll('.tick line')
      .attr(x1: x, x2: x, y2: chartHeight)

  renderYGrid: (yScale, chartWidth) =>
    @getRootElement()
      .select('.margin-convention-element')
      .append('g')
      .classed('grid-group': true, 'grid-y-group': true)
      .call(D3Bar.yAxis(yScale).tickFormat(''))
      .selectAll('.tick line')
      .attr(x1: 0, x2: chartWidth)

  renderGrid: =>
    @getRootElement()
      .selectAll('.grid-group')
      .selectAll('.domain, text')
      .data([])
      .exit()
      .remove()

  renderXAxis: (x0Scale, chartHeight) =>
    @getRootElement()
      .select('.margin-convention-element')
      .append('g')
      .classed('scale-group': true, 'scale-x-group': true)
      .attr('transform', "translate(0,#{chartHeight})")
      .call(D3Bar.xAxis(x0Scale))

  renderYAxis: (yScale) =>
    @getRootElement()
      .select('.margin-convention-element')
      .append('g')
      .classed('scale-group': true, 'scale-y-group': true)
      .call(D3Bar.yAxis(yScale))

  renderBars: (data, x0Scale) =>
    @getRootElement()
      .select('.margin-convention-element')
      .append('g')
      .classed('bar-chart', true)
      .selectAll('.bars-group')
      .data(data)
      .enter()
      .append('g')
      .classed('bars-group', true)
      .attr('transform', (d) -> "translate(#{x0Scale(d.key)},0)")

  renderBar: (chartHeight, x1Scale, yScale) =>
    @getRootElement()
      .selectAll('.bars-group')
      .selectAll('rect')
      .data((d, i) -> d.values)
      .enter()
      .append('g')
      .classed('bar-group', true)
      .append('rect')
      .classed('bar', true)
      .attr('x', (d, i) -> x1Scale(i))
      .attr('width', D3Bar.adjustRangeBand(x1Scale.rangeBand()))
      .attr('y', (d, i) -> yScale(d.value))
      .attr('height', (d) -> chartHeight - yScale(d.value))
      .attr('fill', (d) -> d.fillColor)

  renderBarBorder: (chartHeight, x1Scale, yScale, strokeWidth) =>
    @getRootElement()
      .selectAll('.bars-group')
      .selectAll('.bar-group')
      .append('path')
      .classed('bar-border', true)
      .attr 'd', (d, i) ->
        D3Bar.rectBorderPath(d, i, chartHeight, x1Scale, yScale, strokeWidth)
      .attr('fill', 'none')
      .attr('stroke', (d) -> d.strokeColor)
      .attr('stroke-width', strokeWidth)

  updateGridTickStyle: (options) =>
    @getRootElement()
      .selectAll('.grid-group .tick line')
      .attr(stroke: options.scaleGridLineColor)

  updateScaleStrokeStyle: (options) =>
    @getRootElement()
      .selectAll('.scale-group')
      .selectAll('.domain, .tick line')
      .attr(fill: 'none')
      .attr(stroke: options.scaleLineColor)
      .attr('stroke-width': options.scaleLineWidth)

  updateScaleTextStyle: (options) =>
    @getRootElement()
      .selectAll('.scale-group text')
      .attr('font-family': options.scaleFontFamily)
      .attr('font-size': options.scaleFontSize)
      .attr('font-style': options.scaleFontStyle)
      .attr('fill': options.scaleFontColor)

  transitBar: (el,chartHeight, yScale) =>
    @getRootElement()
      .selectAll('.bar')
      .attr('y', chartHeight)
      .attr('height', 0)
    el.selectAll('.bar')
      .attr('y', (d, i) -> yScale(d.value))
      .attr('height', (d) -> chartHeight - yScale(d.value))

  # FIXME: stroke width problem
  transitBarBorder: (el, chartHeight) =>
    @getRootElement()
      .selectAll('.bar-border')
      .attr('transform', "translate(0,#{chartHeight}) scale(1,0)")
    el.selectAll('.bar-border')
      .attr('transform', 'translate(0,0) scale(1,1)')
