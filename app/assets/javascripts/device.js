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
      { "data": "health_facility" },
      { "data": "last_activity" },
      { "data": "last_user" },
      { "data": "actions", "className": "text-right"  },
    ],
    'columnDefs': [ {
      'targets': [5,6,7],
      'orderable': false,
    }, {
      'targets': [4],
      'visible': $("#devices-datatable").data('from') !== 'health_facility'
    }]
  });
});
