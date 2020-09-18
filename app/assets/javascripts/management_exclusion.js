jQuery(document).ready(function () {
  $("#management_exclusion-datatable").dataTable({
    "processing": true,
    "info": false,
    "bLengthChange": false,
    "serverSide": true,
    "pageLength": 50,
    "ajax": $("#management_exclusion-datatable").data("source"),
    "pagingType": "full_numbers",
    "columns": [
      { "data": "excluding_management_id" },
      { "data": "excluded_management_id" },
      { "data": "actions", "className": "text-right" },
    ],
    'columnDefs': [ {
      'targets': [2],
      'orderable': false,
    }]
  });
});
