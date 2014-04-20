# Abstract root class
class Chart.D3Chart
  'use strict'

  @xAxis: (xScale, ticks = 10) ->
    d3.svg.axis().scale(xScale).ticks(ticks).tickSize(3, 3)
      .tickPadding(5).orient('bottom')

  @yAxis: (yScale) ->
    d3.svg.axis().scale(yScale).ticks(20).tickSize(3, 0)
      .tickPadding(7).orient('left')

  constructor: (@selectors, @data, @options, margin) ->
    margin or= top: 0, right: 0, bottom: 0, left: 0
    @defineRootElement(
      @getRootElement(),
      @getRootElementWidth(),
      @getRootElementHeight(),
      margin
    )

  # FIXME: style(responsive) and percent unit support
  attrTranslateToCenter: =>
    halfWidth = @getRootElementWidth() / 2
    halfHeight = @getRootElementHeight() / 2
    "translate(#{halfWidth}, #{halfHeight})"

  # http://bl.ocks.org/mbostock/3019563
  defineRootElement: (element, width, height, margin) ->
    @width = width - margin.left - margin.right
    @height = height - margin.top - margin.bottom
    @getRootElement()
      .attr(width: @width + margin.left + margin.right)
      .attr(height: @height + margin.top + margin.bottom)
      .append('g')
      .attr(transform: "translate(#{margin.left},#{margin.top})")
      .classed('margin-convention-element': true)

  duration: (options = @options) ->
    options.animationSteps * 17.333

  getRootElement: =>
    d3.select(@selectors)

  # FIXME: style(responsive) and percent unit support
  getRootElementHeight: =>
    +@getRootElement().attr('height')

  # FIXME: style(responsive) and percent unit support
  getRootElementWidth: =>
    +@getRootElement().attr('width')

  renderXGrid: (x0Scale, chartHeight) =>
    x = x0Scale.rangeBand() / 2
    @getRootElement()
      .select('.margin-convention-element')
      .append('g')
      .classed('grid-group': true, 'grid-x-group': true)
      .call(D3Chart.xAxis(x0Scale).tickFormat(''))
      .selectAll('.tick line')
      .attr(x1: x, x2: x, y2: chartHeight)

  renderYGrid: (yScale, chartWidth) =>
    @getRootElement()
      .select('.margin-convention-element')
      .append('g')
      .classed('grid-group': true, 'grid-y-group': true)
      .call(D3Chart.yAxis(yScale).tickFormat(''))
      .selectAll('.tick line')
      .attr(x1: 0, x2: chartWidth)

  renderGrid: =>
    @getRootElement()
      .selectAll('.grid-group')
      .selectAll('.domain, text')
      .data([])
      .exit()
      .remove()

  renderXAxis: (xScale, chartHeight) =>
    @getRootElement()
      .select('.margin-convention-element')
      .append('g')
      .classed('scale-group': true, 'scale-x-group': true)
      .attr('transform', "translate(0,#{chartHeight})")
      .call(D3Chart.xAxis(xScale))

  renderYAxis: (yScale) =>
    @getRootElement()
      .select('.margin-convention-element')
      .append('g')
      .classed('scale-group': true, 'scale-y-group': true)
      .call(D3Chart.yAxis(yScale))
      .select('.tick > text').remove()  # Remove tick of zero

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
