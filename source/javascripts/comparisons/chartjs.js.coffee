options =
  scaleOverride : true
  scaleSteps : 20
  scaleStepWidth : 5
  scaleStartValue : 0


$('.comparison--bar-chart__chart--original').one 'inview', ->
  exports.comparisons.delay ->
    bar = exports.comparisons.bar
    canvas = document.getElementById(bar.id.original).getContext('2d')
    new ChartJS(canvas).Bar(bar.data, options)

$('.comparison--line-chart__chart--original').one 'inview', ->
  exports.comparisons.delay ->
    line = exports.comparisons.line
    canvas = document.getElementById(line.id.original).getContext('2d')
    new ChartJS(canvas).Line(line.data, options)

$('.comparison--pie-chart__chart--original').one 'inview', ->
  exports.comparisons.delay ->
    pie = exports.comparisons.pie
    canvas = document.getElementById(pie.id.original).getContext('2d')
    new ChartJS(canvas).Pie(pie.data)

$('.comparison--doughnut-chart__chart--original').one 'inview', ->
  exports.comparisons.delay ->
    doughnut = exports.comparisons.doughnut
    canvas = document.getElementById(doughnut.id.original).getContext('2d')
    new ChartJS(canvas).Doughnut(doughnut.data)

$('.comparison--radar-chart__chart--original').one 'inview', ->
  exports.comparisons.delay ->
    radar = exports.comparisons.radar
    canvas = document.getElementById(radar.id.original).getContext('2d')
    new ChartJS(canvas).Radar(radar.data)

$('.comparison--polar-chart__chart--original').one 'inview', ->
  exports.comparisons.delay ->
    polar = exports.comparisons.polar
    canvas = document.getElementById(polar.id.original).getContext('2d')
    new ChartJS(canvas).PolarArea(polar.data)
