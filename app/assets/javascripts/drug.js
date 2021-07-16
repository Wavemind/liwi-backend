jQuery(document).ready(function () {

  $("#drugs-datatable").dataTable({
    "processing": true,
    "info": false,
    "bLengthChange": false,
    "serverSide": true,
    "pageLength": 50,
    "ajax": $("#drugs-datatable").data("source"),
    "pagingType": "full_numbers",
    "columns": [
      { "data": "id" },
      { "data": "reference" },
      { "data": "label" },
      { "data": "description" },
      { "data": "actions", "className": "text-right" },
      { "data": "is_neonat" },
    ],
    'columnDefs': [ {
      'targets': [4],
      'orderable': false,
    },
    {
      'targets': [5],
      'visible': false,
    }],
    "createdRow": function( row, data, dataIndex){
      if (data.is_neonat === "true") {
        $(row).addClass('is_neonat');
      }
    }
  });
});
