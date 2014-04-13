describe 'Chart.D3Bar', ->
  'use strict'

  args = {}
  instance = undefined

  before ->
    args.data =
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
    instance = new Chart.D3Bar '#svg', args.data, {}

  after ->
    args = {}
    instance = null

  describe '.adjustRangeBand', ->
    it 'should return a number', ->
      expect(Chart.D3Bar.adjustRangeBand(100)).to.be 99

  describe '.generateData', ->
    context 'when arguments are invalid', ->
      it 'should return an undefined', ->
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
          actual = Chart.D3Bar.generateData(args.data.labels, args.data.datasets)
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
      data = Chart.D3Bar.generateData(args.data.labels, args.data.datasets)
      actual = Chart.D3Bar.yScale(data, 0)
      expect(actual).to.be.a 'function'

  describe '.rectBorderPath', ->
    it 'should return a string of `d` attribute', ->
      data = Chart.D3Bar.generateData(args.data.labels, args.data.datasets)
      xScale = Chart.D3Bar.xScale([0, 100], 100)
      yScale = Chart.D3Bar.yScale(data, 0)
      datum = data[0].values[0]
      actual = Chart.D3Bar.rectBorderPath(datum, 0, 450, xScale, yScale, 3)
      expectation = 'M1.5,450L1.5,1.5L47.5,1.5L47.5,450'
      expect(actual).to.be expectation

  describe '::constructor', ->
    it 'should have same values in properties', ->
      expect(instance.selectors).to.be '#svg'
      expect(instance.data).to.eql args.data
      expect(instance.options).to.eql {}

  describe '::render', ->
    xit 'should return a Chart.D3Bar object', ->
      actual = instance.render()
      expect(actual).to.be.a Chart.D3Bar

  describe '::renderXGrid', ->
    it 'should return an array', ->
      x0Scale = Chart.D3Bar.xScale([0, 0], 0)
      actual = instance.renderXGrid(x0Scale, 0, 0)
      expect(actual).to.be.an Array
      expect(actual).to.have.length 1

  describe '::renderYGrid', ->
    it 'should return an array', ->
      data = Chart.D3Bar.generateData(args.data.labels, args.data.datasets)
      yScale = Chart.D3Bar.yScale(data, 0)
      actual = instance.renderYGrid(yScale, 0, 0)
      expect(actual).to.be.an Array
      expect(actual).to.have.length 1

  describe '::renderXAxis', ->
    it 'should return an array', ->
      x0Scale = Chart.D3Bar.xScale([0, 0], 0)
      actual = instance.renderXAxis(x0Scale, 0)
      expect(actual).to.be.an Array

  describe '::renderYAxis', ->
    it 'should return an array', ->
      data = Chart.D3Bar.generateData(args.data.labels, args.data.datasets)
      yScale = Chart.D3Bar.yScale(data, 0)
      actual = instance.renderYAxis(yScale)
      expect(actual).to.be.an Array

  describe '::renderBars', ->
    it 'should return an array', ->
      data = Chart.D3Bar.generateData(args.data.labels, args.data.datasets)
      x0Scale = Chart.D3Bar.xScale([0, 0], 0)
      actual = instance.renderBars(data, x0Scale)
      expect(actual).to.be.an Array

  describe '::renderBar', ->
    it 'should return an array', ->
      x1Scale = Chart.D3Bar.xScale([0, 0], 0)
      data = Chart.D3Bar.generateData(args.data.labels, args.data.datasets)
      yScale = Chart.D3Bar.yScale(data, 0)
      actual = instance.renderBar(0, x1Scale, yScale)
      expect(actual).to.be.an Array

  describe '::renderBarBorder', ->
    it 'should return an array', ->
      x1Scale = Chart.D3Bar.xScale([0, 0], 0)
      data = Chart.D3Bar.generateData(args.data.labels, args.data.datasets)
      yScale = Chart.D3Bar.yScale(data, 0)
      actual = instance.renderBarBorder(0, x1Scale, yScale, 0)
      expect(actual).to.be.an Array

  describe '::updateStyleBasedOnOptions', ->
    it 'should return an array', ->
      actual = instance.updateStyleBasedOnOptions({})
      expect(actual).to.be.an Array

  describe '::transitBar', ->
    it 'should return an array', ->
      el = instance.getRootElement()
      data = Chart.D3Bar.generateData(args.data.labels, args.data.datasets)
      yScale = Chart.D3Bar.yScale(data, 0)
      actual = instance.transitBar(el, 0, yScale)
      expect(actual).to.be.an Array
      expect(actual).to.have.length 1

  describe '::transitBarBorder', ->
    it 'should return an array', ->
      el = instance.getRootElement()
      actual = instance.transitBarBorder(el, 0)
      expect(actual).to.be.an Array
      expect(actual).to.have.length 1
