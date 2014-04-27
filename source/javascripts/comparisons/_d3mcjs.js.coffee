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

exports.comparisons.chart_names.forEach (chart_name) ->
  $(".comparison--#{chart_name}-chart__chart--alternative").one 'inview', ->
    exports.comparisons.delay ->
      comparison = exports.comparisons[chart_name]
      chart = new Chart(comparison.id.alternative)
      data = comparison.data
      switch chart_name
        when 'bar'      then chart.Bar(data)
        when 'line'     then chart.Line(data)
        when 'pie'      then chart.Pie(data)
        when 'doughnut' then chart.Doughnut(data)
        when 'radar'    then notImplementedYet(comparison.id.alternative)
        when 'polar'    then notImplementedYet(comparison.id.alternative)
