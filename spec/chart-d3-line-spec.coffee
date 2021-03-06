describe 'Chart.D3Line', ->
  'use strict'

  args = {}
  instance = null
  xScale = null
  yScale = null

  beforeEach ->
    args.data =
      labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July']
      datasets: [
        fillColor: 'rgba(220,220,220,0.5)'
        strokeColor: 'rgba(220,220,220,1)'
        pointColor: 'rgba(220,220,220,1)'
        pointStrokeColor: '#fff'
        data: [65, 59, 90, 81, 56, 55, 40]
      ,
        fillColor: 'rgba(151,187,205,0.5)'
        strokeColor: 'rgba(151,187,205,1)'
        pointColor: 'rgba(151,187,205,1)'
        pointStrokeColor: '#fff'
        data: [28, 48, 40, 19, 96, 27, 100]
      ]
    args.options =
      animationSteps: 60
      animationEasing: 'easeOutQuad'
      bezierCurve: true
      pointDot: true
      datasetStroke: true
      datasetFill: true
    instance = new Chart.D3Line('#svg', args.data, args.options)
    xScale = Chart.D3Line.xScale([0, 0], 0)
    yScale = Chart.D3Line.yScale([], 0)

  afterEach ->
    args = {}
    instance = null
    xScale = null
    yScale = null

  describe '.area', ->
    it 'should return a function', ->
      actual = Chart.D3Line.area(
        xScale, yScale, args.data.labels, args.options, 0
      )
      expect(actual).to.be.a('function')

  describe '.bezierCurve', ->
    it 'should return a string', ->
      actual = Chart.D3Line.bezierCurve([[0, 100], [100, 250]])
      expect(actual).to.be('0 100 C 50 100 50 250 100 250')

  describe '.line', ->
    it 'should return a function', ->
      actual = Chart.D3Line.line(xScale, yScale, args.data.labels, args.options)
      expect(actual).to.be.a('function')

  describe '.xScale', ->
    it 'should return a function', ->
      actual = Chart.D3Line.xScale([0, 0], 0)
      expect(actual).to.be.a('function')

  describe '.yScale', ->
    it 'should return a function', ->
      actual = Chart.D3Line.yScale([], 0)
      expect(actual).to.be.a('function')

  describe '::constructor', ->
    it 'should have same values in properties', ->
      expect(instance.selectors).to.be('#svg')
      expect(instance.data).to.eql(args.data)
      expect(instance.options).to.have.key('animationSteps')

  describe '::render', ->
    xit 'should return a Chart.D3Line object', ->
      actual = instance.render()
      expect(actual).to.be.a(Chart.D3Line)

  describe '::renderLinesGroup', ->
    it 'should return an array', ->
      actual = instance.renderLinesGroup(args.data)
      expect(actual).to.be.an(Array)

  describe '::renderAreas', ->
    context 'when options.datasetFill is true', ->
      it 'should return an array', ->
        args.options.datasetFill = true
        area = Chart.D3Line.area(xScale, yScale, args.data.labels, 0)
        actual = instance.renderAreas(area, args.data, args.options)
        expect(actual).to.be.an(Array)

    context 'when options.datasetFill is true', ->
      it 'should return a null', ->
        args.options.datasetFill = false
        area = Chart.D3Line.area(xScale, yScale, args.data.labels, 0)
        actual = instance.renderAreas(area, args.data, args.options)
        expect(actual).to.be(null)

  describe '::renderDots', ->
    context 'when options.pointDot is true', ->
      it 'should return an array', ->
        args.options.pointDot = true
        actual = instance.renderDots(
          args.data.datasets, args.data.labels, xScale, yScale, args.options
        )
        expect(actual).to.be.an(Array)

    context 'when options.pointDot is false', ->
      it 'should return a null', ->
        args.options.pointDot = false
        actual = instance.renderDots(
          args.data.datasets, args.data.labels, xScale, yScale, args.options
        )
        expect(actual).to.be(null)

  describe '::renderLines', ->
    it 'should return an array', ->
      line = Chart.D3Line.line(xScale, yScale, args.data.labels, args.options)
      actual = instance.renderLines(line, args.data, args.options)
      expect(actual).to.be.an(Array)

  describe '::transitAreas', ->
    it 'should return an array', ->
      el = instance.getBaseSelection()
      actual = instance.transitAreas(el, 0)
      expect(actual).to.be.an(Array)
      expect(actual).to.have.length(1)

  describe '::transitDots', ->
    it 'should return an array', ->
      el = instance.getBaseSelection()
      actual = instance.transitDots(el, 0)
      expect(actual).to.be.an(Array)
      expect(actual).to.have.length(1)

  describe '::transitLines', ->
    it 'should return an array', ->
      el = instance.getBaseSelection()
      actual = instance.transitLines(el, 0)
      expect(actual).to.be.an(Array)
      expect(actual).to.have.length(1)
