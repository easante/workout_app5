$(document).ready(function() {
  $("#exercise_workout_date").datepicker({ dateFormat: 'yy-mm-dd' });
  
  var regex = /\/users\/\d+\/exercises$|\/friendships\/d+$/i;

  if($(location).attr('pathname').match(regex)) {
    drawChart();
  }
});

var drawChart = function() {

  var margin = { top: 100, right: 20, bottom: 100, left: 50 },
      width  = 600 - margin.left - margin.right,
      height = 450 - margin.top - margin.bottom;

  var JSONData = $("#chart").data("workouts");

  var data = JSONData.slice()
  
  var parseTime = d3.timeParse("%Y-%m-%d");
  
  var workoutFn = function(d) { return d.duration_in_min }
  var dateFn = function(d) { return parseTime(d.workout_date) }
  
  var x = d3.scaleTime()
    .range([0, width])
    .domain(d3.extent(data, dateFn))
  
  var y = d3.scaleLinear()
    .range([height, 0])
    .domain([0, d3.max(data, workoutFn)])
  
  var workout_line = d3.line()
      .x(function(d) { return x(d.workout_date); })
      .y(function(d) { return y(d.duration_in_min);  });
  
  data.forEach(function(d) {
    d.workout_date = parseTime(d.workout_date);
    d.duration_in_min = +d.duration_in_min;
  });
  
  var svg = d3.select("#chart").append("svg")
  .attr("width", width + margin.left + margin.right)
  .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");
  
    svg.append("path")
        .attr("class", "line")
        .attr("d", workout_line(data));
  
  svg.append("g")
   .attr("class", "x axis")
   .attr("transform", "translate(0," + height + ")")
   .call(d3.axisBottom(x)
      .ticks(d3.timeDay.every(1))
      .tickFormat(d3.timeFormat('%Y-%m-%d'))
    )
   .selectAll("text")
      .style("text-anchor", "end")
      .attr("dx", "-.8em")
      .attr("dy", ".15em")
      .attr("transform", "rotate(-60)");
  
   // x axis label
   svg.append("text")
      .attr("x", width / 2)
      .attr("y", height + margin.top - 15)
      .style("text-anchor", "middle")
      .text("Date of workout")
  
   svg.append("g")
    .attr("class", "y axis")
    .call(d3.axisLeft(y).ticks(4));
  
  // y axis label
  svg.append("text")
     .attr("transform", "rotate(-90)")
     .attr("y", 0 - margin.left)
     .attr("x", 0 - (height / 2))
     .attr("dy", "1em")
     .style("text-anchor", "middle")
     .text("Workout duration (min)")
  
   // Chat title
   svg.append("text")
      .attr("x", (width / 2))
      .attr("y", 0 - (margin.top / 2))
      .style("text-anchor", "middle")
      .style("font-size", "18px")
      .style("text-decoration", "underline")
      .text("Workout duration vs Workout date")
};