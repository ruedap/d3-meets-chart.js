var Chart;

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
    config = this.Doughnut.defaults;
    return new Chart.D3Doughnut(data, config, this.element);
  };

  return Chart;

})();

Chart.D3Doughnut = (function() {
  function D3Doughnut(data, config, element) {
    this.data = data;
    this.config = config;
    this.element = element;
  }

  return D3Doughnut;

})();
