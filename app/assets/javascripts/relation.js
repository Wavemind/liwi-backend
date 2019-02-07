jQuery(document).ready(function () {
  $("#relations-datatable").dataTable({
    "processing": true,
    "info": false,
    "bLengthChange": false,
    "serverSide": true,
    "ajax": $("#relations-datatable").data("source"),
    "pagingType": "full_numbers",
    "columns": [
      { "data": "id" },
      { "data": "reference" },
      { "data": "type" },
      { "data": "label" },
      { "data": "actions", "className": "text-right" },
    ]
  });
});
