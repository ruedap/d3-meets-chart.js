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
    mergedOptions = this.mergeOptions(this.Doughnut.defaults, options);
    return new Chart.D3Doughnut(this.element, data, mergedOptions);
  };

  Chart.prototype.mergeOptions = function(defaults, options) {
    var mergedOptions;
    mergedOptions = _.extend({}, defaults, options);
    mergedOptions.animationEasing = this.getEasingType(mergedOptions.animationEasing);
    return mergedOptions;
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

  return Chart;

})();

Chart.D3Doughnut = (function() {
  function D3Doughnut(element, data, options) {
    var arc, innerRadius, margin, outerRadius, path;
    this.element = element;
    this.data = data;
    this.translateToCenter = __bind(this.translateToCenter, this);
    this.transitionEndAll = __bind(this.transitionEndAll, this);
    this.rootSvgHeight = __bind(this.rootSvgHeight, this);
    this.rootSvgWidth = __bind(this.rootSvgWidth, this);
    this.rootSvg = __bind(this.rootSvg, this);
    margin = 5;
    outerRadius = ~~(Math.min(this.rootSvgWidth(), this.rootSvgHeight()) / 2 - margin);
    innerRadius = ~~(outerRadius * (options.percentageInnerCutout / 100));
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
