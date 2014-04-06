describe 'Chart.D3Chart', ->
  before ->
    @d3Chart = new Chart.D3Chart '#svg', [], {}

  describe '::constructor', ->
    it 'should the instance object has same value in properties', ->
      expect(@d3Chart.selectors).to.eq '#svg'
      expect(@d3Chart.data).to.eql []
      expect(@d3Chart.options).to.eql {}

  describe '::getRootElement', ->
    it 'should returns the root D3 object', ->
      actual = @d3Chart.getRootElement()
      expect(actual.attr('id')).to.eq 'svg'
