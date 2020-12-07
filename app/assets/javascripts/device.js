jQuery(document).ready(function () {
  $("#devices-datatable").dataTable({
    "processing": true,
    "info": false,
    "bLengthChange": false,
    "serverSide": true,
    "ajax": $("#devices-datatable").data('source'),
    "pagingType": "full_numbers",
    "columns": [
      { "data": "mac_address" },
      { "data": "name" },
      { "data": "brand" },
      { "data": "model" },
      { "data": "last_activity" },
      { "data": "last_user" },
      { "data": "actions", "className": "text-right"  },
    ],
    'columnDefs': [ {
      'targets': [6],
      'orderable': false,
    }]
  });
});
