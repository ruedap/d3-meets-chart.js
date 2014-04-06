describe 'Chart.D3Doughnut', ->
  before ->
    @d3Doughnut = new Chart.D3Doughnut '#svg', [], {}

  describe '::constructor', ->
    it 'pending'

  describe '::getInnerRadius', ->
    it 'should returns Integer value', ->
      options = percentageInnerCutout: 50.2
      actual = @d3Doughnut.getInnerRadius 195, options
      expect(actual).to.eq 97
