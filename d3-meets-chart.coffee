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

    mergedOptions = _.extend({}, @Doughnut.defaults, options)
    mergedOptions.animationEasing = @getEasingType mergedOptions.animationEasing

    new Chart.D3Doughnut(data, mergedOptions, @element)

  easingTypes:
    linear: 'linear'
    easeOutBounce: 'bounce'

  getEasingType: (easingType) ->
    easingTypeName = @easingTypes[easingType]
    unless easingTypeName?
      throw new ReferenceError "'#{easingType}' is not a easing type name"
    easingTypeName


class Chart.D3Doughnut
  constructor: (@data, options, @element) ->

    margin = 5
    outerRadius = Math.min(@rootSvgWidth(), @rootSvgHeight()) / 2 - margin
    innerRadius = outerRadius * (options.percentageInnerCutout / 100)
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
    colors = _.map @data, (d) -> d.color
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
    options.animationSteps * 16.666

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

  # FIXME: resopnsive and unit bug
  translateToCenter: =>
    "translate(#{@rootSvgWidth() / 2}, #{@rootSvgHeight() / 2})"
