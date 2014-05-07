describe 'Chart.D3Chart', ->
  'use strict'

  instance = null
  xScale = null
  yScale = null

  beforeEach ->
    instance = new Chart.D3Chart('#svg', [], {})
    xScale = d3.scale.ordinal().domain(d3.range(2))
    yScale = d3.scale.ordinal().domain(d3.range(2))

  afterEach ->
    instance = null
    xScale = null
    yScale = null

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
    it 'should return a string of `translate` attribute', ->
      actual = instance.attrTranslateToCenter()
      expect(actual).to.be('translate(300, 225)')

  describe '::classedName', ->
    it 'should return a string', ->
      actual = instance.classedName('foo-bar')
      expect(actual).to.be('d3mc-foo-bar')

  describe '::className', ->
    it 'should return a string', ->
      actual = instance.className('foo-bar')
      expect(actual).to.be('.d3mc-foo-bar')

  describe '::defaultColors', ->
    it 'should return an array', ->
      actual = instance.defaultColors()
      expect(actual).to.be.an(Array)

  describe '::defineRootElement', ->
    it 'pending'

  describe '::duration', ->
    it 'should return a number', ->
      options = animationSteps: 100
      expect(instance.duration(options)).to.be(1733.2999999999997)

  describe '::getBaseSelection', ->
    it 'should return the same id of element', ->
      element = instance.getBaseSelection()
      expect(element.attr('id')).to.be('svg')

  describe '::getBaseSelectionHeight', ->
    it 'should return the height of element', ->
      actual = instance.getBaseSelectionHeight()
      expect(actual).to.be(450)

  describe '::getBaseSelectionWidth', ->
    it 'should return the width of element', ->
      actual = instance.getBaseSelectionWidth()
      expect(actual).to.be(600)

  describe '::getTransitionElement', ->
    it 'should return an array', ->
      options = animationEasing: 'easeOutQuad'
      actual = instance.getTransitionElement(100, options)
      expect(actual).to.be.an(Array)
      expect(actual).to.have.length(1)

  describe '::renderXGrid', ->
    it 'should return an array', ->
      actual = instance.renderXGrid(xScale, 0)
      expect(actual).to.be.an(Array)
      expect(actual).to.have.length(1)

  describe '::renderYGrid', ->
    it 'should return an array', ->
      actual = instance.renderYGrid(yScale, 0)
      expect(actual).to.be.an(Array)
      expect(actual).to.have.length(1)

  describe '::renderGrid', ->
    it 'should return an array', ->
      actual = instance.renderGrid()
      expect(actual).to.be.an(Array)
      expect(actual).to.have.length(0)

  describe '::renderXAxis', ->
    it 'should return an array', ->
      actual = instance.renderXAxis(xScale, 0)
      expect(actual).to.be.an(Array)

  describe '::renderYAxis', ->
    it 'should return an array', ->
      actual = instance.renderYAxis(yScale)
      expect(actual).to.be.an(Array)

  xdescribe '::setDefaultColors', ->
    context "when an argument doesn't include color property", ->
      it 'should return default colors', ->
        data = [ { value: 0 }, { value: 0 }, { value: 0 } ]
        d = instance.setDefaultColors(data)
        expect(d[0].color).to.be('#f38630')
        expect(d[1].color).to.be('#e0e4cc')
        expect(d[2].color).to.be('#69d2e7')

    context "when an argument include color property", ->
      it 'should not return default colors', ->
        data = [ { value: 0, color: '#fff' }, { value: 0 }, { value: 0, color: 'black' } ]
        d = instance.setDefaultColors(data)
        expect(d[0].color).to.be('#fff')
        expect(d[1].color).to.be('#e0e4cc')
        expect(d[2].color).to.be('black')

  describe '::updateGridTickStyle', ->
    it 'should return an array', ->
      actual = instance.updateGridTickStyle(instance.options)
      expect(actual).to.be.an(Array)
      expect(actual).to.have.length(1)

  describe '::updateScaleStrokeStyle', ->
    it 'should return an array', ->
      actual = instance.updateScaleStrokeStyle(instance.options)
      expect(actual).to.be.an(Array)
      expect(actual).to.have.length(0)

  describe '::updateScaleTextStyle', ->
    it 'should return an array', ->
      actual = instance.updateScaleTextStyle(instance.options)
      expect(actual).to.be.an(Array)
      expect(actual).to.have.length(1)
