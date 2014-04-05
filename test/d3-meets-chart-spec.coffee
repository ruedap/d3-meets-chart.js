{Chart} = require '../src/d3-meets-chart'

chai = require 'chai'
expect = chai.expect

describe 'Chart', ->
  describe '::constructor', ->
    context 'when arguments is valid', ->
      it 'should contains the element name in the returned object', ->
        chart = new Chart '#root-svg'
        expect(chart.selector).to.eq '#root-svg'

    context 'when arguments is invalid', ->
      it 'should raise TypeError exception', ->
        message = 'This argument is not a selector string'
        expect(-> new Chart(null)).to.throw TypeError, message

  describe '::Doughnut', ->
    it 'pending'
