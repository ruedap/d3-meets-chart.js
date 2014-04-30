describe 'Chart.D3Pie', ->
  'use strict'

  args = {}
  instance = null
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
    arc = null

  describe '::constructor', ->
    it 'should have same values in properties', ->
      expect(instance.selectors).to.be('#svg')
      expect(instance.data).to.be(args.data)
      expect(instance.options).to.eql({})

  describe '::attrSegmentStroke', ->
    it 'pending'

  describe '::getOuterRadius', ->
    it 'should return a Number', ->
      actual = instance.getOuterRadius(450, 400.5, 5)
      expect(actual).to.be(195)

  describe '::getInnerRadius', ->
    it 'should return 0', ->
      actual = instance.getInnerRadius(195, args.options)
      expect(actual).to.be(0)

  describe '::render', ->
    it 'pending'

  describe '::renderPie', ->
    it 'should return an array', ->
      actual = instance.renderPie(args.data, args.options)
      expect(actual).to.be.an(Array)

  describe '::renderPiePath', ->
    it 'should return an array', ->
      sl = instance.renderPie(args.data, args.options)
      actual = instance.renderPiePath(sl, arc)
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

  describe '::transitionEndAll', ->
    it 'pending'
