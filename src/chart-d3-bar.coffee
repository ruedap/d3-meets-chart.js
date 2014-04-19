# Concrete class
class Chart.D3Bar extends Chart.D3Chart
  'use strict'

  # FIXME
  @adjustRangeBand: (rangeBand) ->
    rangeBand - 1  # Set 1 pixel margin width

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

  getTransitionElement: (duration, options) =>
    @getRootElement()
      .transition()
      .duration(duration)
      .ease(options.animationEasing)

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
