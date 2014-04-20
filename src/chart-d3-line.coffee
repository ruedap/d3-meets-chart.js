# Concrete class
class Chart.D3Line extends Chart.D3Chart
  'use strict'

  @area: (xScale, yScale, labels, chartHeight) ->
    d3.svg.area()
      .x((d, i) -> xScale(labels[i]))
      .y0(chartHeight)
      .y1((d) -> yScale(d))
      .interpolate('cardinal')

  @line: (xScale, yScale, labels) ->
    d3.svg.line()
      .x((d, i) -> xScale(labels[i]))
      .y((d) -> yScale(d))
      .interpolate('cardinal')

  @xScale: (domain, max) ->
    d3.scale.ordinal().domain(domain).rangePoints([0, max], 0, 0)

  @yScale: (data, max, min = 0) ->
    maxY = d3.max(data, (d) -> d3.max(d.data))
    d3.scale.linear().domain([0, maxY]).range([max, min]).nice()

  constructor: (selectors, data, options) ->
    margin = top: 13, right: 23, bottom: 24, left: 55
    super(selectors, data, options, margin)

  # TODO: enable test
  render: =>
    labels = @data.labels
    data = @data.datasets
    return this if _.isEmpty(data)

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
    area = D3Line.area(xScale, yScale, labels, chartHeight)
    @renderAreas(area, data)
    line = D3Line.line(xScale, yScale, labels)
    @renderLines(line, data, options)

    @updateGridTickStyle(options)
    @updateScaleStrokeStyle(options)
    @updateScaleTextStyle(options)
    this

  renderLinesGroup: (data) =>
    @getRootElement()
      .select('.margin-convention-element')
      .append('g')
      .classed('line-chart', true)
      .append('g')
      .classed('lines-group', true)
      .selectAll('g')
      .data(data)
      .enter()
      .append('g')
      .classed('line-group', true)

  renderAreas: (area, data) =>
    @getRootElement()
      .selectAll('.line-group')
      .data(data)
      .append('path')
      .classed('area', true)
      .attr('d', (d) -> area(d.data))
      .attr('stroke', 'none')
      .attr('fill', (d) -> d.fillColor)

  renderLines: (line, data, options) =>
    @getRootElement()
      .selectAll('.line-group')
      .data(data)
      .append('path')
      .classed('line', true)
      .attr('d', (d) -> line(d.data))
      .attr('stroke', (d) -> d.strokeColor)
      .attr('stroke-width', options.datasetStrokeWidth)
      .attr('fill', 'none')
