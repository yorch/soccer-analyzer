// # $(function () {
// #   $.getJSON('', function(data) {
// #     $('#container').highcharts({
// #       chart: {
// #         type: 'line',
// #         marginRight: 130,
// #         marginBottom: 25
// #       },
// #       title: {
// #         text: 'Monthly Average Temperature',
// #         x: -20 //center
// #       },
// #       subtitle: {
// #         text: 'Source: WorldClimate.com',
// #         x: -20
// #       },
// #       xAxis: {
// #         categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
// #         'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
// #       },
// #       yAxis: {
// #         title: {
// #         text: 'Temperature (&deg;C)'
// #       },
// #       plotLines: [{
// #         value: 0,
// #         width: 1,
// #         color: '#808080'
// #         }]
// #       },
// #       tooltip: {
// #         valueSuffix: '&deg;C'
// #       },
// #         legend: {
// #         layout: 'vertical',
// #         align: 'right',
// #         verticalAlign: 'top',
// #         x: -10,
// #         y: 100,
// #         borderWidth: 0
// #       },
// #       series: [{
// #         name: '',
// #         data: data,
// #         id: 'dataseries'
// #         }]
// #     });
// #   })
// # });

$(function() {
  $('#person-select').change(function() {
    $(this).parents('form').submit();
  })
})