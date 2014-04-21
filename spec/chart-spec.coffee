describe 'Chart', ->
  'use strict'

  args = {}
  instance = undefined

  beforeEach ->
    args.options = animation: false
    args.defaults = foo: 'foo', animationEasing: 'easeInExpo'
    instance = new Chart('#svg')

  afterEach ->
    args = {}
    instance = null

  # TODO: move
  it 'should return same attributes', ->
    svg = d3.select('#svg')
    expect(svg.attr('id')).to.be('svg')
    expect(svg.attr('width')).to.be('600')
    expect(svg.attr('height')).to.be('450')

  describe '::constructor', ->
    context 'when an argument is invalid', ->
      it 'should raise a exception', ->
        expect(-> new Chart(null)).to.throwError()

    context 'when an argument is valid', ->
      it 'should return the same selector', ->
        expect(instance.selectors).to.be('#svg')

  describe '::Bar', ->
    it 'should return the same constructor name', ->
      bar = instance.Bar([])
      expect(bar.constructor.name).to.be('D3Bar')

    describe '.defaults', ->
      it 'should have not same values as arguments', ->
        bar = instance.Bar([], args.options)
        expect(instance.Bar.defaults.animation).to.be.ok()
        expect(bar.options.animation).not.to.be.ok()

  describe '::Doughnut', ->
    it 'should return the same constructor name', ->
      doughnut = instance.Doughnut([])
      expect(doughnut.constructor.name).to.be('D3Doughnut')

    describe '.defaults', ->
      it 'should have not same values as arguments', ->
        doughnut = instance.Doughnut([], args.options)
        expect(instance.Doughnut.defaults.animation).to.be.ok()
        expect(doughnut.options.animation).not.to.be.ok()

  describe '::Line', ->
    it 'should return the same constructor name', ->
      line = instance.Line([])
      expect(line.constructor.name).to.be('D3Line')

    describe '.defaults', ->
      it 'should have not same values as arguments', ->
        line = instance.Line([], args.options)
        expect(instance.Line.defaults.animation).to.be.ok()
        expect(line.options.animation).not.to.be.ok()

  describe '::Pie', ->
    it 'should return the same constructor name', ->
      pie = instance.Pie([])
      expect(pie.constructor.name).to.be('D3Pie')

    describe '.defaults', ->
      it 'should have not same values as arguments', ->
        pie = instance.Pie([], args.options)
        expect(instance.Pie.defaults.animation).to.be.ok()
        expect(pie.options.animation).not.to.be.ok()

  describe '::getEasingType', ->
    context 'when an argument is invalid', ->
      context 'when an argument is String', ->
        it 'should raise a exception', ->
          expect(-> instance.getEasingType('foo')).to.throwError()

      context 'when an argument is not String', ->
        it 'should raise a exception', ->
          expect(-> instance.getEasingType(null)).to.throwError()

    context 'when an argument is valid', ->
      it 'should return the easing type name', ->
        expect(instance.getEasingType('easeInExpo')).to.be('exp-in')

  describe '::mergeOptions', ->
    context 'when arguments are invalid', ->
      it 'should return the defaults Object', ->
        expect(instance.mergeOptions(args.defaults, null)).to
          .eql(foo: 'foo', animationEasing: 'exp-in')

    context 'when arguments are valid', ->
      it 'should return the merged Object', ->
        options = foo: 'bar'
        expect(instance.mergeOptions(args.defaults, options)).to
          .eql(foo: 'bar', animationEasing: 'exp-in')

  describe '::validateData', ->
    context 'when an argument is invalid', ->
      it 'should raise a exception', ->
        expect(-> instance.validateData(null)).to.throwError()

    context 'when an argument is valid', ->
      it 'should not raise a exception', ->
        expect(-> instance.validateData([])).not.to.throwError()
