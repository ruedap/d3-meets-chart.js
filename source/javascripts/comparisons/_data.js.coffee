@exports =
  comparisons:
    chart_names: ['bar', 'line', 'pie', 'doughnut', 'radar', 'polar']
    delay: (func) -> setTimeout func, 200
    bar:
      id:
        original: 'js-comparison--bar-chart__chart--original'
        alternative: '#js-comparison--bar-chart__chart--alternative'
      data:
        labels : ["January","February","March","April","May","June","July"],
        datasets : [
          {
            fillColor: "rgba(220,220,220,0.5)",
            strokeColor: "rgba(220,220,220,1)",
            data: [65,59,90,81,56,55,40]
          },
          {
            fillColor: "rgba(151,187,205,0.5)",
            strokeColor: "rgba(151,187,205,1)",
            data: [28,48,40,19,96,27,100]
          }
        ]
    line:
      id:
        original: 'js-comparison--line-chart__chart--original'
        alternative: '#js-comparison--line-chart__chart--alternative'
      data:
        labels : ["January","February","March","April","May","June","July"],
        datasets : [
          {
            fillColor : "rgba(220,220,220,0.5)",
            strokeColor : "rgba(220,220,220,1)",
            pointColor : "rgba(220,220,220,1)",
            pointStrokeColor : "#fff",
            data : [65,59,90,81,56,55,40]
          },
          {
            fillColor : "rgba(151,187,205,0.5)",
            strokeColor : "rgba(151,187,205,1)",
            pointColor : "rgba(151,187,205,1)",
            pointStrokeColor : "#fff",
            data : [28,48,40,19,96,27,100]
          }
        ]
    pie:
      id:
        original: 'js-comparison--pie-chart__chart--original'
        alternative: '#js-comparison--pie-chart__chart--alternative'
      data: [
        {
          value : 30,
          color :"#f38630"
        },
        {
          value : 50,
          color : "#e0e4cc"
        },
        {
          value : 100,
          color : "#69D2E7"
        }
      ]
    doughnut:
      id:
        original: 'js-comparison--doughnut-chart__chart--original'
        alternative: '#js-comparison--doughnut-chart__chart--alternative'
      data: [
        {
          value : 30,
          color :"#F7464A"
        },
        {
          value : 50,
          color : "#46BFBD"
        },
        {
          value : 100,
          color : "#FDB45C"
        },
        {
          value : 40,
          color : "#949FB1"
        },
        {
          value : 120,
          color : "#4D5360"
        }
      ]
    radar:
      id:
        original: 'js-comparison--radar-chart__chart--original'
        alternative: '#js-comparison--radar-chart__chart--alternative'
      data:
        labels : ["Eating","Drinking","Sleeping","Designing","Coding","Partying","Running"]
        datasets : [
          {
            fillColor : "rgba(220,220,220,0.5)",
            strokeColor : "rgba(220,220,220,1)",
            pointColor : "rgba(220,220,220,1)",
            pointStrokeColor : "#fff",
            data : [65,59,90,81,56,55,40]
          },
          {
            fillColor : "rgba(151,187,205,0.5)",
            strokeColor : "rgba(151,187,205,1)",
            pointColor : "rgba(151,187,205,1)",
            pointStrokeColor : "#fff",
            data : [28,48,40,19,96,27,100]
          }
        ]
    polar:
      id:
        original: 'js-comparison--polar-chart__chart--original'
        alternative: '#js-comparison--polar-chart__chart--alternative'
      data: [
        value : Math.random()
        color: "#D97041"
      ,
        value : Math.random()
        color: "#C7604C"
      ,
        value : Math.random()
        color: "#21323D"
      ,
        value : Math.random()
        color: "#9D9B7F"
      ,
        value : Math.random()
        color: "#7D4F6D"
      ,
        value : Math.random()
        color: "#584A5E"
      ]
