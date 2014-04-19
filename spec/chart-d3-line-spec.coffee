describe 'Chart.D3Line', ->
  'use strict'

  args = {}
  instance = undefined

  before ->
    args.data =
      labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July']
      datasets: [
        fillColor: 'rgba(220,220,220,0.5)'
        strokeColor: 'rgba(220,220,220,1)'
        pointColor: 'rgba(220,220,220,1)'
        pointStrokeColor: '#fff'
        data: [65, 59, 90, 81, 56, 55, 40]
      ,
        fillColor: 'rgba(151,187,205,0.5)'
        strokeColor: 'rgba(151,187,205,1)'
        pointColor: 'rgba(151,187,205,1)'
        pointStrokeColor: '#fff'
        data: [28, 48, 40, 19, 96, 27, 100]
      ]
    args.options =
      animationSteps: 60
      animationEasing: 'easeOutQuad'
    instance = new Chart.D3Line('#svg', args.data, args.options)

  after ->
    args = {}
    instance = null

  describe '::constructor', ->
    it 'should have same values in properties', ->
      expect(instance.selectors).to.be('#svg')
      expect(instance.data).to.eql(args.data)
      expect(instance.options).to.have.key('animationSteps')

  describe '::generateData', ->
    context 'when arguments are invalid', ->
      it 'should return an undefined', ->
        expect(instance.generateData([], null)).to.be(undefined)
        expect(instance.generateData(null, [])).to.be(undefined)
        expect(instance.generateData(null, null)).to.be(undefined)

    context 'when arguments are valid', ->
      context 'when arguments are blank arrays', ->
        it 'should return a blank array', ->
          actual = instance.generateData([], [])
          expect(actual).to.be.an(Array)
          expect(actual).to.eql([])

      context 'when arguments are not blank arrays', ->
        it 'should return an array', ->
          actual = instance.generateData(
            args.data.labels,
            args.data.datasets
          )
          expect(actual).to.be.an(Array)

        it 'should have same values in properties', ->
          actual = instance.generateData(
            args.data.labels,
            args.data.datasets
          )
          expect(actual[0].key).to.be('January')
          values = actual[0].values[1]
          expect(values.value).to.be(28)
          expect(values.fillColor).to.be('rgba(151,187,205,0.5)')
          expect(values.strokeColor).to.be('rgba(151,187,205,1)')
          expect(values.pointColor).to.be('rgba(151,187,205,1)')
          expect(values.pointStrokeColor).to.be('#fff')

  describe '::render', ->
    xit 'should return a Chart.D3Line object', ->
      actual = instance.render()
      expect(actual).to.be.a(Chart.D3Line)
