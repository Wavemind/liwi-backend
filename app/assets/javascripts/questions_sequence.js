jQuery(document).ready(function () {
  $("#questions_sequences-datatable").dataTable({
    "processing": true,
    "info": false,
    "bLengthChange": false,
    "serverSide": true,
    "pageLength": 50,
    "ajax": $("#questions_sequences-datatable").data("source"),
    "pagingType": "full_numbers",
    "columns": [
      { "data": "id" },
      { "data": "reference" },
      { "data": "label" },
      { "data": "description" },
      { "data": "category" },
      { "data": "actions", "className": "text-right" },
    ],
    'columnDefs': [ {
      'targets': [5],
      'orderable': false,
    }]
  });

  $("#questions_sequences_scored-datatable").dataTable({
    "processing": true,
    "info": false,
    "bLengthChange": false,
    "serverSide": true,
    "pageLength": 50,
    "ajax": $("#questions_sequences_scored-datatable").data("source"),
    "pagingType": "full_numbers",
    "columns": [
      { "data": "id" },
      { "data": "reference" },
      { "data": "label" },
      { "data": "description" },
      { "data": "min_score" },
      { "data": "actions", "className": "text-right" },
    ],
    'columnDefs': [ {
      'targets': [5],
      'orderable': false,
    }]
  });
});
