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

  describe '::getTransitionElement', ->
    it 'should return an array', ->
      options = animationEasing: 'easeOutQuad'
      actual = instance.getTransitionElement(100, options)
      expect(actual).to.be.an(Array)
      expect(actual).to.have.length(1)

  describe '::renderXGrid', ->
    it 'should return an array', ->
      xScale = d3.scale.ordinal().domain(d3.range(2))
      actual = instance.renderXGrid(xScale, 0)
      expect(actual).to.be.an(Array)
      expect(actual).to.have.length(1)

  describe '::renderYGrid', ->
    it 'should return an array', ->
      yScale = d3.scale.ordinal().domain(d3.range(2))
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
      xScale = d3.scale.ordinal().domain(d3.range(2))
      actual = instance.renderXAxis(xScale, 0)
      expect(actual).to.be.an(Array)

  describe '::renderYAxis', ->
    it 'should return an array', ->
      yScale = d3.scale.ordinal().domain(d3.range(2))
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
