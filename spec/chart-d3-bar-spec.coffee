describe 'Chart.D3Bar', ->
  'use strict'

  before ->
    @data =
      labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July']
      datasets: [
        fillColor: 'rgba(220,220,220,0.5)'
        strokeColor: 'rgba(220,220,220,1)'
        data: [65, 59, 90, 81, 56, 55, 40]
      ,
        fillColor: 'rgba(151,187,205,0.5)'
        strokeColor: 'rgba(151,187,205,1)'
        data: [28, 48, 40, 19, 96, 27, 100]
      ]
    @d3Bar = new Chart.D3Bar '#svg', @data, {}

  describe '.adjustRangeBand', ->
    it 'should return Number', ->
      expect(Chart.D3Bar.adjustRangeBand(100)).to.be 99

  describe '::constructor', ->
    it 'should have same values in properties', ->
      expect(@d3Bar.selectors).to.be '#svg'
      expect(@d3Bar.data).to.eql @data
      expect(@d3Bar.options).to.eql {}

  describe '::generateData', ->
    context 'when arguments are invalid', ->
      it 'should return undefined', ->
        expect(@d3Bar.generateData([], null)).to.be(undefined)
        expect(@d3Bar.generateData(null, [])).to.be(undefined)
        expect(@d3Bar.generateData(null, null)).to.be(undefined)

    context 'when arguments are valid', ->
      context 'when arguments are blank arrays', ->
        it 'should return a blank array', ->
          expect(@d3Bar.generateData([], [])).to.eql([])

      context 'when arguments are not blank arrays', ->
        it 'should return an array', ->
          actual = @d3Bar.generateData(@data.labels, @data.datasets)
          expect(actual[0].key).to.be('January')
          expect(actual[0].values[1].value).to.be(28)
          expect(actual[6].values[1].value).to.be(100)

  describe '::render', ->
    it 'pending'
