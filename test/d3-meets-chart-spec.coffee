{Chart} = require '../src/d3-meets-chart'

chai = require 'chai'
expect = chai.expect

describe 'Chart', ->
  describe '::constructor', ->
    context 'when an argument is valid', ->
      it 'should contains the element name in the returned object', ->
        chart = new Chart '#root-svg'
        expect(chart.selector).to.eq '#root-svg'

    context 'when an argument is invalid', ->
      it 'should raise TypeError exception', ->
        message = 'This argument is not a selector string'
        expect(-> new Chart(null)).to.throw TypeError, message

  describe '::Doughnut', ->
    it 'pending'

  describe '::getEasingType', ->
    before ->
      @chart = new Chart '#svg'
      @errorMessage = (easingType) ->
        "'#{easingType}' is not a easing type name"

    context 'when an argument is valid', ->
      it 'should returns the easing type name', ->
        expect(@chart.getEasingType('easeInExpo')).to.eq 'exp-in'

    context 'when an argument is invalid', ->
      context 'when an argument is string', ->
        it 'should raise ReferenceError exception', ->
          expect(=> @chart.getEasingType('foo')).to
            .throw ReferenceError, @errorMessage 'foo'

      context 'when an argument is not string', ->
        it 'should raise ReferenceError exception', ->
          expect(=> @chart.getEasingType(null)).to
            .throw ReferenceError, @errorMessage 'null'

  describe '::mergeOptions', ->
    before ->
      @chart = new Chart '#svg'
      @defaults = foo: 'foo', animationEasing: 'easeInExpo'

    context 'when arguments are valid', ->
      it 'should returns the merged object', ->
        options = foo: 'bar'
        expect(@chart.mergeOptions(@defaults, options)).to
          .eql foo: 'bar', animationEasing: 'exp-in'

    context 'when arguments are invalid', ->
      it 'should returns the defaults object', ->
        options = null
        expect(@chart.mergeOptions(@defaults, options)).to
          .eql foo: 'foo', animationEasing: 'exp-in'

describe 'Chart.D3Doughnut', ->
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
      options = {}
      options.animationSteps = 100
      d3doughnut = new Chart.D3Doughnut('#svg', [], options)
      expect(d3doughnut.duration(options)).to.eq 1733.2999999999997

  describe '::render', ->
    it 'pending'

  describe '::rootSvg', ->
    it 'pending'

  describe '::rootSvgHeight', ->
    it 'pending'

  describe '::rootSvgWidth', ->
    it 'pending'

  describe '::setAnimationComplete', ->
    it 'pending'

  describe '::transitionEndAll', ->
    it 'pending'

  describe '::translateToCenter', ->
    it 'pending'
