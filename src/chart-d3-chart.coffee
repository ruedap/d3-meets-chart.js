class Chart.D3Chart
  'use strict'

  constructor: (@selectors, @data, @options) ->
    @margin = top: 2, right: 2, bottom: 2, left: 2
    @defineRootElement @getRootElement(), @getRootElementWidth(),
      @getRootElementHeight(), @margin

  # FIXME: style(responsive) and percent unit support
  attrTranslateToCenter: =>
    halfWidth = @getRootElementWidth() / 2
    halfHeight = @getRootElementHeight() / 2
    "translate(#{halfWidth}, #{halfHeight})"

  defineRootElement: (element, width, height, margin) ->
    @width = width - margin.left - margin.right
    @height = height - margin.top - margin.bottom
    @getRootElement()
      .attr 'width', @width + margin.left + margin.right
      .attr 'height', @height + margin.top + margin.bottom
      .append 'g'
      .attr 'transform', "translate(#{margin.left},#{margin.top})"

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
