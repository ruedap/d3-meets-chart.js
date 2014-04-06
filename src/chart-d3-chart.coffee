class Chart.D3Chart
  constructor: (@selectors, @data, @options) ->

  getRootElement: =>
    d3.select @selectors
