describe 'Chart.D3Pie', ->
  before ->
    @data = [
      value: 30
      color: '#f38630'
    ,
      value: 50
      color: '#e0e4cc'
    ,
      value: 100
      color: '#69d2e7'
    ]
    @d3Pie = new Chart.D3Pie '#svg', @data, {}

  describe '::constructor', ->
    it 'should the instance object has same value in properties', ->
      expect(@d3Pie.selectors).to.be '#svg'
      expect(@d3Pie.data).to.be @data
      expect(@d3Pie.options).to.eql {}

  describe '::animateRotate', ->
    it 'pending'

  describe '::animateScale', ->
    it 'pending'

  describe '::attrSegmentStroke', ->
    it 'pending'

  describe '::drawChart', ->
    it 'pending'

  describe '::getOuterRadius', ->
    it 'should returns Integer value', ->
      actual = @d3Pie.getOuterRadius 450, 400.5, 5
      expect(actual).to.be 195

  describe '::getInnerRadius', ->
    it 'should returns zero', ->
      options = percentageInnerCutout: 50.2
      actual = @d3Pie.getInnerRadius 195, options
      expect(actual).to.be 0

  describe '::render', ->
    it 'pending'

  describe '::setAnimationComplete', ->
    context 'when an argument is invalid', ->
      it 'should returns Infinity', ->
        options = {}
        expect(@d3Pie.setAnimationComplete(options)).to.be Infinity

    context 'when an argument is valid', ->
      before ->
        @options = onAnimationComplete: -> 'foo'

      context 'when all of options are true value', ->
        it 'should returns 2', ->
          options = animation: true, animateRotate: true, animateScale: true
          options = _.extend {}, @options, options
          expect(@d3Pie.setAnimationComplete(options)).to.be 2

      context 'when `animation` is true value', ->
        context 'when any one of `animateRotate` or `animateScale` are true value', ->
          it 'should returns 1', ->
            options = animation: true, animateRotate: true, animateScale: false
            options = _.extend {}, @options, options
            expect(@d3Pie.setAnimationComplete(options)).to.be 1

          it 'should returns 1', ->
            options = animation: true, animateRotate: false, animateScale: true
            options = _.extend {}, @options, options
            expect(@d3Pie.setAnimationComplete(options)).to.be 1

      context 'when `animation` is false value', ->
        it 'should returns NaN', ->
          options = animation: false, animateRotate: true, animateScale: true
          options = _.extend {}, @options, options
          actual = @d3Pie.setAnimationComplete(options)
          expect(isNaN(actual)).to.be.ok

  describe '::transitionEndAll', ->
    it 'pending'
