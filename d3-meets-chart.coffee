class Chart
  constructor: (@element) ->

  Doughnut: (data, options) ->
    @Doughnut.defaults =
      segmentShowStroke: true
      segmentStrokeColor: '#fff'
      segmentStrokeWidth: 2
      percentageInnerCutout: 50
      animation: true
      animationSteps: 100
      animationEasing: 'easeOutBounce'
      animateRotate: true
      animateScale: false
      onAnimationComplete : null

    # TODO: merge options
    config = @Doughnut.defaults

    new Chart.D3Doughnut(data, config, @element)

class Chart.D3Doughnut
  constructor: (@data, @config, @element) ->
    pie = d3.layout.pie().value((d) -> d.value).sort(null)
    svg = d3.select(@element)
    margin = 5
    outerRadius = Math.min(@svgWidth(svg), @svgHeight(svg)) / 2 - margin
    innerRadius = outerRadius * (@config.percentageInnerCutout / 100)
    arc = d3.svg.arc().innerRadius(innerRadius).outerRadius(outerRadius)

    svg
      .selectAll 'path'
      .data pie(@data)
      .enter()
      .append 'path'
      .attr @attrSegmentStroke(@config)
      .attr
        d: arc
        transform: @translateToCenter(svg)
        fill: (d, i) -> data[i].color  # FIXME: data(?)

  attrSegmentStroke: (config) ->
    if config.segmentShowStroke
      stroke: config.segmentStrokeColor
      'stroke-width': config.segmentStrokeWidth
    else
      stroke: 'none'
      'stroke-width': 0

  svgWidth: (svg) ->
    svg.property('width').baseVal.value

  svgHeight: (svg) ->
    svg.property('height').baseVal.value

  # FIXME: resopnsive and unit bug
  translateToCenter: (svg) ->
    "translate(#{@svgWidth(svg) / 2}, #{@svgHeight(svg) / 2})"
