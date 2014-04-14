class Chart.D3Line extends Chart.D3Chart
  'use strict'

  constructor: (selectors, data, options) ->
    margin = top: 13, right: 23, bottom: 24, left: 55
    super(selectors, data, options, margin)

  # TODO: enable test
  render: =>
    this
