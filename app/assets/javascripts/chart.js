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