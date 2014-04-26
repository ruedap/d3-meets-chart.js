notImplementedYet = (id) ->
  svg = d3.select(id)
  x = ~~(+svg.attr('width') / 2)
  y = ~~(+svg.attr('height') / 2)
  d3.select(id)
    .append('text')
    .attr(stroke: '#777')
    .attr('font-size': 16)
    .attr('font-family': 'Lato, Avenir Next, Avenir, Arial')
    .attr('font-weight': 300)
    .attr('text-anchor': 'middle')
    .attr(x: x, y: y)
    .text('Not implemented yet')

$('.comparison--bar-chart__chart--alternative').one 'inview', ->
  exports.comparisons.delay ->
    bar = exports.comparisons.bar
    new Chart(bar.id.alternative).Bar(bar.data)

$('.comparison--line-chart__chart--alternative').one 'inview', ->
  exports.comparisons.delay ->
    line = exports.comparisons.line
    new Chart(line.id.alternative).Line(line.data)

$('.comparison--pie-chart__chart--alternative').one 'inview', ->
  exports.comparisons.delay ->
    pie = exports.comparisons.pie
    new Chart(pie.id.alternative).Pie(pie.data)

$('.comparison--doughnut-chart__chart--alternative').one 'inview', ->
  exports.comparisons.delay ->
    doughnut = exports.comparisons.doughnut
    new Chart(doughnut.id.alternative).Doughnut(doughnut.data)

$('.comparison--radar-chart__chart--alternative').one 'inview', ->
  exports.comparisons.delay ->
    notImplementedYet(exports.comparisons.radar.id.alternative)

$('.comparison--polar-chart__chart--alternative').one 'inview', ->
  exports.comparisons.delay ->
    notImplementedYet(exports.comparisons.polar.id.alternative)
