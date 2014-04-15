describe 'Chart.D3Chart', ->
  'use strict'

  before ->
    @d3Chart = new Chart.D3Chart('#svg', [], {})

  describe '::constructor', ->
    it 'should have same values in properties', ->
      expect(@d3Chart.selectors).to.be('#svg')
      expect(@d3Chart.data).to.eql([])
      expect(@d3Chart.options).to.eql({})

  describe '::attrTranslateToCenter', ->
    it "should return String of 'translate' attribute", ->
      actual = @d3Chart.attrTranslateToCenter()
      expect(actual).to.be('translate(300, 225)')

  describe '::defineRootElement', ->
    it 'pending'

  describe '::duration', ->
    it 'should return Number', ->
      options = animationSteps: 100
      expect(@d3Chart.duration(options)).to.be(1733.2999999999997)

  describe '::getRootElement', ->
    it 'should return the same id of element', ->
      element = @d3Chart.getRootElement()
      expect(element.attr('id')).to.be('svg')

  describe '::getRootElementHeight', ->
    it 'should return the height of element', ->
      actual = @d3Chart.getRootElementHeight()
      expect(actual).to.be(450)

  describe '::getRootElementWidth', ->
    it 'should return the width of element', ->
      actual = @d3Chart.getRootElementWidth()
      expect(actual).to.be(600)
