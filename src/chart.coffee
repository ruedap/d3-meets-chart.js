class Chart
  'use strict'

  constructor: (@selectors) ->
    unless _.isString @selectors
      throw new TypeError 'This argument is not selectors string'

  Bar: (data, options) ->
    @validateData data
    @Bar.defaults =
      # Boolean - If we show the scale above the chart data.
      scaleOverlay: false
      # Boolean - If we want to override with a hard coded scale.
      scaleOverride: false
      # Number - The number of steps in a hard coded scale.
      # (Required if scaleOverride is true)
      scaleSteps: null
      # Number - The value jump in the hard coded scale.
      # (Required if scaleOverride is true)
      scaleStepWidth: null
      # Number - The scale starting value.
      # (Required if scaleOverride is true)
      scaleStartValue: null
      # String - Colour of the scale line.
      scaleLineColor: 'rgba(0,0,0,.1)'
      # Number - Pixel width of the scale line.
      scaleLineWidth: 1
      # Boolean - Whether to show labels on the scale.
      scaleShowLabels: true
      # Interpolated JS string - can access value.
      scaleLabel: '<%=value%>'
      # String - Scale label font declaration for the scale label.
      scaleFontFamily: "'Arial'"
      # Number - Scale label font size in pixels.
      scaleFontSize: 12
      # String - Scale label font weight style.
      scaleFontStyle: 'normal'
      # String - Scale label font colour.
      scaleFontColor: '#666'
      # Boolean - Whether grid lines are shown across the chart.
      scaleShowGridLines: true
      # String - Colour of the grid lines.
      scaleGridLineColor: 'rgba(0,0,0,.05)'
      # Number - Width of the grid lines.
      scaleGridLineWidth: 1
      # Boolean - If there is a stroke on each bar.
      barShowStroke: true
      # Number - Pixel width of the bar stroke.
      barStrokeWidth: 2
      # Number - Spacing between each of the X value sets.
      barValueSpacing: 5
      # Number - Spacing between data sets within X values.
      barDatasetSpacing: 1
      # Boolean - Whether to animate the chart.
      animation: true
      # Number - Number of animation steps.
      animationSteps: 60
      # String - Animation easing effect.
      animationEasing: 'easeOutQuad'
      # Function - Fires when the animation is complete.
      onAnimationComplete: null
    mergedOptions = @mergeOptions @Bar.defaults, options
    new Chart.D3Bar(@selectors, data, mergedOptions).render()

  Doughnut: (data, options) ->
    @validateData data
    @Doughnut.defaults =
      # Boolean - Whether we should show a stroke on each segment.
      segmentShowStroke: true
      # String - The colour of each segment stroke.
      segmentStrokeColor: '#fff'
      # Number - The width of each segment stroke.
      segmentStrokeWidth: 2
      # Number - The percentage of the chart that we cut out of the middle.
      percentageInnerCutout: 50
      # Boolean - Whether we should animate the chart.
      animation: true
      # Number - Amount of animation steps.
      animationSteps: 100
      # String - Animation easing effect.
      animationEasing: 'easeOutBounce'
      # Boolean - Whether we animate the rotation of the Doughnut.
      animateRotate: true
      # Boolean - Whether we animate scaling the Doughnut from the centre.
      animateScale: false
      # Function - Will fire on animation completion.
      onAnimationComplete: null
    mergedOptions = @mergeOptions @Doughnut.defaults, options
    new Chart.D3Doughnut(@selectors, data, mergedOptions).render()

  Pie: (data, options) ->
    @validateData data
    @Pie.defaults =
      # Boolean - Whether we should show a stroke on each segment.
      segmentShowStroke: true
      # String - The colour of each segment stroke.
      segmentStrokeColor: '#fff'
      # Number - The width of each segment stroke.
      segmentStrokeWidth: 2
      # Boolean - Whether we should animate the chart.
      animation: true
      # Number - Amount of animation steps.
      animationSteps: 100
      # String - Animation easing effect.
      animationEasing: 'easeOutBounce'
      # Boolean - Whether we animate the rotation of the Doughnut.
      animateRotate: true
      # Boolean - Whether we animate scaling the Doughnut from the centre.
      animateScale: false
      # Function - Will fire on animation completion.
      onAnimationComplete: null
    mergedOptions = @mergeOptions @Pie.defaults, options
    new Chart.D3Pie(@selectors, data, mergedOptions).render()

  easingTypes:
    linear: 'linear'
    easeInQuad: 'quad-in'
    easeOutQuad: 'quad-out'
    easeInOutQuad: 'quad-in-out'
    easeInCubic: 'cubic-in'
    easeOutCubic: 'cubic-out'
    easeInOutCubic: 'cubic-in-out'
    easeInSine: 'sin-in'
    easeOutSine: 'sin-out'
    easeInOutSine: 'sin-in-out'
    easeInExpo: 'exp-in'
    easeOutExpo: 'exp-out'
    easeInOutExpo: 'exp-in-out'
    easeInCirc: 'circle-in'
    easeOutCirc: 'circle-out'
    easeInOutCirc: 'circle-in-out'
    easeInElastic: 'elastic-out'        # Invert? but based on Chart.js
    easeOutElastic: 'elastic-in'        # Invert? but based on Chart.js
    easeInOutElastic: 'elastic-in-out'  # Differs from Chart.js
    easeInBack: 'back-in'
    easeOutBack: 'back-out'
    easeInOutBack: 'back-in-out'
    easeInBounce: 'bounce-out'          # Invert? but based on Chart.js
    easeOutBounce: 'bounce-in'          # Invert? but based on Chart.js
    easeInOutBounce: 'bounce-in-out'    # Differs from Chart.js
    # TODO: Implement custom easing type
    # easeInQuart: ''
    # easeOutQuart: ''
    # easeInOutQuart: ''
    # easeInQuint: ''
    # easeOutQuint: ''
    # easeInOutQuint: ''

  getEasingType: (easingType) ->
    easingTypeName = @easingTypes[easingType]
    unless easingTypeName?
      throw new ReferenceError "'#{easingType}' is not a easing type name"
    easingTypeName

  mergeOptions: (defaults, options) ->
    # TODO: Avoid Underscore.js
    mergedOptions = _.extend {}, defaults, options
    mergedOptions.animationEasing = @getEasingType mergedOptions.animationEasing
    mergedOptions

  validateData: (data) ->
    if !(_.isArray(data) or _.isObject(data))
      throw new TypeError "#{data} is not an array or object"

# For test on Node.js
if module?.exports?
  module.exports.Chart = Chart
  global._ = require 'underscore'
  global.d3 = require 'd3'
