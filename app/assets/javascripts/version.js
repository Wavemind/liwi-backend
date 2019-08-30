jQuery(document).ready(function () {
  $( ".triage-order" ).sortable({
    stop: function( event, ui ) {
      let order = [];

      $("#" + event.target.id +" li").each(function(i, question) {
        order.push(question.value);
      });

      $.ajax({
        url: window.location.protocol + "//" + window.location.host + window.location.pathname + "/change_triage_order",
        method: 'PUT',
        data: {
          key: event.target.id,
          order: order
        },
        complete: function(response) {

        }
      });
    }
  });
  $( ".triage-order" ).disableSelection();


  $("#versions-datatable").dataTable({
    "processing": true,
    "info": false,
    "bLengthChange": false,
    "serverSide": true,
    "ajax": $("#versions-datatable").data("source"),
    "pagingType": "full_numbers",
    "columns": [
      { "data": "name" },
      { "data": "last_update" },
      { "data": "creator" },
      { "data": "actions", "className": "text-right" },
    ],
    'columnDefs': [ {
      'targets': [3],
      'orderable': false,
    }]
  });
});
