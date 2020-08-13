jQuery(document).ready(function () {
  $("#final_diagnosis_exclusion-datatable").dataTable({
    "processing": true,
    "info": false,
    "bLengthChange": false,
    "serverSide": true,
    "pageLength": 50,
    "ajax": $("#final_diagnosis_exclusion-datatable").data("source"),
    "pagingType": "full_numbers",
    "columns": [
      { "data": "excluding_diagnosis_id" },
      { "data": "excluded_diagnosis_id" },
      { "data": "actions", "className": "text-right" },
    ],
    'columnDefs': [ {
      'targets': [2],
      'orderable': false,
    }]
  });
});
