function initMap() {
  'use strict';
  var map;
  var target = document.getElementById('target');
  var geocoder = new google.maps.Geocoder();
  var marker;
  var center = {
    lat: 35.683819,
    lng: 139.773729,
  }

  map = new google.maps.Map(document.getElementById('target'), {
    center: center,
    zoom: 10
  });


  // ↓管理者ログイン後の圃場検索（地図検索）使用
  document.getElementById('search').addEventListener('click', function() {
    // 入力された内容を緯度経度へ変換する
    geocoder.geocode({
      address: document.getElementById('address').value
    }, function(results, status) {
      if (status !== 'OK') {
        alert('読み込みに失敗しました: ' + status);
        return;
      }
      if (results[0]) {
        map = new google.maps.Map(target, {
          center: results[0].geometry.location,
          zoom: 18
        });

        marker = new google.maps.Marker({
          position: results[0].geometry.location,
          map: map,
          animation: google.maps.Animation.DROP
        });
      }
      else {
        alert('No results found');
        return;
      }
    });
  });
}