jQuery(document).ready(function() {
  $("#questions-datatable").dataTable({
    "processing": true,
    "info": false,
    "bLengthChange": false,
    "serverSide": true,
    "pageLength": 50,
    "ajax": $("#questions-datatable").data("source"),
    "pagingType": "full_numbers",
    "columns": [
      { "data": "id" },
      { "data": "reference" },
      { "data": "label" },
      { "data": "description" },
      { "data": "is_mandatory" },
      { "data": "category" },
      { "data": "answers" },
      { "data": "answer_type" },
      { "data": "actions", "className": "text-right" },
      { "data": "is_neonat" },
    ],
    'columnDefs': [
      {
      'targets': [6,7,8,9],
      'orderable': false,
    },
    {
      'targets': [9],
      'visible': false,
    }],
    "createdRow": function( row, data, dataIndex){
      if (data.is_neonat === "true") {
        $(row).addClass('is_neonat');
      }
    }
  });
});
