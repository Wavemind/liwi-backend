jQuery(document).ready(function () {
  $("#algorithms-datatable").dataTable({
    "processing": true,
    "info": false,
    "bLengthChange": false,
    "serverSide": true,
    "pageLength": 50,
    "ajax": $("#algorithms-datatable").data("source"),
    "pagingType": "full_numbers",
    "columns": [
      { "data": "name" },
      { "data": "description" },
      { "data": "versions" },
      { "data": "creator" },
      { "data": "actions", "className": "text-right" },
    ],
    'columnDefs': [ {
      'targets': [4],
      'orderable': false,
    }]
  });
});
