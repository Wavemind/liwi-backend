jQuery(document).ready(function () {
  $("#group_accesses-datatable").dataTable({
    "processing": true,
    "info": false,
    "bLengthChange": false,
    "serverSide": true,
    "ajax": $("#group_accesses-datatable").data("source"),
    "pagingType": "full_numbers",
    "columns": [
      { "data": "created_at" },
      { "data": "end_date" },
      { "data": "algorithm" },
      { "data": "version" },
    ]
  });
});
