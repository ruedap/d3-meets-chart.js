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

  describe '.generateData', ->
    context 'when arguments are invalid', ->
      it 'should return undefined', ->
        expect(Chart.D3Bar.generateData([], null)).to.be(undefined)
        expect(Chart.D3Bar.generateData(null, [])).to.be(undefined)
        expect(Chart.D3Bar.generateData(null, null)).to.be(undefined)

    context 'when arguments are valid', ->
      context 'when arguments are blank arrays', ->
        it 'should return a blank array', ->
          actual = Chart.D3Bar.generateData([], [])
          expect(actual).to.be.an Array
          expect(actual).to.eql([])

      context 'when arguments are not blank arrays', ->
        it 'should return an array', ->
          actual = Chart.D3Bar.generateData(@data.labels, @data.datasets)
          expect(actual).to.be.an Array
          expect(actual[0].key).to.be('January')
          expect(actual[0].values[1].value).to.be(28)
          expect(actual[6].values[1].value).to.be(100)

  describe '.xAxis', ->
    it 'should return a function', ->
      actual = Chart.D3Bar.xAxis(d3.scale.ordinal())
      expect(actual).to.be.a 'function'

  describe '.yAxis', ->
    it 'should return a function', ->
      actual = Chart.D3Bar.yAxis(d3.scale.ordinal())
      expect(actual).to.be.a 'function'

  describe '.xScale', ->
    it 'should return a function', ->
      actual = Chart.D3Bar.xScale([0, 0], 0)
      expect(actual).to.be.a 'function'

  describe '.yScale', ->
    it 'should return a function', ->
      data = Chart.D3Bar.generateData(@data.labels, @data.datasets)
      actual = Chart.D3Bar.yScale(data, 0)
      expect(actual).to.be.a 'function'

  describe '::constructor', ->
    it 'should have same values in properties', ->
      expect(@d3Bar.selectors).to.be '#svg'
      expect(@d3Bar.data).to.eql @data
      expect(@d3Bar.options).to.eql {}

  describe '::render', ->
    it 'pending'

  describe '::renderXAxis', ->
    it 'should return an array', ->
      xScale = Chart.D3Bar.xScale([0, 0], 0)
      actual = @d3Bar.renderXAxis(xScale, 0)
      expect(actual).to.be.an Array

  describe '::renderYAxis', ->
    it 'should return an array', ->
      data = Chart.D3Bar.generateData(@data.labels, @data.datasets)
      yScale = Chart.D3Bar.yScale(data, 0)
      actual = @d3Bar.renderYAxis(yScale)
      expect(actual).to.be.an Array

  describe '::renderRect', ->
    it 'should return an array', ->
      xScale = Chart.D3Bar.xScale([0, 0], 0)
      data = Chart.D3Bar.generateData(@data.labels, @data.datasets)
      yScale = Chart.D3Bar.yScale(data, 0)
      actual = @d3Bar.renderRect(0, xScale, yScale)
      expect(actual).to.be.an Array

  describe '::renderRectBorder', ->
    it 'should return an array', ->
      xScale = Chart.D3Bar.xScale([0, 0], 0)
      data = Chart.D3Bar.generateData(@data.labels, @data.datasets)
      yScale = Chart.D3Bar.yScale(data, 0)
      actual = @d3Bar.renderRectBorder(0, xScale, yScale, 0)
      expect(actual).to.be.an Array

  describe '::updateStyleBasedOnOptions', ->
    it 'should return an array', ->
      actual = @d3Bar.updateStyleBasedOnOptions({})
      expect(actual).to.be.an Array
