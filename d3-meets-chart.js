var Chart;

Chart = (function() {
  function Chart(selectors) {
    this.selectors = selectors;
    if (!_.isString(this.selectors)) {
      throw new TypeError('This argument is not selectors string');
    }
  }

  Chart.prototype.Doughnut = function(data, options) {
    var mergedOptions;
    this.validateData(data);
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
    return new Chart.D3Doughnut(this.selectors, data, mergedOptions).render();
  };

  Chart.prototype.Pie = function(data, options) {
    var mergedOptions;
    this.validateData(data);
    mergedOptions = this.mergeOptions(this.Doughnut.defaults, options);
    return new Chart.D3Pie(this.selectors, data, mergedOptions).render();
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

  Chart.prototype.validateData = function(data) {
    if (!_.isArray(data)) {
      throw new TypeError("" + data + " is not an array");
    }
  };

  return Chart;

})();

if ((typeof module !== "undefined" && module !== null ? module.exports : void 0) != null) {
  module.exports.Chart = Chart;
  global._ = require('underscore');
  global.d3 = require('d3');
}

var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

Chart.D3Chart = (function() {
  function D3Chart(selectors, data, options) {
    this.selectors = selectors;
    this.data = data;
    this.options = options;
    this.getRootElementWidth = __bind(this.getRootElementWidth, this);
    this.getRootElementHeight = __bind(this.getRootElementHeight, this);
    this.getRootElement = __bind(this.getRootElement, this);
    this.attrTranslateToCenter = __bind(this.attrTranslateToCenter, this);
  }

  D3Chart.prototype.attrTranslateToCenter = function() {
    var halfHeight, halfWidth;
    halfWidth = this.getRootElementWidth() / 2;
    halfHeight = this.getRootElementHeight() / 2;
    return "translate(" + halfWidth + ", " + halfHeight + ")";
  };

  D3Chart.prototype.duration = function(options) {
    if (options == null) {
      options = this.options;
    }
    return options.animationSteps * 17.333;
  };

  D3Chart.prototype.getRootElement = function() {
    return d3.select(this.selectors);
  };

  D3Chart.prototype.getRootElementHeight = function() {
    return +this.getRootElement().attr('height');
  };

  D3Chart.prototype.getRootElementWidth = function() {
    return +this.getRootElement().attr('width');
  };

  return D3Chart;

})();

var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Chart.D3Doughnut = (function(_super) {
  __extends(D3Doughnut, _super);

  function D3Doughnut(selectors, data, options) {
    this.transitionEndAll = __bind(this.transitionEndAll, this);
    D3Doughnut.__super__.constructor.call(this, selectors, data, options);
  }

  D3Doughnut.prototype.animateRotate = function(path, arc, options) {
    if (!(options.animation && options.animateRotate)) {
      return;
    }
    return path.transition().call(this.transitionEndAll, options).duration(this.duration()).ease(options.animationEasing).attrTween('d', function(d) {
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
    return this.getRootElement().selectAll('g').attr({
      transform: "" + (this.attrTranslateToCenter()) + " scale(0)"
    }).transition().call(this.transitionEndAll, options).duration(this.duration()).ease(options.animationEasing).attr({
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
    return this.getRootElement().append('g').selectAll('path').data(pie(this.data)).enter().append('path').attr(this.attrSegmentStroke(options)).attr({
      d: arc,
      transform: this.attrTranslateToCenter(),
      fill: function(d, i) {
        return colors[i];
      }
    });
  };

  D3Doughnut.prototype.render = function() {
    var arc, height, innerRadius, margin, outerRadius, path, width;
    width = this.getRootElementWidth();
    height = this.getRootElementHeight();
    margin = 5;
    outerRadius = ~~(Math.min(width, height) / 2 - margin);
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

  return D3Doughnut;

})(Chart.D3Chart);

var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Chart.D3Pie = (function(_super) {
  __extends(D3Pie, _super);

  function D3Pie(selectors, data, options) {
    D3Pie.__super__.constructor.call(this, selectors, data, options);
  }

  D3Pie.prototype.render = function() {
    return this;
  };

  return D3Pie;

})(Chart.D3Chart);
