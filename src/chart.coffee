class Chart
  constructor: (@selectors) ->
    unless _.isString @selectors
      throw new TypeError 'This argument is not selectors string'

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

    mergedOptions = @mergeOptions @Doughnut.defaults, options
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
    throw new TypeError "#{data} is not an array" unless _.isArray data

# For test on Node.js
if module?.exports?
  module.exports.Chart = Chart
  global._ = require 'underscore'
  global.d3 = require 'd3'
