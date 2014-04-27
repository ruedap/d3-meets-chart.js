#= require jquery/dist/jquery.min.js
#= require protonet/jquery.inview/jquery.inview.min.js
#= require _chartjs.js
#= require d3/d3.min.js
#= require d3-meets-chart.js/d3-meets-chart.min.js
#= require comparisons/_data.js
#= require comparisons/_chartjs.js
#= require comparisons/_d3mcjs.js

$('#js-download-button').one 'inview', ->
  setTimeout =>
    $(this).removeClass('hidden')
  , 400
