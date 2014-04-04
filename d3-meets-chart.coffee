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

    config = _.extend({}, @Doughnut.defaults, options)
    new Chart.D3Doughnut(data, config, @element)

class Chart.D3Doughnut
  constructor: (@data, config, @element) ->

    margin = 5
    outerRadius = Math.min(@rootSvgWidth(), @rootSvgHeight()) / 2 - margin
    innerRadius = outerRadius * (config.percentageInnerCutout / 100)
    arc = d3.svg.arc().innerRadius(innerRadius).outerRadius(outerRadius)

    path = @drawChart(arc, config)

    @setAnimationComplete(config)
    @animateRotate(path, arc, config)
    @animateScale(config)

  animateRotate: (path, arc, config) ->
    return if !(config.animation and config.animateRotate)
    path
      .transition()
      .call(@transitionEndAll, config)
      .duration @duration(config)
      .ease 'bounce'
      .attrTween 'd', (d) ->
        interpolate = d3.interpolate({startAngle: 0, endAngle: 0}, d)
        (t)-> arc interpolate(t)

  animateScale: (config) ->
    return if !(config.animation and config.animateScale)
    @rootSvg()
      .selectAll 'g'
      .attr
        transform: "#{@translateToCenter(svg)} scale(0)"
      .transition()
      .call(@transitionEndAll, config)
      .duration @duration(config)
      .ease 'bounce'
      .attr
        transform: 'scale(1)'

  attrSegmentStroke: (config) ->
    if config.segmentShowStroke
      stroke: config.segmentStrokeColor
      'stroke-width': config.segmentStrokeWidth
    else
      stroke: 'none'
      'stroke-width': 0

  drawChart: (arc, config) ->
    pie = d3.layout.pie().value((d) -> d.value).sort(null)
    colors = _.map @data, (d) -> d.color
    @rootSvg()
      .append 'g'
      .selectAll 'path'
      .data pie(@data)
      .enter()
      .append 'path'
      .attr @attrSegmentStroke(config)
      .attr
        d: arc
        transform: @translateToCenter
        fill: (d, i) -> colors[i]

  duration: (config) ->
    config.animationSteps * 16.666

  rootSvg: =>
    d3.select(@element)

  rootSvgWidth: =>
    @rootSvg().property('width').baseVal.value

  rootSvgHeight: =>
    @rootSvg().property('height').baseVal.value

  setAnimationComplete: (config) ->
    return unless typeof(config.onAnimationComplete) is 'function'
    # TODO: need test
    @transitionEndAllCount =
      if config.animation and config.animateRotate and config.animateScale
        2
      else if config.animation and (config.animateRotate or config.animateScale)
        1
      else
        NaN
    config.onAnimationComplete.call(@) if isNaN(@transitionEndAllCount)

  transitionEndAll: (transition, config) =>
    n = 0
    transition
      .each -> ++n
      .each 'end', =>
        # TODO: need test
        if !--n and (--@transitionEndAllCount == 0)
          config.onAnimationComplete.apply(@, arguments)

  # FIXME: resopnsive and unit bug
  translateToCenter: =>
    "translate(#{@rootSvgWidth() / 2}, #{@rootSvgHeight() / 2})"
