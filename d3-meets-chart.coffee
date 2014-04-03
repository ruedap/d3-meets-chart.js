class Chart
  constructor: (@element) ->

  Doughnut: (data, options) ->
    @Doughnut.defaults =
      segmentShowStroke: true
      segmentStrokeColor: '#fff'
      segmentStrokeWidth: 2
      percentageInnerCutout: 50
      animation: true
      animationSteps: 100
      animationEasing: 'easeOutBounce'
      animateRotate: true
      animateScale: false
      onAnimationComplete : null

    # TODO: merge options
    config = @Doughnut.defaults

    new Chart.D3Doughnut(data, config, @element)

class Chart.D3Doughnut
  constructor: (@data, @config, @element) ->
