class Chart
  constructor: (@element) ->

  Doughnut: (data, options) ->
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

    mergedOptions = @mergeOptions(@Doughnut.defaults, options)
    new Chart.D3Doughnut(@element, data, mergedOptions)

  mergeOptions: (defaults, options) ->
    # TODO: Avoid Underscore.js
    mergedOptions = _.extend({}, defaults, options)
    mergedOptions.animationEasing = @getEasingType mergedOptions.animationEasing
    mergedOptions

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

class Chart.D3Doughnut
  constructor: (@element, @data, options) ->
    margin = 5
    outerRadius = ~~(Math.min(@rootSvgWidth(), @rootSvgHeight()) / 2 - margin)
    innerRadius = ~~(outerRadius * (options.percentageInnerCutout / 100))
    arc = d3.svg.arc().innerRadius(innerRadius).outerRadius(outerRadius)

    path = @drawChart(arc, options)

    @setAnimationComplete(options)
    @animateRotate(path, arc, options)
    @animateScale(options)

  animateRotate: (path, arc, options) ->
    return if !(options.animation and options.animateRotate)
    path
      .transition()
      .call @transitionEndAll, options
      .duration @duration(options)
      .ease options.animationEasing
      .attrTween 'd', (d) ->
        interpolate = d3.interpolate({startAngle: 0, endAngle: 0}, d)
        (t)-> arc interpolate(t)

  animateScale: (options) ->
    return if !(options.animation and options.animateScale)
    @rootSvg()
      .selectAll 'g'
      .attr
        transform: "#{@translateToCenter(svg)} scale(0)"
      .transition()
      .call @transitionEndAll, options
      .duration @duration(options)
      .ease options.animationEasing
      .attr
        transform: 'scale(1)'

  attrSegmentStroke: (options) ->
    if options.segmentShowStroke
      stroke: options.segmentStrokeColor
      'stroke-width': options.segmentStrokeWidth
    else
      stroke: 'none'
      'stroke-width': 0

  drawChart: (arc, options) ->
    pie = d3.layout.pie().value((d) -> d.value).sort(null)
    colors = @data.map (d) -> d.color
    @rootSvg()
      .append 'g'
      .selectAll 'path'
      .data pie(@data)
      .enter()
      .append 'path'
      .attr @attrSegmentStroke(options)
      .attr
        d: arc
        transform: @translateToCenter()
        fill: (d, i) -> colors[i]

  duration: (options) ->
    options.animationSteps * 17.333

  rootSvg: =>
    d3.select(@element)

  rootSvgWidth: =>
    @rootSvg().property('width').baseVal.value

  rootSvgHeight: =>
    @rootSvg().property('height').baseVal.value

  setAnimationComplete: (options) ->
    return unless typeof(options.onAnimationComplete) is 'function'
    # TODO: need test
    @transitionEndAllCount =
      if options.animation and options.animateRotate and options.animateScale
        2
      else if options.animation and (options.animateRotate or options.animateScale)
        1
      else
        NaN
    options.onAnimationComplete.call(@) if isNaN(@transitionEndAllCount)

  transitionEndAll: (transition, options) =>
    n = 0
    transition
      .each -> ++n
      .each 'end', =>
        # TODO: need test
        if !--n and (--@transitionEndAllCount == 0)
          options.onAnimationComplete.apply(@, arguments)

  # FIXME: resopnsive and unit support
  translateToCenter: =>
    "translate(#{@rootSvgWidth() / 2}, #{@rootSvgHeight() / 2})"

module.exports.Chart = Chart if module?.exports?