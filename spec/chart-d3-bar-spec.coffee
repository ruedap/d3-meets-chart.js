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
    args.options =
      animationSteps: 60
      animationEasing: 'easeOutQuad'
    instance = new Chart.D3Bar('#svg', args.data, args.options)

  after ->
    args = {}
    instance = null

  describe '.adjustRangeBand', ->
    it 'should return a number', ->
      expect(Chart.D3Bar.adjustRangeBand(100)).to.be(99)

  describe '.rectBorderPath', ->
    it 'should return a string of `d` attribute', ->
      data = instance.generateData(args.data.labels, args.data.datasets)
      xScale = Chart.D3Bar.xScale([0, 100], 100)
      yScale = Chart.D3Bar.yScale(data, 0)
      datum = data[0].values[0]
      actual = Chart.D3Bar.rectBorderPath(datum, 0, 450, xScale, yScale, 3)
      expectation = 'M1.5,450L1.5,1.5L47.5,1.5L47.5,450'
      expect(actual).to.be(expectation)

  describe '.xScale', ->
    it 'should return a function', ->
      actual = Chart.D3Bar.xScale([0, 0], 0)
      expect(actual).to.be.a('function')

  describe '.yScale', ->
    it 'should return a function', ->
      actual = Chart.D3Bar.yScale([], 0)
      expect(actual).to.be.a('function')

  describe '::constructor', ->
    it 'should have same values in properties', ->
      expect(instance.selectors).to.be('#svg')
      expect(instance.data).to.eql(args.data)
      expect(instance.options).to.have.key('animationSteps')

  describe '::generateData', ->
    context 'when arguments are invalid', ->
      it 'should return an undefined', ->
        expect(instance.generateData([], null)).to.be(undefined)
        expect(instance.generateData(null, [])).to.be(undefined)
        expect(instance.generateData(null, null)).to.be(undefined)

    context 'when arguments are valid', ->
      context 'when arguments are blank arrays', ->
        it 'should return a blank array', ->
          actual = instance.generateData([], [])
          expect(actual).to.be.an(Array)
          expect(actual).to.eql([])

      context 'when arguments are not blank arrays', ->
        it 'should return an array', ->
          actual = instance.generateData(
            args.data.labels,
            args.data.datasets
          )
          expect(actual).to.be.an(Array)

        it 'should have same values in properties', ->
          actual = instance.generateData(
            args.data.labels,
            args.data.datasets
          )
          expect(actual[0].key).to.be('January')
          values = actual[0].values[1]
          expect(values.value).to.be(28)
          expect(values.fillColor).to.be('rgba(151,187,205,0.5)')
          expect(values.strokeColor).to.be('rgba(151,187,205,1)')

  describe '::render', ->
    xit 'should return a Chart.D3Bar object', ->
      actual = instance.render()
      expect(actual).to.be.a(Chart.D3Bar)

  describe '::renderBars', ->
    it 'should return an array', ->
      x0Scale = Chart.D3Bar.xScale([0, 0], 0)
      actual = instance.renderBars([], x0Scale)
      expect(actual).to.be.an(Array)

  describe '::renderBar', ->
    it 'should return an array', ->
      x1Scale = Chart.D3Bar.xScale([0, 0], 0)
      data = instance.generateData(args.data.labels, args.data.datasets)
      yScale = Chart.D3Bar.yScale(data, 0)
      actual = instance.renderBar(0, x1Scale, yScale)
      expect(actual).to.be.an(Array)

  describe '::renderBarBorder', ->
    it 'should return an array', ->
      x1Scale = Chart.D3Bar.xScale([0, 0], 0)
      data = instance.generateData(args.data.labels, args.data.datasets)
      yScale = Chart.D3Bar.yScale(data, 0)
      actual = instance.renderBarBorder(0, x1Scale, yScale, 0)
      expect(actual).to.be.an(Array)

  describe '::transitBar', ->
    it 'should return an array', ->
      el = instance.getRootElement()
      data = instance.generateData(args.data.labels, args.data.datasets)
      yScale = Chart.D3Bar.yScale(data, 0)
      actual = instance.transitBar(el, 0, yScale)
      expect(actual).to.be.an(Array)
      expect(actual).to.have.length(1)

  describe '::transitBarBorder', ->
    it 'should return an array', ->
      el = instance.getRootElement()
      actual = instance.transitBarBorder(el, 0)
      expect(actual).to.be.an(Array)
      expect(actual).to.have.length(1)
