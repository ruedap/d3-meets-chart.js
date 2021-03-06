# Abstract root class
class Chart.D3Chart
  'use strict'

  @xAxis: (xScale, ticks = 10) ->
    d3.svg.axis().scale(xScale).ticks(ticks).tickSize(3, 3)
      .tickPadding(5).orient('bottom')

  @yAxis: (yScale) ->
    d3.svg.axis().scale(yScale).ticks(20).tickSize(3, 0)
      .tickPadding(7).orient('left')

  attrTranslateToCenter: =>
    halfWidth = @getBaseSelectionWidth() / 2
    halfHeight = @getBaseSelectionHeight() / 2
    "translate(#{halfWidth}, #{halfHeight})"

  constructor: (@selectors, @data, @options, margin) ->
    margin or= top: 0, right: 0, bottom: 0, left: 0
    @defineBaseElement(
      @getBaseSelection(),
      @getBaseSelectionWidth(),
      @getBaseSelectionHeight(),
      margin
    )

  classedName: (name) ->
    _className(name, false)

  className: (name) ->
    _className(name, true)

  defaultColors: ->
    [ '#dcdcdc', '#97bbcd', '#ed91a2', '#7abf8a', '#f1af31' ]

  # http://bl.ocks.org/mbostock/3019563
  defineBaseElement: (element, width, height, margin) ->
    @width = width - margin.left - margin.right
    @height = height - margin.top - margin.bottom
    @getBaseSelection()
      .attr(width: @width + margin.left + margin.right)
      .attr(height: @height + margin.top + margin.bottom)
      .append('g')
      .attr(transform: "translate(#{margin.left},#{margin.top})")
      .classed(@classedName('base-group'), true)

  duration: (options = @options, rate = 17.333) ->
    return 0 unless options.animation
    options.animationSteps * rate

  getBaseSelection: =>
    d3.select(@selectors)

  getBaseSelectionHeight: =>
    +(@getBaseSelection().attr('height'))

  getBaseSelectionWidth: =>
    +(@getBaseSelection().attr('width'))

  getTransitionSelection: (duration, options) =>
    @getBaseSelection()
      .transition()
      .duration(duration)
      .ease(options.animationEasing)

  renderXGrid: (x0Scale, chartHeight) =>
    x = x0Scale.rangeBand() / 2
    @getBaseSelection()
      .select(@className('base-group'))
      .append('g')
      .classed(@classedName('grid-group'), true)
      .classed(@classedName('grid-x-group'), true)
      .call(D3Chart.xAxis(x0Scale).tickFormat(''))
      .selectAll('.tick')
      .classed(@classedName('tick'), true)
      .classed('tick', false)
      .selectAll('line')
      .attr(x1: x, x2: x, y2: chartHeight)
    @getBaseSelection()
      .selectAll(@className('grid-x-group'))
      .select('.domain').remove()

  renderYGrid: (yScale, chartWidth) =>
    @getBaseSelection()
      .select(@className('base-group'))
      .append('g')
      .classed(@classedName('grid-group'), true)
      .classed(@classedName('grid-y-group'), true)
      .call(D3Chart.yAxis(yScale).tickFormat(''))
      .selectAll('.tick')
      .classed(@classedName('tick'), true)
      .classed('tick', false)
      .selectAll('line')
      .attr(x1: 0, x2: chartWidth)

  renderGrid: =>
    @getBaseSelection()
      .selectAll("#{@className('grid-group')}")
      .selectAll("#{@className('domain')}, text")
      .data([])
      .exit()
      .remove()

  renderXAxis: (xScale, chartHeight) =>
    @getBaseSelection()
      .select(@className('base-group'))
      .append('g')
      .classed(@classedName('scale-group'), true)
      .classed(@classedName('scale-x-group'), true)
      .attr('transform', "translate(0,#{chartHeight})")
      .call(D3Chart.xAxis(xScale))
      .selectAll('.tick')
      .classed(@classedName('tick'), true)
      .classed('tick', false)

  renderYAxis: (yScale) =>
    @getBaseSelection()
      .select(@className('base-group'))
      .append('g')
      .classed(@classedName('scale-group'), true)
      .classed(@classedName('scale-y-group'), true)
      .call(D3Chart.yAxis(yScale))
      .selectAll('.tick')
      .classed(@classedName('tick'), true)
      .classed('tick', false)
      .select(':first-child > text').remove()  # Remove first tick text

  setDefaultColors: (datasets, colors = @defaultColors()) ->
    return null unless datasets?
    datasets.map (d) ->
      defaultColor = colors.shift()
      defaultColor = '#8f8f8f' unless defaultColor?
      alphaColor = Chart.Util.alpha(defaultColor, 0.5)
      data = d.data
      fillColor = if d.fillColor? then d.fillColor else alphaColor
      strokeColor = if d.strokeColor? then d.strokeColor else defaultColor
      pointColor = if d.pointColor? then d.pointColor else defaultColor
      pointStrokeColor = if d.pointStrokeColor? then d.pointStrokeColor else '#fff'
      { data, fillColor, strokeColor, pointColor, pointStrokeColor }

  updateGridTickStyle: (options) =>
    @getBaseSelection()
      .selectAll("#{@className('grid-group')} #{@className('tick')} line")
      .attr(stroke: options.scaleGridLineColor)

  updateScaleStrokeStyle: (options) =>
    @getBaseSelection()
      .selectAll("#{@className('scale-group')}")
      .selectAll(".domain, #{@className('tick')} line")
      .attr(fill: 'none')
      .attr(stroke: options.scaleLineColor)
      .attr('stroke-width': options.scaleLineWidth)

  updateScaleTextStyle: (options) =>
    @getBaseSelection()
      .selectAll("#{@className('scale-group')} text")
      .attr('font-family': options.scaleFontFamily)
      .attr('font-size': options.scaleFontSize)
      .attr('font-style': options.scaleFontStyle)
      .attr('fill': options.scaleFontColor)

  _className = (name, isSelector) ->
    dot = if isSelector then '.' else ''
    "#{dot}d3mc-#{name}"
