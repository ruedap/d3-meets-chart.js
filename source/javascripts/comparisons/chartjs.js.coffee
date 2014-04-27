options =
  scaleOverride : true
  scaleSteps : 20
  scaleStepWidth : 5
  scaleStartValue : 0

exports.comparisons.chart_names.forEach (chart_name) ->
  $(".comparison--#{chart_name}-chart__chart--original").one 'inview', ->
    exports.comparisons.delay ->
      comparison = exports.comparisons[chart_name]
      canvas = document.getElementById(comparison.id.original).getContext('2d')
      chart = new ChartJS(canvas)
      data = comparison.data
      switch chart_name
        when 'bar'      then chart.Bar(data, options)
        when 'line'     then chart.Line(data, options)
        when 'pie'      then chart.Pie(data)
        when 'doughnut' then chart.Doughnut(data)
        when 'radar'    then chart.Radar(data)
        when 'polar'    then chart.PolarArea(data)
