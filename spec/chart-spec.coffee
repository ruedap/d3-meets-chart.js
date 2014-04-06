describe 'Chart', ->
  it 'should the D3 object has same properties', ->
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
      doughnut = new Chart('#svg').Doughnut([])
      expect(doughnut.constructor.name).to.eq 'D3Doughnut'

    describe '.defaults', ->
      it 'should `defaults` properties has not same values as arguments', ->
        options = animation: false
        chart = new Chart('#svg')
        doughnut = chart.Doughnut([], options)
        expect(chart.Doughnut.defaults.animation).to.not.be.false
        expect(doughnut.options.animation).to.be.false

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
