# D3 meets Chart.js [![Build Status](https://travis-ci.org/ruedap/d3-meets-chart.js.svg?branch=master)](https://travis-ci.org/ruedap/d3-meets-chart.js)

> Simple HTML5 Charts using the \<svg\> tag with [D3.js](http://d3js.org/).  
> The original implementation on which it is based, is [Chart.js](http://www.chartjs.org/).


## Demo

[Comparison with Chart.js](http://ruedap.github.io/d3-meets-chart.js/)


## Why use this?

Because everything is an element.  
For a SVG enthusiast. Otherwise, you might want to use [Chart.js](http://www.chartjs.org/).


## Getting started

Install using [bower](http://bower.io/) or [download as zip](https://github.com/ruedap/d3-meets-chart.js/tags).

``` sh
$ bower install d3-meets-chart.js
```

`d3-meets-chart.js` depends on D3.js, so include it only *after* D3.js has been defined in the document:

``` html
<script src="path/to/d3.min.js"></script>
<script src="path/to/d3-meets-chart.min.js"></script>
```

Create a instance for a `svg` element you'd like to chart:

``` html
<svg id="my-chart" width="500" height="500"></svg>
```

``` javascript
var myChart = new Chart('svg#my-chart');
```

And call a chart type method with chart data arguments:

``` javascript
var data = [{value: 30}, {value: 50}, {value: 100}];
myChart.Pie(data);
```

Congrats! :congratulations:


## Chart types

| Bar | Line | Radar | Pie | Doughnut | Polar area |
|:-:|:-:|:-:|:-:|:-:|:-:|
| Available | Available | *Not available* | Available | Available | *Not available* |


## Chart options

See [Chart.js documentation](http://www.chartjs.org/docs/). About the same.


## Chart API

:rotating_light: Experimental :rotating_light:


## Browser support

Internet Explorer 9+ and modern browsers.


## Changelog

Changelog is available [here](https://github.com/ruedap/d3-meets-chart.js/blob/master/CHANGELOG.md).


## License

Released under the [MIT license](https://github.com/ruedap/d3-meets-chart.js/blob/master/LICENSE.md).  
