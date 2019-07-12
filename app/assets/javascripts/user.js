jQuery(document).ready(function () {
  $("#users-datatable").dataTable({
    "processing": true,
    "info": false,
    "bLengthChange": false,
    "serverSide": true,
    "ajax": $("#users-datatable").data("source"),
    "pagingType": "full_numbers",
    "columns": [
      { "data": "first_name" },
      { "data": "last_name" },
      { "data": "email" },
      { "data": "last_connection" },
      { "data": "deactivated" },
      { "data": "action", "className": "text-right" },
    ],
    'columnDefs': [ {
      'targets': [5],
      'orderable': false,
    }]
  });
});
