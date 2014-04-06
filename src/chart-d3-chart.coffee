class Chart.D3Chart
  constructor: (@selectors, @data, @options) ->

  # FIXME: style(responsive) and percent unit support
  attrTranslateToCenter: =>
    halfWidth = @getRootElementWidth() / 2
    halfHeight = @getRootElementHeight() / 2
    "translate(#{halfWidth}, #{halfHeight})"

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
