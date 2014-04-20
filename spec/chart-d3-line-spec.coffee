describe 'Chart.D3Line', ->
  'use strict'

  args = {}
  instance = undefined

  before ->
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
    instance = new Chart.D3Line('#svg', args.data, args.options)

  after ->
    args = {}
    instance = null

  describe '.area', ->
    it 'should return a function', ->
      xScale = Chart.D3Line.xScale([0, 0], 0)
      yScale = Chart.D3Line.yScale([], 0)
      actual = Chart.D3Line.area(xScale, yScale, args.data.labels, 0)
      expect(actual).to.be.a('function')

  describe '.line', ->
    it 'should return a function', ->
      xScale = Chart.D3Line.xScale([0, 0], 0)
      yScale = Chart.D3Line.yScale([], 0)
      actual = Chart.D3Line.line(xScale, yScale, args.data.labels)
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

  describe '::renderAreas', ->
    it 'should return an array', ->
      xScale = Chart.D3Line.xScale([0, 0], 0)
      yScale = Chart.D3Line.yScale([], 0)
      actual = instance.renderAreas([], [], xScale, yScale, 0, {})
      expect(actual).to.be.an(Array)

  describe '::renderLines', ->
    it 'should return an array', ->
      xScale = Chart.D3Line.xScale([0, 0], 0)
      yScale = Chart.D3Line.yScale([], 0)
      line = Chart.D3Line.line(xScale, yScale, {})
      actual = instance.renderLines(line, {}, {})
      expect(actual).to.be.an(Array)
