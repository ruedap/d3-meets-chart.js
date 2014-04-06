var Chart, chai, expect, _;

Chart = require('../src/d3-meets-chart').Chart;

chai = require('chai');

expect = chai.expect;

_ = require('underscore');

describe('Chart', function() {
  describe('::constructor', function() {
    context('when an argument is invalid', function() {
      return it('should raise TypeError exception', function() {
        var message;
        message = 'This argument is not a selector string';
        return expect(function() {
          return new Chart(null);
        }).to["throw"](TypeError, message);
      });
    });
    return context('when an argument is valid', function() {
      return it('should contains the element name in the returned object', function() {
        var chart;
        chart = new Chart('#root-svg');
        return expect(chart.selector).to.eq('#root-svg');
      });
    });
  });
  describe('::Doughnut', function() {
    return it('pending');
  });
  describe('::getEasingType', function() {
    before(function() {
      this.chart = new Chart('#svg');
      return this.errorMessage = function(easingType) {
        return "'" + easingType + "' is not a easing type name";
      };
    });
    context('when an argument is invalid', function() {
      context('when an argument is string', function() {
        return it('should raise ReferenceError exception', function() {
          return expect((function(_this) {
            return function() {
              return _this.chart.getEasingType('foo');
            };
          })(this)).to["throw"](ReferenceError, this.errorMessage('foo'));
        });
      });
      return context('when an argument is not string', function() {
        return it('should raise ReferenceError exception', function() {
          return expect((function(_this) {
            return function() {
              return _this.chart.getEasingType(null);
            };
          })(this)).to["throw"](ReferenceError, this.errorMessage('null'));
        });
      });
    });
    return context('when an argument is valid', function() {
      return it('should returns the easing type name', function() {
        return expect(this.chart.getEasingType('easeInExpo')).to.eq('exp-in');
      });
    });
  });
  return describe('::mergeOptions', function() {
    before(function() {
      this.chart = new Chart('#svg');
      return this.defaults = {
        foo: 'foo',
        animationEasing: 'easeInExpo'
      };
    });
    context('when arguments are invalid', function() {
      return it('should returns the defaults object', function() {
        var options;
        options = null;
        return expect(this.chart.mergeOptions(this.defaults, options)).to.eql({
          foo: 'foo',
          animationEasing: 'exp-in'
        });
      });
    });
    return context('when arguments are valid', function() {
      return it('should returns the merged object', function() {
        var options;
        options = {
          foo: 'bar'
        };
        return expect(this.chart.mergeOptions(this.defaults, options)).to.eql({
          foo: 'bar',
          animationEasing: 'exp-in'
        });
      });
    });
  });
});

describe('Chart.D3Doughnut', function() {
  before(function() {
    return this.d3doughnut = new Chart.D3Doughnut('#svg', [], {});
  });
  describe('::constructor', function() {
    return it('pending');
  });
  describe('::animateRotate', function() {
    return it('pending');
  });
  describe('::animateScale', function() {
    return it('pending');
  });
  describe('::attrSegmentStroke', function() {
    return it('pending');
  });
  describe('::drawChart', function() {
    return it('pending');
  });
  describe('::duration', function() {
    return it('should returns number', function() {
      var options;
      options = {
        animationSteps: 100
      };
      return expect(this.d3doughnut.duration(options)).to.eq(1733.2999999999997);
    });
  });
  describe('::render', function() {
    return it('pending');
  });
  describe('::rootSvg', function() {
    return it('pending');
  });
  describe('::rootSvgHeight', function() {
    return it('pending');
  });
  describe('::rootSvgWidth', function() {
    return it('pending');
  });
  describe('::setAnimationComplete', function() {
    context('when an argument is invalid', function() {
      return it('should returns undefined', function() {
        var options;
        options = {};
        return expect(this.d3doughnut.setAnimationComplete(options)).to.be.undefined;
      });
    });
    return context('when an argument is valid', function() {
      before(function() {
        return this.options = {
          onAnimationComplete: function() {
            return 'foo';
          }
        };
      });
      context('when all of options are true value', function() {
        return it('should returns 2', function() {
          var options;
          options = {
            animation: true,
            animateRotate: true,
            animateScale: true
          };
          options = _.extend({}, this.options, options);
          return expect(this.d3doughnut.setAnimationComplete(options)).to.eq(2);
        });
      });
      context('when `animation` is true value', function() {
        return context('when any one of `animateRotate` or `animateScale` are true value', function() {
          it('should returns 1', function() {
            var options;
            options = {
              animation: true,
              animateRotate: true,
              animateScale: false
            };
            options = _.extend({}, this.options, options);
            return expect(this.d3doughnut.setAnimationComplete(options)).to.eq(1);
          });
          return it('should returns 1', function() {
            var options;
            options = {
              animation: true,
              animateRotate: false,
              animateScale: true
            };
            options = _.extend({}, this.options, options);
            return expect(this.d3doughnut.setAnimationComplete(options)).to.eq(1);
          });
        });
      });
      return context('when `animation` is false value', function() {
        return it('should returns NaN', function() {
          var actual, options;
          options = {
            animation: false,
            animateRotate: true,
            animateScale: true
          };
          options = _.extend({}, this.options, options);
          actual = this.d3doughnut.setAnimationComplete(options);
          return expect(isNaN(actual)).to.be["true"];
        });
      });
    });
  });
  describe('::transitionEndAll', function() {
    return it('pending');
  });
  return describe('::translateToCenter', function() {
    return it('pending');
  });
});
