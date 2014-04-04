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
    var arc, innerRadius, margin, outerRadius, path, pie, svg;
    this.data = data;
    this.element = element;
    pie = d3.layout.pie().value(function(d) {
      return d.value;
    }).sort(null);
    svg = d3.select(this.element);
    margin = 5;
    outerRadius = Math.min(this.svgWidth(svg), this.svgHeight(svg)) / 2 - margin;
    innerRadius = outerRadius * (config.percentageInnerCutout / 100);
    arc = d3.svg.arc().innerRadius(innerRadius).outerRadius(outerRadius);
    path = svg.append('g').selectAll('path').data(pie(this.data)).enter().append('path').attr(this.attrSegmentStroke(config)).attr({
      d: arc,
      transform: this.translateToCenter(svg),
      fill: function(d, i) {
        return data[i].color;
      }
    });
    this.animateRotate(path, arc, config);
    this.animateScale(config);
  }

  D3Doughnut.prototype.animateRotate = function(path, arc, config) {
    var duration;
    if (!(config.animation && config.animateRotate)) {
      return;
    }
    duration = config.animationSteps * 16.666;
    return path.transition().call(this.transitionEndAll, function() {
      return console.log('rotate done');
    }).duration(duration).ease('bounce').attrTween('d', function(d) {
      var interpolate;
      interpolate = d3.interpolate({
        startAngle: 0,
        endAngle: 0
      }, d);
      return function(t) {
        return arc(interpolate(t));
      };
    });
  };

  D3Doughnut.prototype.animateScale = function(config) {
    var duration, svg, transformOriginX, transformOriginY;
    if (!(config.animation && config.animateScale)) {
      return;
    }
    duration = config.animationSteps * 16.666;
    svg = d3.select(this.element);
    transformOriginX = this.svgWidth(svg) / 2;
    transformOriginY = this.svgHeight(svg) / 2;
    return svg.selectAll('g').attr({
      transform: "" + (this.translateToCenter(svg)) + " scale(0)"
    }).transition().call(this.transitionEndAll, function() {
      return console.log('scale done');
    }).duration(duration).ease('bounce').attr({
      transform: 'scale(1)'
    });
  };

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

  D3Doughnut.prototype.transitionEndAll = function(transition, callback) {
    var n;
    n = 0;
    return transition.each(function() {
      return ++n;
    }).each('end', function() {
      if (!--n) {
        return callback.apply(this, arguments);
      }
    });
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
