jQuery(document).ready(function () {
  $("#algorithm_versions-datatable").dataTable({
    "processing": true,
    "info": false,
    "bLengthChange": false,
    "serverSide": true,
    "ajax": $("#algorithm_versions-datatable").data("source"),
    "pagingType": "full_numbers",
    "columns": [
      { "data": "version" },
      { "data": "last_update" },
      { "data": "creator" },
      { "data": "actions", "className": "text-right" },
    ]
  });
});
