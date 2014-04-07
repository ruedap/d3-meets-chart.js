describe 'Chart', ->
  'use strict'

  # TODO: move
  it 'should return same attributes', ->
    svg = d3.select('#svg')
    expect(svg.attr('id')).to.be 'svg'
    expect(svg.attr('width')).to.be '600'
    expect(svg.attr('height')).to.be '450'

  describe '::constructor', ->
    context 'when an argument is invalid', ->
      it 'should raise a exception', ->
        expect(-> new Chart(null)).to.throwError()

    context 'when an argument is valid', ->
      it 'should return the same selector', ->
        chart = new Chart '#svg'
        expect(chart.selectors).to.be '#svg'

  describe '::Doughnut', ->
    it 'should return the same constructor name', ->
      doughnut = new Chart('#svg').Doughnut([])
      expect(doughnut.constructor.name).to.be 'D3Doughnut'

    describe '.defaults', ->
      it 'should have not same values as arguments', ->
        options = animation: false
        chart = new Chart('#svg')
        doughnut = chart.Doughnut([], options)
        expect(chart.Doughnut.defaults.animation).to.be.ok()
        expect(doughnut.options.animation).not.to.be.ok()

  describe '::Pie', ->
    it 'should return the same constructor name', ->
      pie = new Chart('#svg').Pie([])
      expect(pie.constructor.name).to.be 'D3Pie'

    describe '.defaults', ->
      it 'should have not same values as arguments', ->
        options = animation: false
        chart = new Chart('#svg')
        pie = chart.Pie([], options)
        expect(chart.Pie.defaults.animation).to.be.ok()
        expect(pie.options.animation).not.to.be.ok()

  describe '::getEasingType', ->
    before -> @chart = new Chart '#svg'

    context 'when an argument is invalid', ->
      context 'when an argument is String', ->
        it 'should raise a exception', ->
          expect(=> @chart.getEasingType('foo')).to.throwError()

      context 'when an argument is not String', ->
        it 'should raise a exception', ->
          expect(=> @chart.getEasingType(null)).to.throwError()

    context 'when an argument is valid', ->
      it 'should return the easing type name', ->
        expect(@chart.getEasingType('easeInExpo')).to.be 'exp-in'

  describe '::mergeOptions', ->
    before ->
      @chart = new Chart '#svg'
      @defaults = foo: 'foo', animationEasing: 'easeInExpo'

    context 'when arguments are invalid', ->
      it 'should return the defaults Object', ->
        options = null
        expect(@chart.mergeOptions(@defaults, options)).to
          .eql foo: 'foo', animationEasing: 'exp-in'

    context 'when arguments are valid', ->
      it 'should return the merged Object', ->
        options = foo: 'bar'
        expect(@chart.mergeOptions(@defaults, options)).to
          .eql foo: 'bar', animationEasing: 'exp-in'

  describe '::validateData', ->
    context 'when an argument is invalid', ->
      it 'should raise a exception', ->
        data = null
        expect(-> new Chart('#svg').validateData(data)).to.throwError()

    context 'when an argument is valid', ->
      it 'should not raise a exception', ->
        data = []
        expect(-> new Chart('#svg').validateData(data)).not.to.throwError()
