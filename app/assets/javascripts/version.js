jQuery(document).ready(function () {
  $( "#triage_questions_order" ).sortable({
    stop: function( event, ui ) {
      let order = [];

      $("#triage_questions_order li").each(function(i, question) {
        order.push(question.value);
      });

      $.ajax({
        url: window.location.href + "/change_triage_order",
        method: 'PUT',
        data: {triage_questions_order: order},
        complete: function(response) {

        }
      });
    }
  });
  $( "#triage_questions_order" ).disableSelection();


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
