jQuery(document).ready(function () {
  $("#final_diagnoses-datatable").dataTable({
    "processing": true,
    "info": false,
    "bLengthChange": false,
    "serverSide": true,
    "pageLength": 50,
    "ajax": $("#final_diagnoses-datatable").data("source"),
    "pagingType": "full_numbers",
    "columns": [
      { "data": "reference" },
      { "data": "label" },
      { "data": "description" },
      { "data": "actions", "className": "text-right" },
    ],
    'columnDefs': [ {
      'targets': [3],
      'orderable': false,
    }]
  });

  $("#version_final_diagnoses-datatable").dataTable({
    "processing": true,
    "info": false,
    "bLengthChange": false,
    "serverSide": true,
    "pageLength": 50,
    "ajax": $("#version_final_diagnoses-datatable").data("source"),
    "pagingType": "full_numbers",
    "columns": [
      { "data": "id" },
      { "data": "reference" },
      { "data": "label" },
      { "data": "diagnosis" },
      { "data": "cc" },
      { "data": "description" },
      { "data": "actions", "className": "text-right"},
    ],
    'columnDefs': [ {
      'targets': [],
      'orderable': false,
    }]
  });
});

