# Concrete class for line chart
class Chart.D3Line extends Chart.D3Chart
  'use strict'

  @area: (xScale, yScale, labels, options, chartHeight) ->
    interpolate = if options.bezierCurve then D3Line.bezierCurve else 'linear'
    d3.svg.area()
      .x((d, i) -> xScale(labels[i]))
      .y0(chartHeight)
      .y1((d) -> yScale(d))
      .interpolate(interpolate)

  @bezierCurve: (points) ->
    f = points.shift()
    d = "#{f[0]} #{f[1]}"
    points.forEach (p) ->
      m = (p[0] - f[0]) / 2
      d += " C #{f[0] + m} #{f[1]} #{p[0] - m} #{p[1]} #{p[0]} #{p[1]}"
      f = p
    d

  @line: (xScale, yScale, labels, options) ->
    interpolate = if options.bezierCurve then D3Line.bezierCurve else 'linear'
    d3.svg.line()
      .x((d, i) -> xScale(labels[i]))
      .y((d) -> yScale(d))
      .interpolate(interpolate)

  @xScale: (domain, max) ->
    d3.scale.ordinal().domain(domain).rangePoints([0, max], 0, 0)

  @yScale: (data, max, min = 0) ->
    maxY = d3.max(data, (d) -> d3.max(d.data))
    d3.scale.linear().domain([0, maxY]).range([max, min]).nice()

  constructor: (selectors, data, options) ->
    margin = top: 13, right: 23, bottom: 24, left: 55
    super(selectors, data, options, margin)

  # TODO: enable spec
  render: =>
    labels = @data.labels
    data = @setDefaultColors(@data.datasets)

    return this unless (data? or data?.length?)

    options = @options
    strokeWidth = @options.barStrokeWidth

    chartWidth = @width
    chartHeight = @height

    xScale = D3Line.xScale(labels, chartWidth)
    yScale = D3Line.yScale(data, chartHeight)

    @renderXGrid(xScale, chartHeight)
    @renderYGrid(yScale, chartWidth)
    @renderGrid()
    @renderXAxis(xScale, chartHeight)
    @renderYAxis(yScale)

    @renderLinesGroup(data)
    area = D3Line.area(xScale, yScale, labels, options, chartHeight)
    @renderAreas(area, data, options)
    line = D3Line.line(xScale, yScale, labels, options)
    @renderLines(line, data, options)
    @renderDots(data, labels, xScale, yScale, options)

    @updateGridTickStyle(options)
    @updateScaleStrokeStyle(options)
    @updateScaleTextStyle(options)

    sl = @getTransitionSelection(@duration(), options)
    @transitAreas(sl, chartHeight)
    @transitLines(sl, chartHeight)
    @transitDots(sl, chartHeight, yScale)

    this

  renderLinesGroup: (data) =>
    @getBaseSelection()
      .select(@className('base-group'))
      .append('g')
      .classed(@classedName('line-chart-group'), true)
      .append('g')
      .classed(@classedName('lines-group'), true)
      .selectAll('g')
      .data(data)
      .enter()
      .append('g')
      .classed(@classedName('line-group'), true)

  renderAreas: (area, data, options) =>
    return null unless options.datasetFill
    @getBaseSelection()
      .selectAll(@className('line-group'))
      .data(data)
      .append('path')
      .classed(@classedName('area'), true)
      .attr('d', (d) -> area(d.data))
      .attr('stroke', 'none')
      .attr('fill', (d) -> d.fillColor)

  renderDots: (data, labels, xScale, yScale, options) =>
    return null unless options.pointDot
    dataset = data.map (d1) ->
      d1.data.map (d2) ->
        value: d2
        fillColor: d1.fillColor
        strokeColor: d1.strokeColor
        pointColor: d1.pointColor
        pointStrokeColor: d1.pointStrokeColor
    @getBaseSelection()
      .selectAll(@className('line-group'))
      .data(dataset)
      .selectAll(@className('dot'))
      .data((d) -> d)
      .enter()
      .append('circle')
      .classed(@classedName('dot'), true)
      .attr(r: options.pointDotRadius)
      .attr('cx', (d, i) -> xScale(labels[i]))
      .attr('cy', (d) -> yScale(d.value))
      .attr('stroke', (d, i) -> d.pointStrokeColor)
      .attr('stroke-width', options.pointDotStrokeWidth)
      .attr('fill', (d, i) -> d.pointColor)

  renderLines: (line, data, options) =>
    @getBaseSelection()
      .selectAll(@className('line-group'))
      .data(data)
      .append('path')
      .classed(@classedName('line'), true)
      .attr('d', (d) -> line(d.data))
      .attr('stroke', (d) -> d.strokeColor)
      .attr('stroke-width', options.datasetStrokeWidth)
      .attr('fill', 'none')

  transitAreas: (el, chartHeight) =>
    @getBaseSelection()
      .selectAll(@className('area'))
      .attr('transform', "translate(0,#{chartHeight}) scale(1,0)")
    el.selectAll(@className('area'))
      .attr('transform', 'translate(0,0) scale(1,1)')

  transitDots: (el, chartHeight, yScale) =>
    @getBaseSelection()
      .selectAll(@className('dot'))
      .attr('cy', chartHeight)
    el.selectAll(@className('dot'))
      .attr('cy', (d, i) -> yScale(d.value))

  transitLines: (el, chartHeight) =>
    @getBaseSelection()
      .selectAll(@className('line'))
      .attr('transform', "translate(0,#{chartHeight}) scale(1,0)")
    el.selectAll(@className('line'))
      .attr('transform', 'translate(0,0) scale(1,1)')
