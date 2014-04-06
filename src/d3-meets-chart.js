var Chart,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

Chart = (function() {
  function Chart(selector) {
    this.selector = selector;
    if (!_.isString(selector)) {
      throw new TypeError('This argument is not a selector string');
    }
  }

  Chart.prototype.Doughnut = function(data, options) {
    var mergedOptions;
    if (!_.isArray(data)) {
      throw new TypeError("" + data + " is not an array");
    }
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
    mergedOptions = this.mergeOptions(this.Doughnut.defaults, options);
    return new Chart.D3Doughnut(this.selector, data, mergedOptions).render();
  };

  Chart.prototype.easingTypes = {
    linear: 'linear',
    easeInQuad: 'quad-in',
    easeOutQuad: 'quad-out',
    easeInOutQuad: 'quad-in-out',
    easeInCubic: 'cubic-in',
    easeOutCubic: 'cubic-out',
    easeInOutCubic: 'cubic-in-out',
    easeInSine: 'sin-in',
    easeOutSine: 'sin-out',
    easeInOutSine: 'sin-in-out',
    easeInExpo: 'exp-in',
    easeOutExpo: 'exp-out',
    easeInOutExpo: 'exp-in-out',
    easeInCirc: 'circle-in',
    easeOutCirc: 'circle-out',
    easeInOutCirc: 'circle-in-out',
    easeInElastic: 'elastic-out',
    easeOutElastic: 'elastic-in',
    easeInOutElastic: 'elastic-in-out',
    easeInBack: 'back-in',
    easeOutBack: 'back-out',
    easeInOutBack: 'back-in-out',
    easeInBounce: 'bounce-out',
    easeOutBounce: 'bounce-in',
    easeInOutBounce: 'bounce-in-out'
  };

  Chart.prototype.getEasingType = function(easingType) {
    var easingTypeName;
    easingTypeName = this.easingTypes[easingType];
    if (easingTypeName == null) {
      throw new ReferenceError("'" + easingType + "' is not a easing type name");
    }
    return easingTypeName;
  };

  Chart.prototype.mergeOptions = function(defaults, options) {
    var mergedOptions;
    mergedOptions = _.extend({}, defaults, options);
    mergedOptions.animationEasing = this.getEasingType(mergedOptions.animationEasing);
    return mergedOptions;
  };

  return Chart;

})();

Chart.D3Doughnut = (function() {
  function D3Doughnut(selector, data, options) {
    this.selector = selector;
    this.data = data;
    this.options = options;
    this.translateToCenter = __bind(this.translateToCenter, this);
    this.transitionEndAll = __bind(this.transitionEndAll, this);
    this.rootSvgWidth = __bind(this.rootSvgWidth, this);
    this.rootSvgHeight = __bind(this.rootSvgHeight, this);
    this.rootSvg = __bind(this.rootSvg, this);
  }

  D3Doughnut.prototype.animateRotate = function(path, arc, options) {
    if (!(options.animation && options.animateRotate)) {
      return;
    }
    return path.transition().call(this.transitionEndAll, options).duration(this.duration(options)).ease(options.animationEasing).attrTween('d', function(d) {
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
    }).transition().call(this.transitionEndAll, options).duration(this.duration(options)).ease(options.animationEasing).attr({
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
    colors = this.data.map(function(d) {
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
    return options.animationSteps * 17.333;
  };

  D3Doughnut.prototype.render = function() {
    var arc, innerRadius, margin, outerRadius, path;
    margin = 5;
    outerRadius = ~~(Math.min(this.rootSvgWidth(), this.rootSvgHeight()) / 2 - margin);
    innerRadius = ~~(outerRadius * (this.options.percentageInnerCutout / 100));
    arc = d3.svg.arc().innerRadius(innerRadius).outerRadius(outerRadius);
    path = this.drawChart(arc, this.options);
    this.transitionEndAllCount = this.setAnimationComplete(this.options);
    if (isNaN(this.transitionEndAllCount)) {
      this.options.onAnimationComplete.call(this);
    }
    this.animateRotate(path, arc, this.options);
    this.animateScale(this.options);
    return this;
  };

  D3Doughnut.prototype.rootSvg = function() {
    return d3.select(this.selector);
  };

  D3Doughnut.prototype.rootSvgHeight = function() {
    return +this.rootSvg().attr('height');
  };

  D3Doughnut.prototype.rootSvgWidth = function() {
    return +this.rootSvg().attr('width');
  };

  D3Doughnut.prototype.setAnimationComplete = function(options) {
    if (!_.isFunction(options.onAnimationComplete)) {
      return Infinity;
    }
    if (options.animation && options.animateRotate && options.animateScale) {
      return 2;
    } else if (options.animation && (options.animateRotate || options.animateScale)) {
      return 1;
    } else {
      return NaN;
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

if ((typeof module !== "undefined" && module !== null ? module.exports : void 0) != null) {
  module.exports.Chart = Chart;
  global._ = require('underscore');
  global.d3 = require('d3');
}
