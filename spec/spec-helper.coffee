{Chart} = require '../tmp/d3-meets-chart'

global._ = require 'underscore'
global.d3 = require 'd3'

expect = require('expect.js')

before ->
  d3.select('body')
    .append('svg')
    .attr
      id: 'svg'
      width: 600
      height: 450
