jQuery(document).ready(function () {
  $("#predefined_syndromes-datatable").dataTable({
    "processing": true,
    "info": false,
    "bLengthChange": false,
    "serverSide": true,
    "ajax": $("#predefined_syndromes-datatable").data("source"),
    "pagingType": "full_numbers",
    "columns": [
      { "data": "reference" },
      { "data": "label" },
      { "data": "actions" },
    ]
  });
});
