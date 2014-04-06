describe 'Chart.D3Bar', ->
  before ->
    @d3Bar = new Chart.D3Bar '#svg', [], {}

  describe '::constructor', ->
    it 'should the instance object has same value in properties', ->
      expect(@d3Bar.selectors).to.eq '#svg'
      expect(@d3Bar.data).to.eql []
      expect(@d3Bar.options).to.eql {}

  describe '::Bar', ->
    it 'pending'
