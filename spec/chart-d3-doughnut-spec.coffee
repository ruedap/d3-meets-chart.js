describe 'Chart.D3Doughnut', ->
  'use strict'

  args = {}
  instance = null

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
    args.options =
      percentageInnerCutout: 50.2
      animation: true
      animateRotate: true
      animateScale: true
      animationEasing: 'easeOutBounce'
      onAnimationComplete: -> 'foo'
      segmentShowStroke: true
      segmentStrokeColor: '#fff'
      segmentStrokeWidth: 2
    instance = new Chart.D3Doughnut('#svg', args.data, {})

  afterEach ->
    args = {}
    instance = null

  describe '::constructor', ->
    it 'should have same values in properties', ->
      expect(instance.selectors).to.be('#svg')
      expect(instance.data).to.eql(args.data)
      expect(instance.options).to.eql({})

  describe '::defaultColors', ->
    it 'should return an array', ->
      actual = instance.defaultColors()
      expect(actual[0]).to.be('#f7464a')
      expect(actual.length).to.be(8)

  describe '::getInnerRadius', ->
    it 'should return Number', ->
      options = percentageInnerCutout: 50.2
      actual = instance.getInnerRadius(195, options)
      expect(actual).to.be(97)

  describe '::renderPie', ->
    it 'should return an array', ->
      actual = instance.renderPie(args.data, args.options)
      expect(actual).to.be.an(Array)

  describe '::setDefaultColors', ->
    context "when an argument doesn't include color property", ->
      it 'should return default colors', ->
        data = [ { value: 0 }, { value: 0 }, { value: 0 } ]
        d = instance.setDefaultColors(data)
        expect(d[0].color).to.be('#f7464a')
        expect(d[1].color).to.be('#46bfbd')
        expect(d[2].color).to.be('#fdb45c')

    context "when an argument include color property", ->
      it 'should not return default colors', ->
        data = [ { value: 0, color: '#fff' }, { value: 0 }, { value: 0, color: 'black' } ]
        d = instance.setDefaultColors(data)
        expect(d[0].color).to.be('#fff')
        expect(d[1].color).to.be('#46bfbd')
        expect(d[2].color).to.be('black')
