describe 'Chart.D3Chart', ->
  before ->
    @d3Chart = new Chart.D3Chart '#svg', [], {}

  describe '::constructor', ->
    it 'should the instance object has same value in properties', ->
      expect(@d3Chart.selectors).to.eq '#svg'
      expect(@d3Chart.data).to.eql []
      expect(@d3Chart.options).to.eql {}

  describe '::attrTranslateToCenter', ->
    it "should returns the string of 'translate' attribute", ->
      actual = @d3Chart.attrTranslateToCenter()
      expect(actual).to.eq 'translate(225, 200)'

  describe '::duration', ->
    it 'should returns number', ->
      options = animationSteps: 100
      expect(@d3Chart.duration(options)).to.eq 1733.2999999999997

  describe '::getRootElement', ->
    it 'should returns the root D3 object', ->
      element = @d3Chart.getRootElement()
      expect(element.attr('id')).to.eq 'svg'

  describe '::getRootElementHeight', ->
    it 'should returns the root D3 object height', ->
      actual = @d3Chart.getRootElementHeight()
      expect(actual).to.eq 400

  describe '::getRootElementWidth', ->
    it 'should returns the root D3 object width', ->
      actual = @d3Chart.getRootElementWidth()
      expect(actual).to.eq 450
