jQuery(document).ready(function () {
  $("#drug_exclusion-datatable").dataTable({
    "processing": true,
    "info": false,
    "bLengthChange": false,
    "serverSide": true,
    "pageLength": 50,
    "ajax": $("#drug_exclusion-datatable").data("source"),
    "pagingType": "full_numbers",
    "columns": [
      { "data": "excluding_drug_id" },
      { "data": "excluded_drug_id" },
      { "data": "actions", "className": "text-right" },
    ],
    'columnDefs': [ {
      'targets': [2],
      'orderable': false,
    }]
  });
});
