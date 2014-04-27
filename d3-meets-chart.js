(function() {
  var __slice = [].slice;

  this.Chart = (function() {
    'use strict';
    Chart.Util = (function() {
      function Util() {}

      Util.extend = function() {
        var dest, key, source, sources, value, _i, _len;
        dest = arguments[0], sources = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
        for (_i = 0, _len = sources.length; _i < _len; _i++) {
          source = sources[_i];
          for (key in source) {
            value = source[key];
            dest[key] = value;
          }
        }
        return dest;
      };

      Util.is = function(type, obj) {
        var klass;
        klass = Object.prototype.toString.call(obj).slice(8, -1);
        return obj !== void 0 && obj !== null && klass === type;
      };

      return Util;

    })();

    function Chart(selectors) {
      this.selectors = selectors;
      if (!Chart.Util.is('String', this.selectors)) {
        throw new TypeError('This argument is not selectors string');
      }
    }

    Chart.prototype.Bar = function(data, options) {
      var mergedOptions;
      this.validateData(data);
      this.Bar.defaults = {
        scaleOverlay: false,
        scaleOverride: false,
        scaleSteps: null,
        scaleStepWidth: null,
        scaleStartValue: null,
        scaleLineColor: 'rgba(0,0,0,.1)',
        scaleLineWidth: 1,
        scaleShowLabels: true,
        scaleLabel: '<%=value%>',
        scaleFontFamily: "'Arial'",
        scaleFontSize: 12,
        scaleFontStyle: 'normal',
        scaleFontColor: '#666',
        scaleShowGridLines: true,
        scaleGridLineColor: 'rgba(0,0,0,.05)',
        scaleGridLineWidth: 1,
        barShowStroke: true,
        barStrokeWidth: 2,
        barValueSpacing: 5,
        barDatasetSpacing: 1,
        animation: true,
        animationSteps: 60,
        animationEasing: 'easeOutQuad',
        onAnimationComplete: null
      };
      mergedOptions = this.mergeOptions(this.Bar.defaults, options);
      return new Chart.D3Bar(this.selectors, data, mergedOptions).render();
    };

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

    Chart.prototype.Line = function(data, options) {
      var mergedOptions;
      this.validateData(data);
      this.Line.defaults = {
        scaleOverlay: false,
        scaleOverride: false,
        scaleSteps: null,
        scaleStepWidth: null,
        scaleStartValue: null,
        scaleLineColor: 'rgba(0,0,0,.1)',
        scaleLineWidth: 1,
        scaleShowLabels: true,
        scaleLabel: '<%=value%>',
        scaleFontFamily: "'Arial'",
        scaleFontSize: 12,
        scaleFontStyle: 'normal',
        scaleFontColor: '#666',
        scaleShowGridLines: true,
        scaleGridLineColor: 'rgba(0,0,0,.05)',
        scaleGridLineWidth: 1,
        bezierCurve: true,
        pointDot: true,
        pointDotRadius: 4,
        pointDotStrokeWidth: 2,
        datasetStroke: true,
        datasetStrokeWidth: 2,
        datasetFill: true,
        animation: true,
        animationSteps: 60,
        animationEasing: 'easeOutQuad',
        onAnimationComplete: null
      };
      mergedOptions = this.mergeOptions(this.Line.defaults, options);
      return new Chart.D3Line(this.selectors, data, mergedOptions).render();
    };

    Chart.prototype.Pie = function(data, options) {
      var mergedOptions;
      this.validateData(data);
      this.Pie.defaults = {
        segmentShowStroke: true,
        segmentStrokeColor: '#fff',
        segmentStrokeWidth: 2,
        animation: true,
        animationSteps: 100,
        animationEasing: 'easeOutBounce',
        animateRotate: true,
        animateScale: false,
        onAnimationComplete: null
      };
      mergedOptions = this.mergeOptions(this.Pie.defaults, options);
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
      var mo;
      mo = Chart.Util.extend({}, defaults, options);
      mo.animationEasing = this.getEasingType(mo.animationEasing);
      return mo;
    };

    Chart.prototype.validateData = function(data) {
      if (!(Chart.Util.is('Array', data) || Chart.Util.is('Object', data))) {
        throw new TypeError("" + data + " is not an array or object");
      }
    };

    return Chart;

  })();

}).call(this);

(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  Chart.D3Chart = (function() {
    'use strict';
    D3Chart.xAxis = function(xScale, ticks) {
      if (ticks == null) {
        ticks = 10;
      }
      return d3.svg.axis().scale(xScale).ticks(ticks).tickSize(3, 3).tickPadding(5).orient('bottom');
    };

    D3Chart.yAxis = function(yScale) {
      return d3.svg.axis().scale(yScale).ticks(20).tickSize(3, 0).tickPadding(7).orient('left');
    };

    function D3Chart(selectors, data, options, margin) {
      this.selectors = selectors;
      this.data = data;
      this.options = options;
      this.updateScaleTextStyle = __bind(this.updateScaleTextStyle, this);
      this.updateScaleStrokeStyle = __bind(this.updateScaleStrokeStyle, this);
      this.updateGridTickStyle = __bind(this.updateGridTickStyle, this);
      this.renderYAxis = __bind(this.renderYAxis, this);
      this.renderXAxis = __bind(this.renderXAxis, this);
      this.renderGrid = __bind(this.renderGrid, this);
      this.renderYGrid = __bind(this.renderYGrid, this);
      this.renderXGrid = __bind(this.renderXGrid, this);
      this.getTransitionElement = __bind(this.getTransitionElement, this);
      this.getRootElementWidth = __bind(this.getRootElementWidth, this);
      this.getRootElementHeight = __bind(this.getRootElementHeight, this);
      this.getRootElement = __bind(this.getRootElement, this);
      this.attrTranslateToCenter = __bind(this.attrTranslateToCenter, this);
      margin || (margin = {
        top: 0,
        right: 0,
        bottom: 0,
        left: 0
      });
      this.defineRootElement(this.getRootElement(), this.getRootElementWidth(), this.getRootElementHeight(), margin);
    }

    D3Chart.prototype.attrTranslateToCenter = function() {
      var halfHeight, halfWidth;
      halfWidth = this.getRootElementWidth() / 2;
      halfHeight = this.getRootElementHeight() / 2;
      return "translate(" + halfWidth + ", " + halfHeight + ")";
    };

    D3Chart.prototype.defineRootElement = function(element, width, height, margin) {
      this.width = width - margin.left - margin.right;
      this.height = height - margin.top - margin.bottom;
      return this.getRootElement().attr({
        width: this.width + margin.left + margin.right
      }).attr({
        height: this.height + margin.top + margin.bottom
      }).append('g').attr({
        transform: "translate(" + margin.left + "," + margin.top + ")"
      }).classed({
        'margin-convention-element': true
      });
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
      return +(this.getRootElement().attr('height'));
    };

    D3Chart.prototype.getRootElementWidth = function() {
      return +(this.getRootElement().attr('width'));
    };

    D3Chart.prototype.getTransitionElement = function(duration, options) {
      return this.getRootElement().transition().duration(duration).ease(options.animationEasing);
    };

    D3Chart.prototype.renderXGrid = function(x0Scale, chartHeight) {
      var x;
      x = x0Scale.rangeBand() / 2;
      return this.getRootElement().select('.margin-convention-element').append('g').classed({
        'grid-group': true,
        'grid-x-group': true
      }).call(D3Chart.xAxis(x0Scale).tickFormat('')).selectAll('.tick line').attr({
        x1: x,
        x2: x,
        y2: chartHeight
      });
    };

    D3Chart.prototype.renderYGrid = function(yScale, chartWidth) {
      return this.getRootElement().select('.margin-convention-element').append('g').classed({
        'grid-group': true,
        'grid-y-group': true
      }).call(D3Chart.yAxis(yScale).tickFormat('')).selectAll('.tick line').attr({
        x1: 0,
        x2: chartWidth
      });
    };

    D3Chart.prototype.renderGrid = function() {
      return this.getRootElement().selectAll('.grid-group').selectAll('.domain, text').data([]).exit().remove();
    };

    D3Chart.prototype.renderXAxis = function(xScale, chartHeight) {
      return this.getRootElement().select('.margin-convention-element').append('g').classed({
        'scale-group': true,
        'scale-x-group': true
      }).attr('transform', "translate(0," + chartHeight + ")").call(D3Chart.xAxis(xScale));
    };

    D3Chart.prototype.renderYAxis = function(yScale) {
      return this.getRootElement().select('.margin-convention-element').append('g').classed({
        'scale-group': true,
        'scale-y-group': true
      }).call(D3Chart.yAxis(yScale)).select('.tick > text').remove();
    };

    D3Chart.prototype.updateGridTickStyle = function(options) {
      return this.getRootElement().selectAll('.grid-group .tick line').attr({
        stroke: options.scaleGridLineColor
      });
    };

    D3Chart.prototype.updateScaleStrokeStyle = function(options) {
      return this.getRootElement().selectAll('.scale-group').selectAll('.domain, .tick line').attr({
        fill: 'none'
      }).attr({
        stroke: options.scaleLineColor
      }).attr({
        'stroke-width': options.scaleLineWidth
      });
    };

    D3Chart.prototype.updateScaleTextStyle = function(options) {
      return this.getRootElement().selectAll('.scale-group text').attr({
        'font-family': options.scaleFontFamily
      }).attr({
        'font-size': options.scaleFontSize
      }).attr({
        'font-style': options.scaleFontStyle
      }).attr({
        'fill': options.scaleFontColor
      });
    };

    return D3Chart;

  })();

}).call(this);

(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Chart.D3Pie = (function(_super) {
    'use strict';
    __extends(D3Pie, _super);

    function D3Pie(selectors, data, options) {
      this.transitionEndAll = __bind(this.transitionEndAll, this);
      D3Pie.__super__.constructor.call(this, selectors, data, options);
    }

    D3Pie.prototype.animateRotate = function(path, arc, options) {
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

    D3Pie.prototype.animateScale = function(options) {
      if (!(options.animation && options.animateScale)) {
        return;
      }
      return this.getRootElement().selectAll('g').attr({
        transform: "" + (this.attrTranslateToCenter()) + " scale(0)"
      }).transition().call(this.transitionEndAll, options).duration(this.duration()).ease(options.animationEasing).attr({
        transform: 'scale(1)'
      });
    };

    D3Pie.prototype.attrSegmentStroke = function(options) {
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

    D3Pie.prototype.drawChart = function(arc, options) {
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

    D3Pie.prototype.getOuterRadius = function(width, height, margin) {
      return ~~(Math.min(width, height) / 2 - margin);
    };

    D3Pie.prototype.getInnerRadius = function(outerRadius, options) {
      return 0;
    };

    D3Pie.prototype.render = function() {
      var arc, height, innerRadius, margin, outerRadius, path, width;
      width = this.getRootElementWidth();
      height = this.getRootElementHeight();
      margin = 5;
      outerRadius = this.getOuterRadius(width, height, margin);
      innerRadius = this.getInnerRadius(outerRadius, this.options);
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

    D3Pie.prototype.setAnimationComplete = function(options) {
      if (typeof options.onAnimationComplete !== 'function') {
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

    D3Pie.prototype.transitionEndAll = function(transition, options) {
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

    return D3Pie;

  })(Chart.D3Chart);

}).call(this);

(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Chart.D3Bar = (function(_super) {
    'use strict';
    __extends(D3Bar, _super);

    D3Bar.adjustRangeBand = function(rangeBand) {
      return rangeBand - 1;
    };

    D3Bar.rectBorderPath = function(datum, i, chartHeight, x1Scale, yScale, options) {
      var _ch, _data, _swh, _w, _x, _y;
      _ch = chartHeight;
      _swh = options.barStrokeWidth / 2;
      _x = x1Scale(i);
      _w = D3Bar.adjustRangeBand(x1Scale.rangeBand());
      _y = yScale(datum.value) + _swh;
      _data = [
        {
          x: _x + _swh,
          y: _ch
        }, {
          x: _x + _swh,
          y: _y
        }, {
          x: _x + _w - _swh,
          y: _y
        }, {
          x: _x + _w - _swh,
          y: _ch
        }
      ];
      return d3.svg.line().x(function(d) {
        return d.x;
      }).y(function(d) {
        return d.y;
      })(_data);
    };

    D3Bar.xScale = function(domain, max) {
      return d3.scale.ordinal().domain(domain).rangeRoundBands([0, max], 0, 0);
    };

    D3Bar.yScale = function(data, max, min) {
      var maxY;
      if (min == null) {
        min = 0;
      }
      maxY = d3.max(data, function(d) {
        return d3.max(d.values, function(d) {
          return d.value;
        });
      });
      return d3.scale.linear().domain([0, maxY]).range([max, min]).nice();
    };

    function D3Bar(selectors, data, options) {
      this.transitBarBorder = __bind(this.transitBarBorder, this);
      this.transitBar = __bind(this.transitBar, this);
      this.renderBarBorder = __bind(this.renderBarBorder, this);
      this.renderBar = __bind(this.renderBar, this);
      this.renderBars = __bind(this.renderBars, this);
      this.render = __bind(this.render, this);
      var margin;
      margin = {
        top: 13,
        right: 23,
        bottom: 24,
        left: 55
      };
      D3Bar.__super__.constructor.call(this, selectors, data, options, margin);
    }

    D3Bar.prototype.generateData = function(labels, datasets) {
      var array;
      if (!((labels != null) && (datasets != null))) {
        return null;
      }
      array = [];
      datasets.forEach(function(ds) {
        return ds.data.map(function(d, i) {
          return array.push({
            value: d,
            label: labels[i],
            fillColor: ds.fillColor,
            strokeColor: ds.strokeColor
          });
        });
      });
      return d3.nest().key(function(d) {
        return d.label;
      }).entries(array);
    };

    D3Bar.prototype.render = function() {
      var chartHeight, chartWidth, data, datasets, el, labels, options, x0Scale, x1Scale, yScale, _domain, _max;
      labels = this.data.labels;
      datasets = this.data.datasets;
      data = this.generateData(labels, datasets);
      if (!((data != null) || ((data != null ? data.length : void 0) != null))) {
        return this;
      }
      options = this.options;
      chartWidth = this.width;
      chartHeight = this.height;
      x0Scale = D3Bar.xScale(labels, chartWidth);
      _domain = d3.range(datasets.length);
      _max = x0Scale.rangeBand() - (options.barValueSpacing * 2);
      x1Scale = D3Bar.xScale(_domain, _max);
      yScale = D3Bar.yScale(data, chartHeight);
      this.renderXGrid(x0Scale, chartHeight);
      this.renderYGrid(yScale, chartWidth);
      this.renderGrid();
      this.renderXAxis(x0Scale, chartHeight);
      this.renderYAxis(yScale);
      this.renderBars(data, x0Scale, options);
      this.renderBar(chartHeight, x1Scale, yScale, options);
      this.renderBarBorder(chartHeight, x1Scale, yScale, options);
      this.updateGridTickStyle(options);
      this.updateScaleStrokeStyle(options);
      this.updateScaleTextStyle(options);
      el = this.getTransitionElement(this.duration(), options);
      this.transitBar(el, chartHeight, yScale);
      this.transitBarBorder(el, chartHeight);
      return this;
    };

    D3Bar.prototype.renderBars = function(data, x0Scale, options) {
      return this.getRootElement().select('.margin-convention-element').append('g').classed('bar-chart', true).selectAll('.bars-group').data(data).enter().append('g').classed('bars-group', true).attr('transform', function(d) {
        return "translate(" + (x0Scale(d.key) + options.barValueSpacing) + ",0)";
      });
    };

    D3Bar.prototype.renderBar = function(chartHeight, x1Scale, yScale, options) {
      return this.getRootElement().selectAll('.bars-group').selectAll('rect').data(function(d, i) {
        return d.values;
      }).enter().append('g').classed('bar-group', true).append('rect').classed('bar', true).attr('x', function(d, i) {
        return x1Scale(i);
      }).attr('width', D3Bar.adjustRangeBand(x1Scale.rangeBand())).attr('y', function(d, i) {
        return yScale(d.value);
      }).attr('height', function(d) {
        return chartHeight - yScale(d.value);
      }).attr('fill', function(d) {
        return d.fillColor;
      });
    };

    D3Bar.prototype.renderBarBorder = function(chartHeight, x1Scale, yScale, options) {
      return this.getRootElement().selectAll('.bars-group').selectAll('.bar-group').append('path').classed('bar-border', true).attr('d', function(d, i) {
        return D3Bar.rectBorderPath(d, i, chartHeight, x1Scale, yScale, options);
      }).attr('fill', 'none').attr('stroke', function(d) {
        return d.strokeColor;
      }).attr('stroke-width', options.barStrokeWidth);
    };

    D3Bar.prototype.transitBar = function(el, chartHeight, yScale) {
      this.getRootElement().selectAll('.bar').attr('y', chartHeight).attr('height', 0);
      return el.selectAll('.bar').attr('y', function(d, i) {
        return yScale(d.value);
      }).attr('height', function(d) {
        return chartHeight - yScale(d.value);
      });
    };

    D3Bar.prototype.transitBarBorder = function(el, chartHeight) {
      this.getRootElement().selectAll('.bar-border').attr('transform', "translate(0," + chartHeight + ") scale(1,0)");
      return el.selectAll('.bar-border').attr('transform', 'translate(0,0) scale(1,1)');
    };

    return D3Bar;

  })(Chart.D3Chart);

}).call(this);

(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Chart.D3Doughnut = (function(_super) {
    'use strict';
    __extends(D3Doughnut, _super);

    function D3Doughnut(selectors, data, options) {
      D3Doughnut.__super__.constructor.call(this, selectors, data, options);
    }

    D3Doughnut.prototype.getInnerRadius = function(outerRadius, options) {
      return ~~(outerRadius * (options.percentageInnerCutout / 100));
    };

    return D3Doughnut;

  })(Chart.D3Pie);

}).call(this);

(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Chart.D3Line = (function(_super) {
    'use strict';
    __extends(D3Line, _super);

    D3Line.area = function(xScale, yScale, labels, options, chartHeight) {
      var interpolate;
      interpolate = options.bezierCurve ? D3Line.bezierCurve : 'linear';
      return d3.svg.area().x(function(d, i) {
        return xScale(labels[i]);
      }).y0(chartHeight).y1(function(d) {
        return yScale(d);
      }).interpolate(interpolate);
    };

    D3Line.bezierCurve = function(points) {
      var d, f;
      f = points.shift();
      d = "" + f[0] + " " + f[1];
      points.forEach(function(p) {
        var m;
        m = (p[0] - f[0]) / 2;
        d += " C " + (f[0] + m) + " " + f[1] + " " + (p[0] - m) + " " + p[1] + " " + p[0] + " " + p[1];
        return f = p;
      });
      return d;
    };

    D3Line.line = function(xScale, yScale, labels, options) {
      var interpolate;
      interpolate = options.bezierCurve ? D3Line.bezierCurve : 'linear';
      return d3.svg.line().x(function(d, i) {
        return xScale(labels[i]);
      }).y(function(d) {
        return yScale(d);
      }).interpolate(interpolate);
    };

    D3Line.xScale = function(domain, max) {
      return d3.scale.ordinal().domain(domain).rangePoints([0, max], 0, 0);
    };

    D3Line.yScale = function(data, max, min) {
      var maxY;
      if (min == null) {
        min = 0;
      }
      maxY = d3.max(data, function(d) {
        return d3.max(d.data);
      });
      return d3.scale.linear().domain([0, maxY]).range([max, min]).nice();
    };

    function D3Line(selectors, data, options) {
      this.transitLines = __bind(this.transitLines, this);
      this.transitDots = __bind(this.transitDots, this);
      this.transitAreas = __bind(this.transitAreas, this);
      this.renderLines = __bind(this.renderLines, this);
      this.renderDots = __bind(this.renderDots, this);
      this.renderAreas = __bind(this.renderAreas, this);
      this.renderLinesGroup = __bind(this.renderLinesGroup, this);
      this.render = __bind(this.render, this);
      var margin;
      margin = {
        top: 13,
        right: 23,
        bottom: 24,
        left: 55
      };
      D3Line.__super__.constructor.call(this, selectors, data, options, margin);
    }

    D3Line.prototype.render = function() {
      var area, chartHeight, chartWidth, data, el, labels, line, options, strokeWidth, xScale, yScale;
      labels = this.data.labels;
      data = this.data.datasets;
      if (!((data != null) || ((data != null ? data.length : void 0) != null))) {
        return this;
      }
      options = this.options;
      strokeWidth = this.options.barStrokeWidth;
      chartWidth = this.width;
      chartHeight = this.height;
      xScale = D3Line.xScale(labels, chartWidth);
      yScale = D3Line.yScale(data, chartHeight);
      this.renderXGrid(xScale, chartHeight);
      this.renderYGrid(yScale, chartWidth);
      this.renderGrid();
      this.renderXAxis(xScale, chartHeight);
      this.renderYAxis(yScale);
      this.renderLinesGroup(data);
      area = D3Line.area(xScale, yScale, labels, options, chartHeight);
      this.renderAreas(area, data, options);
      line = D3Line.line(xScale, yScale, labels, options);
      this.renderLines(line, data, options);
      this.renderDots(data, labels, xScale, yScale, options);
      this.updateGridTickStyle(options);
      this.updateScaleStrokeStyle(options);
      this.updateScaleTextStyle(options);
      el = this.getTransitionElement(this.duration(), options);
      this.transitAreas(el, chartHeight);
      this.transitLines(el, chartHeight);
      this.transitDots(el, chartHeight, yScale);
      return this;
    };

    D3Line.prototype.renderLinesGroup = function(data) {
      return this.getRootElement().select('.margin-convention-element').append('g').classed('line-chart', true).append('g').classed('lines-group', true).selectAll('g').data(data).enter().append('g').classed('line-group', true);
    };

    D3Line.prototype.renderAreas = function(area, data, options) {
      if (!options.datasetFill) {
        return null;
      }
      return this.getRootElement().selectAll('.line-group').data(data).append('path').classed('area', true).attr('d', function(d) {
        return area(d.data);
      }).attr('stroke', 'none').attr('fill', function(d) {
        return d.fillColor;
      });
    };

    D3Line.prototype.renderDots = function(data, labels, xScale, yScale, options) {
      var dataset;
      if (!options.pointDot) {
        return null;
      }
      dataset = data.map(function(d1) {
        return d1.data.map(function(d2) {
          return {
            value: d2,
            fillColor: d1.fillColor,
            strokeColor: d1.strokeColor,
            pointColor: d1.pointColor,
            pointStrokeColor: d1.pointStrokeColor
          };
        });
      });
      return this.getRootElement().selectAll('.line-group').data(dataset).selectAll('.dot').data(function(d) {
        return d;
      }).enter().append('circle').classed({
        dot: true
      }).attr({
        r: options.pointDotRadius
      }).attr('cx', function(d, i) {
        return xScale(labels[i]);
      }).attr('cy', function(d) {
        return yScale(d.value);
      }).attr('stroke', function(d, i) {
        return d.pointStrokeColor;
      }).attr('stroke-width', options.pointDotStrokeWidth).attr('fill', function(d, i) {
        return d.pointColor;
      });
    };

    D3Line.prototype.renderLines = function(line, data, options) {
      return this.getRootElement().selectAll('.line-group').data(data).append('path').classed('line', true).attr('d', function(d) {
        return line(d.data);
      }).attr('stroke', function(d) {
        return d.strokeColor;
      }).attr('stroke-width', options.datasetStrokeWidth).attr('fill', 'none');
    };

    D3Line.prototype.transitAreas = function(el, chartHeight) {
      this.getRootElement().selectAll('.area').attr('transform', "translate(0," + chartHeight + ") scale(1,0)");
      return el.selectAll('.area').attr('transform', 'translate(0,0) scale(1,1)');
    };

    D3Line.prototype.transitDots = function(el, chartHeight, yScale) {
      this.getRootElement().selectAll('.dot').attr('cy', chartHeight);
      return el.selectAll('.dot').attr('cy', function(d, i) {
        return yScale(d.value);
      });
    };

    D3Line.prototype.transitLines = function(el, chartHeight) {
      this.getRootElement().selectAll('.line').attr('transform', "translate(0," + chartHeight + ") scale(1,0)");
      return el.selectAll('.line').attr('transform', 'translate(0,0) scale(1,1)');
    };

    return D3Line;

  })(Chart.D3Chart);

}).call(this);
