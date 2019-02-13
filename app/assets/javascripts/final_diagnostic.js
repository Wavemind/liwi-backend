jQuery(document).ready(function () {
  $("#final_diagnostics-datatable").dataTable({
    "processing": true,
    "info": false,
    "bLengthChange": false,
    "serverSide": true,
    "ajax": $("#final_diagnostics-datatable").data("source"),
    "pagingType": "full_numbers",
    "columns": [
      { "data": "reference" },
      { "data": "label" },
      { "data": "description" },
      { "data": "actions", "className": "text-right" },
    ]
  });
});
