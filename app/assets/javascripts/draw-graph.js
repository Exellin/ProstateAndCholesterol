$(document).ready(function() {
  var regex = /profiles\/\d+$/;
  if($(location).attr('pathname').match(regex)) {
    drawGraph('psa', 'psa', 'PSA');
    drawGraph('total_cholesterol', 'totalcholesterol', 'Total Cholesterol');
    drawGraph('hdl', 'hdl', 'HDL');
    drawGraph('ldl', 'ldl', 'LDL');
    drawGraph('triglyceride', 'triglyceride', 'Triglyceride');
    drawGraph('glucose', 'glucose', 'Glucose');
  }
});

function drawGraph(attribute, dataKey, title) {
  var canvas = $('#' + attribute + '_chart');
  if (canvas[0] === undefined) {
    return;
  }
  var data = canvas.data(dataKey);
  var context = canvas[0].getContext('2d');
  var coordinates = [];
  var isEmpty = true;

  data.forEach(function(dataPoint) {
    var coordinate = {
      x: moment().year(dataPoint.year).month(dataPoint.month),
      y: dataPoint[attribute]
    };
    coordinates.push(coordinate);
    if (isEmpty && coordinate.y != undefined) {
      isEmpty = false;
    }
  });

  if (isEmpty === true) {
    canvas.toggle();
  }

  coordinates.sort(sortByDate);

  function sortByDate(a, b) {
    return a.x-b.x;
  }

  var chart = new Chart(context, {
    type: 'line',
    data: {
      datasets: [{
        label: title,
        fill: false,
        data: coordinates,
      }]
    },
    options: {
      title: {
        display: true,
        text: title,
        fontSize: 25
      },
      legend: {
        display: false
      },
      tooltips: {
        callbacks: {
          title: function(tooltipItems, data) {
            return tooltipItems[0].xLabel.format('MMMM YYYY');
          }
        }
      },
      scales: {
        xAxes: [{
            type: 'time',
            time: {
              displayFormats: {
                'millisecond': 'MMM YYYY',
                'second': 'MMM YYYY',
                'minute': 'MMM YYYY',
                'hour': 'MMM YYYY',
                'day': 'MMM YYYY',
                'week': 'MMM YYYY',
                'quarter': 'MMM YYYY',
                'year': 'MMM YYYY'
              }
            }
        }]
      }
    }
  });
}