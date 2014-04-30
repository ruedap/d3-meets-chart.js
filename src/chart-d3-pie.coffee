# Concrete class for pie chart
class Chart.D3Pie extends Chart.D3Chart
  'use strict'

  constructor: (selectors, data, options) ->
    margin = top: 0, right: 0, bottom: 0, left: 0
    super(selectors, data, options, margin)

  attrSegmentStroke: (options) ->
    if options.segmentShowStroke
      stroke: options.segmentStrokeColor
      'stroke-width': options.segmentStrokeWidth
    else
      stroke: 'none'
      'stroke-width': 0

  getOuterRadius: (chartWidth, chartHeight, margin) ->
    ~~(Math.min(chartWidth, chartHeight) / 2 - margin)

  getInnerRadius: (outerRadius, options) ->
    0

  getArc: (innerRadius, outerRadius) ->
    d3.svg.arc().innerRadius(innerRadius).outerRadius(outerRadius)

  # TODO: enable spec
  render: ->
    margin = 5
    options = @options
    data = @data
    chartWidth = @width
    chartHeight = @height
    outerRadius = @getOuterRadius(chartWidth, chartHeight, margin)
    innerRadius = @getInnerRadius(outerRadius, options)
    arc = @getArc(innerRadius, outerRadius)
    sl = @renderPie(data, options)
    @transitionEndAllCount = @setAnimationComplete(options)
    options.onAnimationComplete.call(this) if isNaN(@transitionEndAllCount)

    switch
      when options.animation and options.animateRotate and options.animateScale
        @transitRotation(sl, arc, options)
        @transitExpansion(options)
      when options.animation and options.animateRotate and !options.animateScale
        @transitRotation(sl, arc, options)
      when options.animation and options.animateScale and !options.animateRotate
        @renderPiePath(sl, arc)
        @transitExpansion(options)
      else
        @renderPiePath(sl, arc)

    this

  renderPie: (data, options) ->
    pie = d3.layout.pie().value((d) -> d.value).sort(null)
    colors = data.map((d) -> d.color)
    @getRootElement()
      .select('.margin-convention-element')
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
    o = options
    return Infinity unless typeof o.onAnimationComplete is 'function'
    if o.animation and o.animateRotate and o.animateScale
      2
    else if o.animation and (o.animateRotate or o.animateScale)
      1
    else
      NaN

  transitRotation: (sl, arc, options) ->
    return null if !(options.animation and options.animateRotate)
    sl.transition()
      .call(@transitionEndAll, options)
      .duration(@duration())
      .ease(options.animationEasing)
      .attrTween 'd', (d) ->
        interpolate = d3.interpolate({startAngle: 0, endAngle: 0}, d)
        (t) -> arc(interpolate(t))

  transitExpansion: (options) ->
    return null if !(options.animation and options.animateScale)
    @getRootElement()
      .selectAll('g')
      .attr(transform: "#{@attrTranslateToCenter()} scale(0)")
      .transition()
      .call(@transitionEndAll, options)
      .duration(@duration())
      .ease(options.animationEasing)
      .attr(transform: 'scale(1)')

  transitionEndAll: (transition, options) =>
    n = 0
    transition
      .each(-> ++n)
      .each 'end', =>
        # TODO: need spec
        if !--n and (--@transitionEndAllCount == 0)
          options.onAnimationComplete.apply(this, arguments)
