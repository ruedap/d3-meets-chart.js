{Chart} = require '../d3-meets-chart'

global._ = require 'underscore'
global.d3 = require 'd3'

expect = require('chai').expect

describe 'Chart', ->
  before ->
    d3.select('body')
      .append('svg')
      .attr
        id: 'svg'
        width: 450
        height: 400

  it 'should the element has same properties', ->
    svg = d3.select('#svg')
    expect(svg.attr('id')).to.eq 'svg'
    expect(svg.attr('width')).to.eq '450'
    expect(svg.attr('height')).to.eq '400'

  describe '::constructor', ->
    context 'when an argument is invalid', ->
      it 'should raise TypeError exception', ->
        message = 'This argument is not selectors string'
        expect(-> new Chart(null)).to.throw TypeError, message

    context 'when an argument is valid', ->
      it 'should contains the element name in the returned object', ->
        chart = new Chart '#svg'
        expect(chart.selectors).to.eq '#svg'

  describe '::Doughnut', ->
    it 'should returns the Chart.D3Doughnut object', ->
      data = []
      doughnut = new Chart('#svg').Doughnut(data)
      expect(doughnut.constructor.name).to.eq 'D3Doughnut'

  describe '::Pie', ->
    it 'should returns the Chart.D3Pie object', ->
      data = []
      pie = new Chart('#svg').Pie(data)
      expect(pie.constructor.name).to.eq 'D3Pie'

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

  describe '::validateData', ->
    context 'when an argument is invalid', ->
      it 'should raise TypeError exception', ->
        data = null
        message = "#{data} is not an array"
        expect(-> new Chart('#svg').validateData(data)).to
          .throw TypeError, message

    context 'when an argument is valid', ->
      it 'should not raise TypeError exception', ->
        data = []
        message = "#{data} is not an array"
        expect(-> new Chart('#svg').validateData(data)).to
          .not.throw new TypeError message

describe 'Chart.D3Doughnut', ->
  before ->
    @d3Doughnut = new Chart.D3Doughnut '#svg', [], {}

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
      expect(@d3Doughnut.duration(options)).to.eq 1733.2999999999997

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
      it 'should returns Infinity', ->
        options = {}
        expect(@d3Doughnut.setAnimationComplete(options)).to.eq Infinity

    context 'when an argument is valid', ->
      before ->
        @options = onAnimationComplete: -> 'foo'

      context 'when all of options are true value', ->
        it 'should returns 2', ->
          options = animation: true, animateRotate: true, animateScale: true
          options = _.extend {}, @options, options
          expect(@d3Doughnut.setAnimationComplete(options)).to.eq 2

      context 'when `animation` is true value', ->
        context 'when any one of `animateRotate` or `animateScale` are true value', ->
          it 'should returns 1', ->
            options = animation: true, animateRotate: true, animateScale: false
            options = _.extend {}, @options, options
            expect(@d3Doughnut.setAnimationComplete(options)).to.eq 1

          it 'should returns 1', ->
            options = animation: true, animateRotate: false, animateScale: true
            options = _.extend {}, @options, options
            expect(@d3Doughnut.setAnimationComplete(options)).to.eq 1

      context 'when `animation` is false value', ->
        it 'should returns NaN', ->
          options = animation: false, animateRotate: true, animateScale: true
          options = _.extend {}, @options, options
          actual = @d3Doughnut.setAnimationComplete(options)
          expect(isNaN(actual)).to.be.true

  describe '::transitionEndAll', ->
    it 'pending'

  describe '::translateToCenter', ->
    it 'pending'

describe 'Chart.D3Pie', ->
  before ->
    @d3Pie = new Chart.D3Pie '#svg', [], {}

  describe '::constructor', ->
    it 'should the instance object has same value in properties', ->
      expect(@d3Pie.selectors).to.eq '#svg'
      expect(@d3Pie.data).to.eql []
      expect(@d3Pie.options).to.eql {}
