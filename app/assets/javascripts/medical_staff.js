jQuery(document).ready(function () {
  $("#medical_staffs-datatable").dataTable({
    "processing": true,
    "info": false,
    "bLengthChange": false,
    "serverSide": true,
    "pageLength": 10,
    "ajax": $("#medical_staffs-datatable").data("source"),
    "pagingType": "full_numbers",
    "columns": [
      {"data": "first_name"},
      {"data": "last_name"},
      {"data": "role"},
    ]
  });
});
