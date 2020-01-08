jQuery(document).ready(function () {
  $("#treatments-datatable").dataTable({
    "processing": true,
    "info": false,
    "bLengthChange": false,
    "serverSide": true,
    "ajax": $("#treatments-datatable").data("source"),
    "pagingType": "full_numbers",
    "columns": [
      { "data": "id" },
      { "data": "reference" },
      { "data": "label" },
      { "data": "description" },
      { "data": "actions", "className": "text-right" },
    ],
    'columnDefs': [ {
      'targets': [4],
      'orderable': false,
    }]
  });
});
