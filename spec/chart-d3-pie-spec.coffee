describe 'Chart.D3Pie', ->
  before ->
    @d3Pie = new Chart.D3Pie '#svg', [], {}

  describe '::constructor', ->
    it 'should the instance object has same value in properties', ->
      expect(@d3Pie.selectors).to.eq '#svg'
      expect(@d3Pie.data).to.eql []
      expect(@d3Pie.options).to.eql {}
