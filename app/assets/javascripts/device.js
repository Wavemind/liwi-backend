jQuery(document).ready(function () {
  $("#devices-datatable").dataTable({
    "processing": true,
    "info": false,
    "bLengthChange": false,
    "serverSide": true,
    "ajax": $("#devices-datatable").data('source'),
    "pagingType": "full_numbers",
    "columns": [
      { "data": "reference_number" },
      { "data": "name" },
      { "data": "brand" },
      { "data": "model" },
      { "data": "last_activity" },
      { "data": "last_user" },
      { "data": "actions" },
    ]
  });


  var map;
  map = new google.maps.Map(document.getElementById('map'), {
    zoom: 4,
    center: new google.maps.LatLng(-4, 20.25),
    mapTypeId: 'terrain',
  });

  var url;
  url = window.location.origin + '/devices/map';

  $.get(url, function (data) {

    for (var i = 0; i < data.length; i++) {
      if (data[i].last_activity != null) {
        var latLng = new google.maps.LatLng(data[i].last_activity.latitude, data[i].last_activity.longitude);

        var infowindow = new google.maps.InfoWindow();

        var marker = new google.maps.Marker({
          position: latLng,
          map,
        });

        google.maps.event.addListener(marker, 'click', (function (marker, i) {
          return function () {
            // close all the other infowindows that opened on load
            google.maps.event.trigger(map, 'click');

            var contentString = "";

            if (data[i].last_activity.user != null) {
              contentString = moment(data[i].created_at).format('LLL') + '<br/>' + data[i].brand + ' ' + data[i].model + '<br/> <u>' + data[i].last_activity.user.first_name + ' ' + data[i].last_activity.user.last_name + '</u>';
            } else {
              contentString = moment(data[i].created_at).format('LLL') + '<br/>' + data[i].brand + ' ' + data[i].model + '<br/> <u>Tablette connexion</u>';
            }


            infowindow.setContent(contentString);
            infowindow.open(map, marker);
          }
        })(marker, i));

      }
    }
  });
});
