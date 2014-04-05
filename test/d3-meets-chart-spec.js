var Chart, chai, expect;

Chart = require('../src/d3-meets-chart').Chart;

chai = require('chai');

expect = chai.expect;

describe('Chart', function() {
  describe('::constructor', function() {
    context('when an argument is valid', function() {
      return it('should contains the element name in the returned object', function() {
        var chart;
        chart = new Chart('#root-svg');
        return expect(chart.selector).to.eq('#root-svg');
      });
    });
    return context('when an argument is invalid', function() {
      return it('should raise TypeError exception', function() {
        var message;
        message = 'This argument is not a selector string';
        return expect(function() {
          return new Chart(null);
        }).to["throw"](TypeError, message);
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
    context('when an argument is valid', function() {
      return it('should returns the easing type name', function() {
        return expect(this.chart.getEasingType('easeInExpo')).to.eq('exp-in');
      });
    });
    return context('when an argument is invalid', function() {
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
  });
  return describe('::mergeOptions', function() {
    before(function() {
      this.chart = new Chart('#svg');
      return this.defaults = {
        foo: 'foo',
        animationEasing: 'easeInExpo'
      };
    });
    context('when arguments are valid', function() {
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
    return context('when arguments are invalid', function() {
      return it('should returns the defaults object', function() {
        var options;
        options = null;
        return expect(this.chart.mergeOptions(this.defaults, options)).to.eql({
          foo: 'foo',
          animationEasing: 'exp-in'
        });
      });
    });
  });
});
