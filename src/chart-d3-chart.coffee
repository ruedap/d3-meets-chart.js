class Chart.D3Chart
  constructor: (@selectors, @data, @options) ->

  getRootElement: =>
    d3.select @selectors

  # FIXME: style and percent unit support
  getRootElementHeight: =>
    +@getRootElement().attr 'height'

  # FIXME: style and percent unit support
  getRootElementWidth: =>
    +@getRootElement().attr 'width'
