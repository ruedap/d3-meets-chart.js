var Chart,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

Chart = (function() {
  function Chart(element) {
    this.element = element;
  }

  Chart.prototype.Doughnut = function(data, options) {
    var mergedOptions;
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
    mergedOptions = _.extend({}, this.Doughnut.defaults, options);
    return new Chart.D3Doughnut(data, mergedOptions, this.element);
  };

  return Chart;

})();

Chart.D3Doughnut = (function() {
  function D3Doughnut(data, options, element) {
    var arc, innerRadius, margin, outerRadius, path;
    this.data = data;
    this.element = element;
    this.translateToCenter = __bind(this.translateToCenter, this);
    this.transitionEndAll = __bind(this.transitionEndAll, this);
    this.rootSvgHeight = __bind(this.rootSvgHeight, this);
    this.rootSvgWidth = __bind(this.rootSvgWidth, this);
    this.rootSvg = __bind(this.rootSvg, this);
    margin = 5;
    outerRadius = Math.min(this.rootSvgWidth(), this.rootSvgHeight()) / 2 - margin;
    innerRadius = outerRadius * (options.percentageInnerCutout / 100);
    arc = d3.svg.arc().innerRadius(innerRadius).outerRadius(outerRadius);
    path = this.drawChart(arc, options);
    this.setAnimationComplete(options);
    this.animateRotate(path, arc, options);
    this.animateScale(options);
  }

  D3Doughnut.prototype.animateRotate = function(path, arc, options) {
    if (!(options.animation && options.animateRotate)) {
      return;
    }
    return path.transition().call(this.transitionEndAll, options).duration(this.duration(options)).ease('bounce').attrTween('d', function(d) {
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

  D3Doughnut.prototype.animateScale = function(options) {
    if (!(options.animation && options.animateScale)) {
      return;
    }
    return this.rootSvg().selectAll('g').attr({
      transform: "" + (this.translateToCenter(svg)) + " scale(0)"
    }).transition().call(this.transitionEndAll, options).duration(this.duration(options)).ease('bounce').attr({
      transform: 'scale(1)'
    });
  };

  D3Doughnut.prototype.attrSegmentStroke = function(options) {
    if (options.segmentShowStroke) {
      return {
        stroke: options.segmentStrokeColor,
        'stroke-width': options.segmentStrokeWidth
      };
    } else {
      return {
        stroke: 'none',
        'stroke-width': 0
      };
    }
  };

  D3Doughnut.prototype.drawChart = function(arc, options) {
    var colors, pie;
    pie = d3.layout.pie().value(function(d) {
      return d.value;
    }).sort(null);
    colors = _.map(this.data, function(d) {
      return d.color;
    });
    return this.rootSvg().append('g').selectAll('path').data(pie(this.data)).enter().append('path').attr(this.attrSegmentStroke(options)).attr({
      d: arc,
      transform: this.translateToCenter(),
      fill: function(d, i) {
        return colors[i];
      }
    });
  };

  D3Doughnut.prototype.duration = function(options) {
    return options.animationSteps * 16.666;
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

  D3Doughnut.prototype.setAnimationComplete = function(options) {
    if (typeof options.onAnimationComplete !== 'function') {
      return;
    }
    this.transitionEndAllCount = options.animation && options.animateRotate && options.animateScale ? 2 : options.animation && (options.animateRotate || options.animateScale) ? 1 : NaN;
    if (isNaN(this.transitionEndAllCount)) {
      return options.onAnimationComplete.call(this);
    }
  };

  D3Doughnut.prototype.transitionEndAll = function(transition, options) {
    var n;
    n = 0;
    return transition.each(function() {
      return ++n;
    }).each('end', (function(_this) {
      return function() {
        if (!--n && (--_this.transitionEndAllCount === 0)) {
          return options.onAnimationComplete.apply(_this, arguments);
        }
      };
    })(this));
  };

  D3Doughnut.prototype.translateToCenter = function() {
    return "translate(" + (this.rootSvgWidth() / 2) + ", " + (this.rootSvgHeight() / 2) + ")";
  };

  return D3Doughnut;

})();
