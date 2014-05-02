# Concrete class for pie chart
class Chart.D3Pie extends Chart.D3Chart
  'use strict'

  attrSegmentStroke: (options) ->
    if options.segmentShowStroke
      stroke: options.segmentStrokeColor
      'stroke-width': options.segmentStrokeWidth
    else
      stroke: 'none'
      'stroke-width': 0

  constructor: (selectors, data, options) ->
    margin = top: 0, right: 0, bottom: 0, left: 0
    super(selectors, data, options, margin)

  getArc: (innerRadius, outerRadius) ->
    d3.svg.arc().innerRadius(innerRadius).outerRadius(outerRadius)

  getInnerRadius: (outerRadius, options) ->
    0

  getOuterRadius: (chartWidth, chartHeight, margin) ->
    ~~(Math.min(chartWidth, chartHeight) / 2 - margin)

  # TODO: enable spec
  render: ->
    margin = 5
    options = @options
    data = @setDefaultColors(@data)
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

  renderPie: (data, options, baseClassName = 'pie') ->
    pie = d3.layout.pie().value((d) -> d.value).sort(null)
    colors = data.map((d) -> d.color)
    @getRootElement()
      .select(@className('base-group'))
      .append('g')
      .classed(@classedName("#{baseClassName}-chart-group"), true)
      .selectAll('path')
      .data(pie(data))
      .enter()
      .append('path')
      .classed(@classedName(baseClassName), true)
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

  setDefaultColors: (data, colors = _defaultColors()) ->
    data.map (d) ->
      value = d.value
      defaultColor = colors.shift()
      color = if d.color? then d.color else defaultColor
      { value, color }

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

  transitRotation: (sl, arc, options) ->
    return null if !(options.animation and options.animateRotate)
    sl.transition()
      .call(@transitionEndAll, options)
      .duration(@duration())
      .ease(options.animationEasing)
      .attrTween 'd', (d) ->
        interpolate = d3.interpolate({startAngle: 0, endAngle: 0}, d)
        (t) -> arc(interpolate(t))

  transitionEndAll: (transition, options) =>
    n = 0
    transition
      .each(-> ++n)
      .each 'end', =>
        # TODO: need spec
        if !--n and (--@transitionEndAllCount == 0)
          options.onAnimationComplete.apply(this, arguments)

  _defaultColors = ->
    [
      '#f38630', '#e0e4cc', '#69d2e7', '#b5cf6b', '#9c9ede',
      '#de483d', '#4292c7', '#e377c2', '#e7ba52', '#54cc86'
    ]
