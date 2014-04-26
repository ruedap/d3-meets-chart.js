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

bar = exports.comparisons.bar
new Chart(bar.id.alternative).Bar(bar.data)

line = exports.comparisons.line
new Chart(line.id.alternative).Line(line.data)

pie = exports.comparisons.pie
new Chart(pie.id.alternative).Pie(pie.data)

doughnut = exports.comparisons.doughnut
new Chart(doughnut.id.alternative).Doughnut(doughnut.data)

notImplementedYet(exports.comparisons.radar.id.alternative)
notImplementedYet(exports.comparisons.polar.id.alternative)
