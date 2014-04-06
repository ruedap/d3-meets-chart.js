class Chart.D3Doughnut extends Chart.D3Chart
  constructor: (selectors, data, options) ->
    super selectors, data, options

  animateRotate: (path, arc, options) ->
    return if !(options.animation and options.animateRotate)
    path
      .transition()
      .call @transitionEndAll, options
      .duration @duration(options)
      .ease options.animationEasing
      .attrTween 'd', (d) ->
        interpolate = d3.interpolate {startAngle: 0, endAngle: 0}, d
        (t)-> arc interpolate(t)

  animateScale: (options) ->
    return if !(options.animation and options.animateScale)
    @getRootElement()
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
    @getRootElement()
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

  # TODO: Refactor
  render: ->
    margin = 5
    outerRadius = ~~(Math.min(@rootElementWidth(), @rootElementHeight()) / 2 - margin)
    innerRadius = ~~(outerRadius * (@options.percentageInnerCutout / 100))
    arc = d3.svg.arc().innerRadius(innerRadius).outerRadius(outerRadius)

    path = @drawChart arc, @options

    @transitionEndAllCount = @setAnimationComplete @options
    @options.onAnimationComplete.call this if isNaN @transitionEndAllCount

    @animateRotate path, arc, @options
    @animateScale @options
    this

  # FIXME
  rootElementHeight: =>
    +@getRootElement().attr('height')

  # FIXME
  rootElementWidth: =>
    +@getRootElement().attr('width')

  setAnimationComplete: (options) ->
    return Infinity unless _.isFunction options.onAnimationComplete
    if options.animation and options.animateRotate and options.animateScale
      2
    else if options.animation and (options.animateRotate or options.animateScale)
      1
    else
      NaN

  transitionEndAll: (transition, options) =>
    n = 0
    transition
      .each -> ++n
      .each 'end', =>
        # TODO: need test
        if !--n and (--@transitionEndAllCount == 0)
          options.onAnimationComplete.apply this, arguments

  # FIXME: resopnsive and unit support
  translateToCenter: =>
    "translate(#{@rootElementWidth() / 2}, #{@rootElementHeight() / 2})"
