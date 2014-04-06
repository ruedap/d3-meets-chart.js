describe 'Chart.D3Bar', ->
  before ->
    @data =
      labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July']
      datasets: [
        fillColor: 'rgba(220,220,220,0.5)'
        strokeColor: 'rgba(220,220,220,1)'
        data: [65, 59, 90, 81, 56, 55, 40]
      ,
        fillColor: 'rgba(151,187,205,0.5)'
        strokeColor: 'rgba(151,187,205,1)'
        data: [28, 48, 40, 19, 96, 27, 100]
      ]
    @d3Bar = new Chart.D3Bar '#svg', @data, {}

  describe '::constructor', ->
    it 'should the instance object has same value in properties', ->
      expect(@d3Bar.selectors).to.eq '#svg'
      expect(@d3Bar.data).to.eql @data
      expect(@d3Bar.options).to.eql {}

  describe '::Bar', ->
    it 'pending'
