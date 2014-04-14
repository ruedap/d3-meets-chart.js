# Abstract root class
class Chart.D3Chart
  'use strict'

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
      .attr 'width', @width + margin.left + margin.right
      .attr 'height', @height + margin.top + margin.bottom
      .append 'g'
      .attr 'transform', "translate(#{margin.left},#{margin.top})"
      .attr 'class', 'margin-convention-element'

  duration: (options = @options) ->
    options.animationSteps * 17.333

  getRootElement: =>
    d3.select @selectors

  # FIXME: style(responsive) and percent unit support
  getRootElementHeight: =>
    +@getRootElement().attr 'height'

  # FIXME: style(responsive) and percent unit support
  getRootElementWidth: =>
    +@getRootElement().attr 'width'
