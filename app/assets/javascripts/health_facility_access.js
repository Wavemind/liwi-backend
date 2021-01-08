jQuery(document).ready(function () {
  $("#health_facility_accesses-datatable").dataTable({
    "processing": true,
    "info": false,
    "bLengthChange": false,
    "serverSide": true,
    "ajax": $("#health_facility_accesses-datatable").data("source"),
    "pagingType": "full_numbers",
    "columns": [
      { "data": "created_at" },
      { "data": "end_date" },
      { "data": "algorithm" },
      { "data": "version" },
    ]
  });
});
