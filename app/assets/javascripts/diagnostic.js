jQuery(document).ready(function () {
  $("#diagnostics-datatable").dataTable({
    "processing": true,
    "info": false,
    "bLengthChange": false,
    "serverSide": true,
    "pageLength": 50,
    "ajax": $("#diagnostics-datatable").data("source"),
    "pagingType": "full_numbers",
    "columns": [
      {"data": "reference"},
      {"data": "label"},
      {"data": "node"},
      {"data": "last_update"},
      {"data": "actions", "className": "text-right"},
    ],
    'columnDefs': [ {
      'targets': [4],
      'orderable': false,
    }]
  });
});
