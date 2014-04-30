# Concrete class for pie chart
class Chart.D3Pie extends Chart.D3Chart
  'use strict'

  constructor: (selectors, data, options) ->
    super(selectors, data, options)

  animateRotate: (sl, arc, options) ->
    return if !(options.animation and options.animateRotate)
    sl.transition()
      .call(@transitionEndAll, options)
      .duration @duration()
      .ease(options.animationEasing)
      .attrTween 'd', (d) ->
        interpolate = d3.interpolate({startAngle: 0, endAngle: 0}, d)
        (t) -> arc(interpolate(t))

  animateScale: (options) ->
    return if !(options.animation and options.animateScale)
    @getRootElement()
      .selectAll('g')
      .attr(transform: "#{@attrTranslateToCenter()} scale(0)")
      .transition()
      .call(@transitionEndAll, options)
      .duration(@duration())
      .ease(options.animationEasing)
      .attr(transform: 'scale(1)')

  attrSegmentStroke: (options) ->
    if options.segmentShowStroke
      stroke: options.segmentStrokeColor
      'stroke-width': options.segmentStrokeWidth
    else
      stroke: 'none'
      'stroke-width': 0


  getOuterRadius: (width, height, margin) ->
    ~~(Math.min(width, height) / 2 - margin)

  getInnerRadius: (outerRadius, options) ->
    0

  # TODO: enable spec
  render: ->
    options = @options
    data = @data
    width = @getRootElementWidth()
    height = @getRootElementHeight()
    margin = 5
    outerRadius = @getOuterRadius(width, height, margin)
    innerRadius = @getInnerRadius(outerRadius, options)
    arc = d3.svg.arc().innerRadius(innerRadius).outerRadius(outerRadius)
    sl = @renderPie(data, options)
    @transitionEndAllCount = @setAnimationComplete(options)
    options.onAnimationComplete.call(this) if isNaN(@transitionEndAllCount)

    switch
      when options.animation and options.animateRotate and options.animateScale
        @animateRotate(sl, arc, options)
        @animateScale(options)
      when options.animation and options.animateRotate
        @animateRotate(sl, arc, options)
      when options.animation and options.animateScale
        @renderPiePath(sl, arc)
        @animateScale(options)
      else
        @renderPiePath(sl, arc)

    this

  renderPie: (data, options) ->
    pie = d3.layout.pie().value((d) -> d.value).sort(null)
    colors = data.map((d) -> d.color)
    @getRootElement()
      .append('g')
      .selectAll('path')
      .data pie(data)
      .enter()
      .append('path')
      .attr(@attrSegmentStroke(options))
      .attr
        transform: @attrTranslateToCenter()
        fill: (d, i) -> colors[i]

  renderPiePath: (sl, arc) ->
    sl.attr(d: arc)

  setAnimationComplete: (options) ->
    return Infinity unless typeof options.onAnimationComplete is 'function'
    if options.animation and options.animateRotate and options.animateScale
      2
    else if options.animation and (options.animateRotate or options.animateScale)
      1
    else
      NaN

  transitionEndAll: (transition, options) =>
    n = 0
    transition
      .each(-> ++n)
      .each 'end', =>
        # TODO: need spec
        if !--n and (--@transitionEndAllCount == 0)
          options.onAnimationComplete.apply(this, arguments)
