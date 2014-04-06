describe 'Chart.D3Doughnut', ->
  before ->
    @data = [
      value: 30
      color: '#F7464A'
    ,
      value: 50
      color: '#46BFBD'
    ,
      value: 100
      color: '#FDB45C'
    ,
      value: 40
      color: '#949FB1'
    ,
      value: 120
      color: '#4D5360'
    ]
    @d3Doughnut = new Chart.D3Doughnut '#svg', @data, {}

  describe '::constructor', ->
    it 'should the instance object has same value in properties', ->
      expect(@d3Doughnut.selectors).to.eq '#svg'
      expect(@d3Doughnut.data).to.eql @data
      expect(@d3Doughnut.options).to.eql {}

  describe '::getInnerRadius', ->
    it 'should returns Integer value', ->
      options = percentageInnerCutout: 50.2
      actual = @d3Doughnut.getInnerRadius 195, options
      expect(actual).to.eq 97
