// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require toastr

//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

jQuery(document).on('turbolinks:load', function(){


var mydata = {

  labels: gon.graph_labels,
  datasets: [
    {
      label: '数量',
      backgroundColor: ["#c97586","#bbbcde","#7CFC00", "#FF66FF","#FFFF99","#CCFFFF","#66FF99"],
      data: gon.graph_counts,
    }
  ]
};

//「オプション設定」
var options = {
  title: {
    display: true,
    text: '品目別出荷割合'
  }
};

var canvas = document.getElementById('stage');
var chart = new Chart(canvas, {

  type: 'pie',  //グラフの種類
  data: mydata,  //表示するデータ
  options: options  //オプション設定

});

});

// document.addEventListener("turbolinks:load", function() {
  
function initMap() {
          'use strict';
          var map;
          var target = document.getElementById('target');
          var geocoder = new google.maps.Geocoder();
          var marker ;
          var center = {
            lat:35.683819,
            lng: 139.773729,
          }

          map = new google.maps.Map(document.getElementById('target'), {
            center: center,
            zoom: 10
          });


// ↓管理者ログイン後の圃場検索（地図検索）使用
          document.getElementById('search').addEventListener('click', function(){
            // 入力された内容を緯度経度へ変換する
            geocoder.geocode({
              address: document.getElementById('address').value
            }, function(results, status){
              if (status !== 'OK') {
                alert('読み込みに失敗しました: ' + status);
                return;
              }
              if(results[0]){
               map = new google.maps.Map(target,{
                  center: results[0].geometry.location,
                  zoom: 18
                });

                marker = new google.maps.Marker({
                  position: results[0].geometry.location,
                  map: map,
                  animation: google.maps.Animation.DROP
                });
              } else {
                alert('No results found');
                return;
              }
            });
          });
        }


// });


document.addEventListener("turbolinks:load", function() {
  
$(function(){
  $('a[href^="#"]').click(function(){
    var speed = 500;
    var href= $(this).attr("href");
    var target = $(href == "#" || href == "" ? 'html' : href);
    var position = target.offset().top;
    $("html, body").animate({scrollTop:position}, speed, "swing");
    return false;
  });
});
  
  
});

document.addEventListener("turbolinks:load", function() {
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
});