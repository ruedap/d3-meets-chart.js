var Chart, chai, expect;

chai = require('chai');

expect = chai.expect;

Chart = require("../src/d3-meets-chart").Chart;

describe('Chart', function() {
  return describe('::constructor', function() {
    return describe('when arguments is valid', function() {
      return it('contains the element name in the returned object', function() {
        var chart;
        chart = new Chart('#root-svg');
        return expect(chart.element).to.eq('#root-svg');
      });
    });
  });
});
