describe 'Chart.D3Pie', ->
  'use strict'

  args = {}
  instance = null
  outerRadius = null
  innerRadius = null
  arc = null

  beforeEach ->
    args.data = [
      value: 30
      color: '#f38630'
    ,
      value: 50
      color: '#e0e4cc'
    ,
      value: 100
      color: '#69d2e7'
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

    args.margin = top: 5, right: 5, bottom: 5, left: 5
    instance = new Chart.D3Pie('#svg', args.data, {})

    outerRadius = instance.getOuterRadius(
      instance.width, instance.height, args.margin.top
    )
    innerRadius = instance.getInnerRadius(outerRadius, args.options)
    arc = instance.getArc(innerRadius, outerRadius)

  afterEach ->
    args = {}
    instance = null
    outerRadius = null
    innerRadius = null
    arc = null

  describe '::attrSegmentStroke', ->
    context 'when `segmentShowStroke` is true', ->
      it 'should return a object', ->
        actual = instance.attrSegmentStroke(args.options)
        expect(actual.stroke).to.be(args.options.segmentStrokeColor)
        expect(actual['stroke-width']).to.be(args.options.segmentStrokeWidth)

    context 'when `segmentShowStroke` is false', ->
      it 'should return a object', ->
        args.options.segmentShowStroke = false
        actual = instance.attrSegmentStroke(args.options)
        expect(actual.stroke).to.be('none')
        expect(actual['stroke-width']).to.be(0)

  describe '::constructor', ->
    it 'should have same values in properties', ->
      expect(instance.selectors).to.be('#svg')
      expect(instance.data).to.be(args.data)
      expect(instance.options).to.eql({})

  describe '::defaultColors', ->
    it 'should return an array', ->
      actual = instance.defaultColors()
      expect(actual[0]).to.be('#f38630')
      expect(actual.length).to.be(8)

  describe '::getArc', ->
    it 'should return a function', ->
      actual = instance.getArc(innerRadius, outerRadius)
      expect(actual).to.be.a('function')

  describe '::getInnerRadius', ->
    it 'should return 0', ->
      actual = instance.getInnerRadius(195, args.options)
      expect(actual).to.be(0)

  describe '::getOuterRadius', ->
    it 'should return a Number', ->
      actual = instance.getOuterRadius(450, 400.5, 5)
      expect(actual).to.be(195)

  describe '::render', ->
    it 'pending'

  describe '::renderPie', ->
    it 'should return an array', ->
      actual = instance.renderPie(args.data, args.options)
      expect(actual).to.be.an(Array)

  describe '::setAnimationComplete', ->
    context 'when an argument is invalid', ->
      it 'should return Infinity', ->
        expect(instance.setAnimationComplete({})).to.be(Infinity)

    context 'when an argument is valid', ->
      context 'when all of options are true', ->
        it 'should return 2', ->
          expect(instance.setAnimationComplete(args.options)).to.be(2)

      context 'when `animation` is true', ->
        context 'when `animateRotate` is true and `animateScale` is false', ->
          it 'should return 1', ->
            args.options.animateScale = false
            expect(instance.setAnimationComplete(args.options)).to.be(1)

        context 'when `animateRotate` is false and `animateScale` is true', ->
          it 'should return 1', ->
            args.options.animateRotate = false
            expect(instance.setAnimationComplete(args.options)).to.be(1)

      context 'when `animation` is false', ->
        it 'should return NaN', ->
          args.options.animation = false
          actual = instance.setAnimationComplete(args.options)
          expect(isNaN(actual)).to.be.ok()

  describe '::setDefaultColors', ->
    context "when an argument doesn't include color property", ->
      it 'should return default colors', ->
        data = [ { value: 0 }, { value: 0 }, { value: 0 } ]
        d = instance.setDefaultColors(data)
        expect(d[0].color).to.be('#f38630')
        expect(d[1].color).to.be('#e0e4cc')
        expect(d[2].color).to.be('#69d2e7')

    context "when an argument include color property", ->
      it 'should not return default colors', ->
        data = [ { value: 0, color: '#fff' }, { value: 0 }, { value: 0, color: 'black' } ]
        d = instance.setDefaultColors(data)
        expect(d[0].color).to.be('#fff')
        expect(d[1].color).to.be('#e0e4cc')
        expect(d[2].color).to.be('black')

  describe '::transitExpansion', ->
    context 'when `animation` is false', ->
      it 'should return a null', ->
        args.options.animation = false
        actual = instance.transitExpansion(args.options)
        expect(actual).not.to.be.ok()

    context 'when `animateScale` is false', ->
      it 'should return a null', ->
        args.options.animateScale = false
        actual = instance.transitExpansion(args.options)
        expect(actual).not.to.be.ok()

    context 'when `animation` is true and `animateScale` is true', ->
      it 'should return an array', ->
        actual = instance.transitExpansion(args.options)
        expect(actual).to.be.an(Array)

  describe '::transitRotation', ->
    context 'when `animation` is false', ->
      it 'should return a null', ->
        args.options.animation = false
        sl = instance.renderPie(args.data, args.options)
        actual = instance.transitRotation(sl, arc, args.options)
        expect(actual).not.to.be.ok()

    context 'when `animateRotate` is false', ->
      it 'should return a null', ->
        args.options.animateRotate = false
        sl = instance.renderPie(args.data, args.options)
        actual = instance.transitRotation(sl, arc, args.options)
        expect(actual).not.to.be.ok()

    context 'when `animation` is true and `animateRotate` is true', ->
      it 'should return an array', ->
        sl = instance.renderPie(args.data, args.options)
        actual = instance.transitRotation(sl, arc, args.options)
        expect(actual).to.be.an(Array)

  describe '::transitionEndAll', ->
    it 'pending'
