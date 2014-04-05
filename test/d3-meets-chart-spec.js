var Chart, chai, expect;

chai = require('chai');

expect = chai.expect;

Chart = require('../src/d3-meets-chart').Chart;

describe('Chart', function() {
  return describe('::constructor', function() {
    context('when arguments is valid', function() {
      return it('should contains the element name in the returned object', function() {
        var chart;
        chart = new Chart('#root-svg');
        return expect(chart.selector).to.eq('#root-svg');
      });
    });
    return context('when arguments is invalid', function() {
      return it('should raise TypeError exception', function() {
        var message;
        message = 'This argument is not a selector string';
        return expect(function() {
          return new Chart(null);
        }).to["throw"](TypeError, message);
      });
    });
  });
});
