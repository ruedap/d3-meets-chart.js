#= require jquery/dist/jquery.min.js
#= require jquery.inview/jquery.inview.min.js
#= require _chartjs.js
#= require d3/d3.min.js
#= require d3-meets-chart.js/d3-meets-chart.min.js
#= require vendor/highlight.pack.js
#= require comparisons/_data.js
#= require comparisons/_chartjs.js
#= require comparisons/_d3mcjs.js

$ ->
  # highlight.js
  # hljs.configure(classPrefix: '')
  hljs.initHighlightingOnLoad()

  $('#js-download-button').one 'inview', ->
    setTimeout =>
      $(this).removeClass('hidden')
    , 300

  $('#js-why-use-this-chart').one 'inview', ->
    data = exports.comparisons['bar'].data
    selector = '#js-why-use-this-chart'
    $(selector).empty()
    chart = new Chart(selector).Bar(data)

    $('#why-use-this-chart .d3mc-bar-group rect').hover (event) ->
      $(event.target).fadeTo(200, 0.5)
    , (event) ->
      $(event.target).fadeTo(200, 1)
