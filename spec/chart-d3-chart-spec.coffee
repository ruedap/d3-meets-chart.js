describe 'Chart.D3Chart', ->
  'use strict'

  instance = undefined

  before ->
    instance = new Chart.D3Chart('#svg', [], {})

  after ->
    instance = null

  describe '.xAxis', ->
    it 'should return a function', ->
      actual = Chart.D3Chart.xAxis(d3.scale.ordinal())
      expect(actual).to.be.a('function')

  describe '.yAxis', ->
    it 'should return a function', ->
      actual = Chart.D3Chart.yAxis(d3.scale.ordinal())
      expect(actual).to.be.a('function')

  describe '.xScale', ->
    it 'should return a function', ->
      actual = Chart.D3Chart.xScale([0, 0], 0)
      expect(actual).to.be.a('function')

  describe '.yScale', ->
    it 'should return a function', ->
      actual = Chart.D3Chart.yScale([], 0)
      expect(actual).to.be.a('function')

  describe '::constructor', ->
    it 'should have same values in properties', ->
      expect(instance.selectors).to.be('#svg')
      expect(instance.data).to.eql([])
      expect(instance.options).to.eql({})

  describe '::attrTranslateToCenter', ->
    it "should return String of 'translate' attribute", ->
      actual = instance.attrTranslateToCenter()
      expect(actual).to.be('translate(300, 225)')

  describe '::defineRootElement', ->
    it 'pending'

  describe '::duration', ->
    it 'should return Number', ->
      options = animationSteps: 100
      expect(instance.duration(options)).to.be(1733.2999999999997)

  describe '::getRootElement', ->
    it 'should return the same id of element', ->
      element = instance.getRootElement()
      expect(element.attr('id')).to.be('svg')

  describe '::getRootElementHeight', ->
    it 'should return the height of element', ->
      actual = instance.getRootElementHeight()
      expect(actual).to.be(450)

  describe '::getRootElementWidth', ->
    it 'should return the width of element', ->
      actual = instance.getRootElementWidth()
      expect(actual).to.be(600)

  describe '::renderXGrid', ->
    it 'should return an array', ->
      x0Scale = Chart.D3Chart.xScale([0, 0], 0)
      actual = instance.renderXGrid(x0Scale, 0)
      expect(actual).to.be.an(Array)
      expect(actual).to.have.length(1)

  describe '::renderYGrid', ->
    it 'should return an array', ->
      yScale = Chart.D3Chart.yScale([], 0)
      actual = instance.renderYGrid(yScale, 0)
      expect(actual).to.be.an(Array)
      expect(actual).to.have.length(1)

  describe '::renderGrid', ->
    it 'should return an array', ->
      actual = instance.renderGrid()
      expect(actual).to.be.an(Array)
      expect(actual).to.have.length(2)

  describe '::renderXAxis', ->
    it 'should return an array', ->
      x0Scale = Chart.D3Chart.xScale([0, 0], 0)
      actual = instance.renderXAxis(x0Scale, 0)
      expect(actual).to.be.an(Array)

  describe '::renderYAxis', ->
    it 'should return an array', ->
      yScale = Chart.D3Chart.yScale([], 0)
      actual = instance.renderYAxis(yScale)
      expect(actual).to.be.an(Array)

  describe '::updateGridTickStyle', ->
    it 'should return an array', ->
      actual = instance.updateGridTickStyle(instance.options)
      expect(actual).to.be.an(Array)
      expect(actual).to.have.length(1)

  describe '::updateScaleStrokeStyle', ->
    it 'should return an array', ->
      actual = instance.updateScaleStrokeStyle(instance.options)
      expect(actual).to.be.an(Array)
      expect(actual).to.have.length(2)

  describe '::updateScaleTextStyle', ->
    it 'should return an array', ->
      actual = instance.updateScaleTextStyle(instance.options)
      expect(actual).to.be.an(Array)
      expect(actual).to.have.length(1)
