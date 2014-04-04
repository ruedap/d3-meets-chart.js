var Chart,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

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
    var arc, innerRadius, margin, outerRadius, path;
    this.data = data;
    this.element = element;
    this.translateToCenter = __bind(this.translateToCenter, this);
    this.rootSvgHeight = __bind(this.rootSvgHeight, this);
    this.rootSvgWidth = __bind(this.rootSvgWidth, this);
    this.rootSvg = __bind(this.rootSvg, this);
    margin = 5;
    outerRadius = Math.min(this.rootSvgWidth(), this.rootSvgHeight()) / 2 - margin;
    innerRadius = outerRadius * (config.percentageInnerCutout / 100);
    arc = d3.svg.arc().innerRadius(innerRadius).outerRadius(outerRadius);
    path = this.drawChart(arc, config);
    this.animateRotate(path, arc, config);
    this.animateScale(config);
  }

  D3Doughnut.prototype.animateRotate = function(path, arc, config) {
    if (!(config.animation && config.animateRotate)) {
      return;
    }
    return path.transition().call(this.transitionEndAll, function() {
      return console.log('rotate done');
    }).duration(this.duration(config)).ease('bounce').attrTween('d', function(d) {
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
    var transformOriginX, transformOriginY;
    if (!(config.animation && config.animateScale)) {
      return;
    }
    transformOriginX = this.svgWidth() / 2;
    transformOriginY = this.svgHeight() / 2;
    return this.rootSvg().selectAll('g').attr({
      transform: "" + (this.translateToCenter(svg)) + " scale(0)"
    }).transition().call(this.transitionEndAll, function() {
      return console.log('scale done');
    }).duration(this.duration(config)).ease('bounce').attr({
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

  D3Doughnut.prototype.drawChart = function(arc, config) {
    var colors, pie;
    pie = d3.layout.pie().value(function(d) {
      return d.value;
    }).sort(null);
    colors = _.map(this.data, function(d) {
      return d.color;
    });
    return this.rootSvg().append('g').selectAll('path').data(pie(this.data)).enter().append('path').attr(this.attrSegmentStroke(config)).attr({
      d: arc,
      transform: this.translateToCenter,
      fill: function(d, i) {
        return colors[i];
      }
    });
  };

  D3Doughnut.prototype.duration = function(config) {
    return config.animationSteps * 16.666;
  };

  D3Doughnut.prototype.rootSvg = function() {
    return d3.select(this.element);
  };

  D3Doughnut.prototype.rootSvgWidth = function() {
    return this.rootSvg().property('width').baseVal.value;
  };

  D3Doughnut.prototype.rootSvgHeight = function() {
    return this.rootSvg().property('height').baseVal.value;
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

  D3Doughnut.prototype.translateToCenter = function() {
    return "translate(" + (this.rootSvgWidth() / 2) + ", " + (this.rootSvgHeight() / 2) + ")";
  };

  return D3Doughnut;

})();
