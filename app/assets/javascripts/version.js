jQuery(document).ready(function () {
  $("#versions-datatable").dataTable({
    "processing": true,
    "info": false,
    "bLengthChange": false,
    "serverSide": true,
    "ajax": $("#versions-datatable").data("source"),
    "pagingType": "full_numbers",
    "columns": [
      { "data": "name" },
      { "data": "last_update" },
      { "data": "creator" },
      { "data": "actions", "className": "text-right" },
    ]
  });
});
