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

  describe '::render', ->
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
