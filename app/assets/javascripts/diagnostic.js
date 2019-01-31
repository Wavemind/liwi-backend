jQuery(document).ready(function () {
  $("#diagnostics-datatable").dataTable({
    "processing": true,
    "info": false,
    "bLengthChange": false,
    "serverSide": true,
    "ajax": $("#diagnostics-datatable").data("source"),
    "pagingType": "full_numbers",
    "columns": [
      { "data": "reference" },
      { "data": "label" },
      { "data": "last_update" },
      { "data": "actions", "className": "text-right" },
    ]
  });
});
