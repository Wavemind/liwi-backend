jQuery(document).ready(function () {
  $("#groups-datatable").dataTable({
    "processing": true,
    "info": false,
    "bLengthChange": false,
    "serverSide": true,
    "ajax": $("#groups-datatable").data("source"),
    "pagingType": "full_numbers",
    "columns": [
      { "data": "name" },
      { "data": "nb_people" },
      { "data": "actions", "className": "text-right" },
    ]
  });
});
