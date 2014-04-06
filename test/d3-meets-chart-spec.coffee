{Chart} = require '../src/d3-meets-chart'

chai = require 'chai'
expect = chai.expect
_ = require 'underscore'

describe 'Chart', ->
  describe '::constructor', ->

    context 'when an argument is invalid', ->
      it 'should raise TypeError exception', ->
        message = 'This argument is not a selector string'
        expect(-> new Chart(null)).to.throw TypeError, message

    context 'when an argument is valid', ->
      it 'should contains the element name in the returned object', ->
        chart = new Chart '#root-svg'
        expect(chart.selector).to.eq '#root-svg'

  describe '::Doughnut', ->
    it 'pending'

  describe '::getEasingType', ->
    before ->
      @chart = new Chart '#svg'
      @errorMessage = (easingType) ->
        "'#{easingType}' is not a easing type name"

    context 'when an argument is invalid', ->
      context 'when an argument is string', ->
        it 'should raise ReferenceError exception', ->
          expect(=> @chart.getEasingType('foo')).to
            .throw ReferenceError, @errorMessage 'foo'

      context 'when an argument is not string', ->
        it 'should raise ReferenceError exception', ->
          expect(=> @chart.getEasingType(null)).to
            .throw ReferenceError, @errorMessage 'null'

    context 'when an argument is valid', ->
      it 'should returns the easing type name', ->
        expect(@chart.getEasingType('easeInExpo')).to.eq 'exp-in'

  describe '::mergeOptions', ->
    before ->
      @chart = new Chart '#svg'
      @defaults = foo: 'foo', animationEasing: 'easeInExpo'

    context 'when arguments are invalid', ->
      it 'should returns the defaults object', ->
        options = null
        expect(@chart.mergeOptions(@defaults, options)).to
          .eql foo: 'foo', animationEasing: 'exp-in'

    context 'when arguments are valid', ->
      it 'should returns the merged object', ->
        options = foo: 'bar'
        expect(@chart.mergeOptions(@defaults, options)).to
          .eql foo: 'bar', animationEasing: 'exp-in'

describe 'Chart.D3Doughnut', ->
  before ->
    @d3doughnut = new Chart.D3Doughnut '#svg', [], {}

  describe '::constructor', ->
    it 'pending'

  describe '::animateRotate', ->
    it 'pending'

  describe '::animateScale', ->
    it 'pending'

  describe '::attrSegmentStroke', ->
    it 'pending'

  describe '::drawChart', ->
    it 'pending'

  describe '::duration', ->
    it 'should returns number', ->
      options = animationSteps: 100
      expect(@d3doughnut.duration(options)).to.eq 1733.2999999999997

  describe '::render', ->
    it 'pending'

  describe '::rootSvg', ->
    it 'pending'

  describe '::rootSvgHeight', ->
    it 'pending'

  describe '::rootSvgWidth', ->
    it 'pending'

  describe '::setAnimationComplete', ->
    context 'when an argument is invalid', ->
      it 'should returns undefined', ->
        options = {}
        expect(@d3doughnut.setAnimationComplete(options)).to.be.undefined

    context 'when an argument is valid', ->
      before ->
        @options = onAnimationComplete: -> 'foo'

      context 'when all of options are true value', ->
        it 'should returns 2', ->
          options = animation: true, animateRotate: true, animateScale: true
          options = _.extend {}, @options, options
          expect(@d3doughnut.setAnimationComplete(options)).to.eq 2

      context 'when `animation` is true value', ->
        context 'when any one of `animateRotate` or `animateScale` are true value', ->
          it 'should returns 1', ->
            options = animation: true, animateRotate: true, animateScale: false
            options = _.extend {}, @options, options
            expect(@d3doughnut.setAnimationComplete(options)).to.eq 1

          it 'should returns 1', ->
            options = animation: true, animateRotate: false, animateScale: true
            options = _.extend {}, @options, options
            expect(@d3doughnut.setAnimationComplete(options)).to.eq 1

      context 'when `animation` is false value', ->
        it 'should returns NaN', ->
          options = animation: false, animateRotate: true, animateScale: true
          options = _.extend {}, @options, options
          actual = @d3doughnut.setAnimationComplete(options)
          expect(isNaN(actual)).to.be.true

  describe '::transitionEndAll', ->
    it 'pending'

  describe '::translateToCenter', ->
    it 'pending'
