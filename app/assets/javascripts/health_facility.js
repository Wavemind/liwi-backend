jQuery(document).ready(function () {
  $("#health_facilities-datatable").dataTable({
    "processing": true,
    "info": false,
    "bLengthChange": false,
    "serverSide": true,
    "ajax": $("#health_facilities-datatable").data("source"),
    "pagingType": "full_numbers",
    "columns": [
      { "data": "name" },
      { "data": "nb_people" },
      { "data": "actions", "className": "text-right" },
    ],
    'columnDefs': [ {
      'targets': [2],
      'orderable': false,
    }]
  });
});
