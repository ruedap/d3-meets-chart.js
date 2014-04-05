chai = require 'chai'
expect = chai.expect

{Chart} = require "../src/d3-meets-chart"

describe 'Chart', ->
  describe '::constructor', ->
    describe 'when arguments is valid', ->
      it 'contains the element name in the returned object', ->
        chart = new Chart '#root-svg'
        expect(chart.element).to.eq '#root-svg'
