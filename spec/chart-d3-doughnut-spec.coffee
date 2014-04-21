describe 'Chart.D3Doughnut', ->
  'use strict'

  args = {}
  instance = undefined

  beforeEach ->
    args.data = [
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
    instance = new Chart.D3Doughnut('#svg', args.data, {})

  afterEach ->
    args = {}
    instance = null

  describe '::constructor', ->
    it 'should have same values in properties', ->
      expect(instance.selectors).to.be('#svg')
      expect(instance.data).to.eql(args.data)
      expect(instance.options).to.eql({})

  describe '::getInnerRadius', ->
    it 'should return Number', ->
      options = percentageInnerCutout: 50.2
      actual = instance.getInnerRadius(195, options)
      expect(actual).to.be(97)
