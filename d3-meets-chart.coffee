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
  constructor: (@data, @config, @element) ->
    pie = d3.layout.pie().value((d) -> d.value).sort(null)
    svg = d3.select(@element)
    margin = 5
    outerRadius = Math.min(@svgWidth(svg), @svgHeight(svg)) / 2 - margin
    innerRadius = outerRadius * (@config.percentageInnerCutout / 100)
    arc = d3.svg.arc().innerRadius(innerRadius).outerRadius(outerRadius)
    duration = @config.animationSteps * 17.5

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
      .transition()
      .duration duration
      .ease 'bounce'
      .attrTween 'd', (d) ->
        interpolate = d3.interpolate
          startAngle: 0
          endAngle: 0
        ,
          d
        (t) ->
          arc interpolate(t)



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
