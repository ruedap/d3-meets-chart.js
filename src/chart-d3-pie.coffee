class Chart.D3Pie extends Chart.D3Chart
  constructor: (selectors, data, options) ->
    super selectors, data, options

  animateRotate: (path, arc, options) ->
    return if !(options.animation and options.animateRotate)
    path
      .transition()
      .call @transitionEndAll, options
      .duration @duration()
      .ease options.animationEasing
      .attrTween 'd', (d) ->
        interpolate = d3.interpolate {startAngle: 0, endAngle: 0}, d
        (t)-> arc interpolate(t)

  animateScale: (options) ->
    return if !(options.animation and options.animateScale)
    @getRootElement()
      .selectAll 'g'
      .attr
        transform: "#{@attrTranslateToCenter()} scale(0)"
      .transition()
      .call @transitionEndAll, options
      .duration @duration()
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
        transform: @attrTranslateToCenter()
        fill: (d, i) -> colors[i]

  # TODO: Refactor
  render: ->
    width = @getRootElementWidth()
    height = @getRootElementHeight()
    margin = 5
    outerRadius = ~~(Math.min(width, height) / 2 - margin)
    innerRadius = ~~(outerRadius * (@options.percentageInnerCutout / 100))
    arc = d3.svg.arc().innerRadius(innerRadius).outerRadius(outerRadius)
    path = @drawChart arc, @options
    @transitionEndAllCount = @setAnimationComplete @options
    @options.onAnimationComplete.call this if isNaN @transitionEndAllCount
    @animateRotate path, arc, @options
    @animateScale @options
    this

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
