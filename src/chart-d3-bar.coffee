# Concrete class for bar chart
class Chart.D3Bar extends Chart.D3Chart
  'use strict'

  # FIXME
  @adjustRangeBand: (rangeBand) ->
    rangeBand - 1  # Set 1 pixel margin width

  @rectBorderPath = (datum, i, chartHeight, x1Scale, yScale, options) ->
    _ch = chartHeight
    _swh = options.barStrokeWidth / 2
    _x = x1Scale(i)
    _w = D3Bar.adjustRangeBand(x1Scale.rangeBand())
    _y = yScale(datum.value) + _swh
    _data = [
      { x: _x + _swh, y: _ch },
      { x: _x + _swh, y: _y },
      { x: _x + _w - _swh, y: _y },
      { x: _x + _w - _swh, y: _ch },
    ]
    d3.svg.line().x((d) -> d.x).y((d) -> d.y)(_data)

  @xScale: (domain, max) ->
    d3.scale.ordinal().domain(domain).rangeRoundBands([0, max], 0, 0)

  @yScale: (data, max, min = 0) ->
    maxY = d3.max(data, (d) -> d3.max(d.values, (d) -> d.value))
    d3.scale.linear().domain([0, maxY]).range([max, min]).nice()

  constructor: (selectors, data, options) ->
    margin = top: 13, right: 23, bottom: 24, left: 55
    super(selectors, data, options, margin)

  generateData: (labels, datasets) ->
    return null if !(labels? and datasets?)
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

  # TODO: enable spec
  render: =>
    labels = @data.labels
    datasets = @data.datasets
    data = @generateData(labels, datasets)
    return this unless (data? or data?.length?)

    options = @options

    chartWidth = @width
    chartHeight = @height

    x0Scale = D3Bar.xScale(labels, chartWidth)
    _domain = d3.range(datasets.length)
    _max = x0Scale.rangeBand() - (options.barValueSpacing * 2)
    x1Scale = D3Bar.xScale(_domain, _max)
    yScale = D3Bar.yScale(data, chartHeight)

    @renderXGrid(x0Scale, chartHeight)
    @renderYGrid(yScale, chartWidth)
    @renderGrid()
    @renderXAxis(x0Scale, chartHeight)
    @renderYAxis(yScale)

    @renderBars(data, x0Scale, options)
    @renderBar(chartHeight, x1Scale, yScale, options)
    @renderBarBorder(chartHeight, x1Scale, yScale, options)

    @updateGridTickStyle(options)
    @updateScaleStrokeStyle(options)
    @updateScaleTextStyle(options)

    el = @getTransitionElement(@duration(), options)
    @transitBar(el, chartHeight, yScale)
    @transitBarBorder(el, chartHeight)
    this

  renderBars: (data, x0Scale, options) =>
    @getRootElement()
      .select(@className('margin-convention-element'))
      .append('g')
      .classed(@classedName('bar-chart-group'), true)
      .selectAll(@className('bars-group'))
      .data(data)
      .enter()
      .append('g')
      .classed(@classedName('bars-group'), true)
      .attr('transform', (d) -> "translate(#{x0Scale(d.key) + options.barValueSpacing},0)")

  renderBar: (chartHeight, x1Scale, yScale, options) =>
    @getRootElement()
      .selectAll(@className('bars-group'))
      .selectAll('rect')
      .data((d, i) -> d.values)
      .enter()
      .append('g')
      .classed(@classedName('bar-group'), true)
      .append('rect')
      .classed(@classedName('bar'), true)
      .attr('x', (d, i) -> x1Scale(i))
      .attr('width', D3Bar.adjustRangeBand(x1Scale.rangeBand()))
      .attr('y', (d, i) -> yScale(d.value))
      .attr('height', (d) -> chartHeight - yScale(d.value))
      .attr('fill', (d) -> d.fillColor)

  renderBarBorder: (chartHeight, x1Scale, yScale, options) =>
    @getRootElement()
      .selectAll(@className('bars-group'))
      .selectAll(@className('bar-group'))
      .append('path')
      .classed(@classedName('bar-border'), true)
      .attr 'd', (d, i) ->
        D3Bar.rectBorderPath(d, i, chartHeight, x1Scale, yScale, options)
      .attr('fill', 'none')
      .attr('stroke', (d) -> d.strokeColor)
      .attr('stroke-width', options.barStrokeWidth)

  transitBar: (el, chartHeight, yScale) =>
    @getRootElement()
      .selectAll(@className('bar'))
      .attr('y', chartHeight)
      .attr('height', 0)
    el.selectAll(@className('bar'))
      .attr('y', (d, i) -> yScale(d.value))
      .attr('height', (d) -> chartHeight - yScale(d.value))

  # FIXME: stroke width problem
  transitBarBorder: (el, chartHeight) =>
    @getRootElement()
      .selectAll(@className('bar-border'))
      .attr('transform', "translate(0,#{chartHeight}) scale(1,0)")
    el.selectAll(@className('bar-border'))
      .attr('transform', 'translate(0,0) scale(1,1)')
