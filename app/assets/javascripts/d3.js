

  (function(){
    'use strict';

    var WIDTH = 600;
    var HEIGHT = 240;

    var padding = {
      top: 40,
      bottom: 40,
      left: 100,
      right: 40,
    };


   var scores = []

      gon.graph_labels.forEach(function(name) {
        scores.push({name: name, score: gon.customer_data[name]})
      });

    function update(data) {
        var bars = d3.select('svg').selectAll('rect').data(data);

        var xScale = d3.scaleLinear()
          .domain([0, d3.max(scores, function(d) {
            return d.score;
          })])
          .range([0, WIDTH - padding.left - padding.right])
          .nice();

        var yScale = d3.scaleBand()
          .domain(scores.map(function(d) {
            return d.name;
          }))
          .range([0, HEIGHT - padding.top - padding.bottom])
          .padding([0.1]);

        var color = d3.scaleOrdinal(d3.schemeCategory10);

        bars
          .enter()
          .append('rect')
          .merge(bars)
          .attr('x', padding.left)
          .attr('y', function(d, i) {
            return yScale(d.name) + padding.top;
          })
          .attr('width', 0)
          .attr('height', yScale.bandwidth())
          .attr('fill', function(d, i) {
            return color(i);
          })
          .transition()
            .duration(200)
            .delay(function(d, i) {
              return i * 200;
            })
            .ease(d3.easeElastic)
            .attr('width', function(d) {
              return xScale(d.score);
            });

        bars
          .exit()
          .remove();

        d3.selectAll('.axis').remove();

        d3.select('svg')
          .append('g')
          .attr('class', 'axis')
          .attr(
            'transform',
            'translate(' + [padding.left, HEIGHT - padding.bottom] + ')'
          )
          .call(d3.axisBottom(xScale));

        d3.select('svg')
          .append('g')
          .attr('class', 'axis')
          .attr(
            'transform',
            'translate(' + [padding.left, padding.top] + ')'
          )
          .call(d3.axisLeft(yScale));
      }

      update(scores);
    })();