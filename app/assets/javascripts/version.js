jQuery(document).ready(function () {
  $( ".order-available" ).sortable({
    stop: function( event, ui ) {
      let order = [];

      $("#" + event.target.id +" li").each(function(i, question) {
        order.push(question.value);
      });

      let url = $("#questions_order").data("url");

      $.ajax({
        url: url,
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
  $( ".order-available" ).disableSelection();


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
