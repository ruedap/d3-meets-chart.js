describe 'Chart.D3Doughnut', ->
  before ->
    @d3Doughnut = new Chart.D3Doughnut '#svg', [], {}

  describe '::constructor', ->
    it 'should the instance object has same value in properties', ->
      expect(@d3Doughnut.selectors).to.eq '#svg'
      expect(@d3Doughnut.data).to.eql []
      expect(@d3Doughnut.options).to.eql {}

  describe '::getInnerRadius', ->
    it 'should returns Integer value', ->
      options = percentageInnerCutout: 50.2
      actual = @d3Doughnut.getInnerRadius 195, options
      expect(actual).to.eq 97
