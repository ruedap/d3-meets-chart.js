{Chart} = require '../tmp/d3-meets-chart'
global.expect = require 'expect.js'

before ->
  d3.select('body')
    .append('svg')
    .attr
      id: 'svg'
      width: 600
      height: 450
