beforeEach ->
  d3.select('body')
    .append('svg')
    .attr
      id: 'svg'
      width: 600
      height: 450

afterEach ->
  d3.selectAll('svg')
    .remove()
