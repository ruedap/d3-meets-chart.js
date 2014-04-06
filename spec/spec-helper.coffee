{Chart} = require '../d3-meets-chart'

global._ = require 'underscore'
global.d3 = require 'd3'

expect = require('chai').expect

before ->
  d3.select('body')
    .append('svg')
    .attr
      id: 'svg'
      width: 450
      height: 400
