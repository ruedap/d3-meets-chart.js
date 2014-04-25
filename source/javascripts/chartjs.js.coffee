#= require Chart.js/Chart.min.js

options =
  scaleOverride : true
  scaleSteps : 20
  scaleStepWidth : 5
  scaleStartValue : 0

bar = exports.comparisons.bar
canvas = document.getElementById(bar.id.original).getContext('2d')
new Chart(canvas).Bar(bar.data, options)

line = exports.comparisons.line
canvas = document.getElementById(line.id.original).getContext('2d')
new Chart(canvas).Line(line.data, options)

pie = exports.comparisons.pie
canvas = document.getElementById(pie.id.original).getContext('2d')
new Chart(canvas).Pie(pie.data)

doughnut = exports.comparisons.doughnut
canvas = document.getElementById(doughnut.id.original).getContext('2d')
new Chart(canvas).Doughnut(doughnut.data)

radar = exports.comparisons.radar
canvas = document.getElementById(radar.id.original).getContext('2d')
new Chart(canvas).Radar(radar.data)

polar = exports.comparisons.polar
canvas = document.getElementById(polar.id.original).getContext('2d')
new Chart(canvas).PolarArea(polar.data)
