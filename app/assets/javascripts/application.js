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