# D3 meets Chart.js

> Simple HTML5 Charts using the <svg> tag with [D3.js](http://d3js.org/).  
> The original implementation on which it is based, is [Chart.js](http://www.chartjs.org/).

## Why use D3 meets Chart.js?

If you :heart_eyes: SVG & CSS. Because everything is an element.  
Otherwise, you might want to use [Chart.js](http://www.chartjs.org/).


## Get started

Install using bower: `bower install d3-meets-chart.js` or download as zip.

`d3-meets-chart.js` depends on D3.js, so include it only *after* D3.js has been defined in the document:

``` html
<script src="path/to/d3.min.js"></script>
<script src="path/to/d3-meets-chart.min.js"></script>
```

Create a instance for a SVG element you'd like to chart:

``` html
<svg id="my-chart" width="500" height="500"></svg>
```

``` javascript
var chart = new Chart('svg#my-chart');
```

And call a chart type method with chart data arguments:

``` javascript
var data = [{value: 30}, {value: 50}, {value: 100}];
chart.Pie(data);
```

Congrats! :congratulations:


## Chart types

| Bar | Line | Radar |
|:-:|:-:|:-:|
| :ok_woman: Available | :ok_woman: Available | :no_good: Not available |

| Pie | Doughnut | Polar |
|:-:|:-:|:-:|
| :ok_woman: Available | :ok_woman: Available | :no_good: Not available |


## Chart options

See [Chart.js documentation](http://www.chartjs.org/docs/). About the same.


## Chart API

:rotating_light: Experimental :rotating_light:



## Browser support

Internet Explorer 9+ and modern browsers.


## License

Released under the [MIT license](LICENSE.md).  
