var Chart;

Chart = (function() {
  function Chart(element) {
    this.element = element;
  }

  Chart.prototype.Doughnut = function(data, options) {
    var config;
    this.Doughnut.defaults = {
      segmentShowStroke: true,
      segmentStrokeColor: '#fff',
      segmentStrokeWidth: 2,
      percentageInnerCutout: 50,
      animation: true,
      animationSteps: 100,
      animationEasing: 'easeOutBounce',
      animateRotate: true,
      animateScale: false,
      onAnimationComplete: null
    };
    config = _.extend({}, this.Doughnut.defaults, options);
    return new Chart.D3Doughnut(data, config, this.element);
  };

  return Chart;

})();

Chart.D3Doughnut = (function() {
  function D3Doughnut(data, config, element) {
    var arc, duration, innerRadius, margin, outerRadius, pie, svg;
    this.data = data;
    this.config = config;
    this.element = element;
    pie = d3.layout.pie().value(function(d) {
      return d.value;
    }).sort(null);
    svg = d3.select(this.element);
    margin = 5;
    outerRadius = Math.min(this.svgWidth(svg), this.svgHeight(svg)) / 2 - margin;
    innerRadius = outerRadius * (this.config.percentageInnerCutout / 100);
    arc = d3.svg.arc().innerRadius(innerRadius).outerRadius(outerRadius);
    duration = this.config.animationSteps * 17.5;
    svg.selectAll('path').data(pie(this.data)).enter().append('path').attr(this.attrSegmentStroke(this.config)).attr({
      d: arc,
      transform: this.translateToCenter(svg),
      fill: function(d, i) {
        return data[i].color;
      }
    }).transition().duration(duration).ease('bounce').attrTween('d', function(d) {
      var interpolate;
      interpolate = d3.interpolate({
        startAngle: 0,
        endAngle: 0
      }, d);
      return function(t) {
        return arc(interpolate(t));
      };
    });
  }

  D3Doughnut.prototype.attrSegmentStroke = function(config) {
    if (config.segmentShowStroke) {
      return {
        stroke: config.segmentStrokeColor,
        'stroke-width': config.segmentStrokeWidth
      };
    } else {
      return {
        stroke: 'none',
        'stroke-width': 0
      };
    }
  };

  D3Doughnut.prototype.svgWidth = function(svg) {
    return svg.property('width').baseVal.value;
  };

  D3Doughnut.prototype.svgHeight = function(svg) {
    return svg.property('height').baseVal.value;
  };

  D3Doughnut.prototype.translateToCenter = function(svg) {
    return "translate(" + (this.svgWidth(svg) / 2) + ", " + (this.svgHeight(svg) / 2) + ")";
  };

  return D3Doughnut;

})();
