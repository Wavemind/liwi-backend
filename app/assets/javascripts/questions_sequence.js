jQuery(document).ready(function () {
  $("#questions_sequences-datatable").dataTable({
    "processing": true,
    "info": false,
    "bLengthChange": false,
    "serverSide": true,
    "ajax": $("#questions_sequences-datatable").data("source"),
    "pagingType": "full_numbers",
    "columns": [
      { "data": "id" },
      { "data": "reference" },
      { "data": "category" },
      { "data": "label" },
      { "data": "description" },
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
    "ajax": $("#questions_sequences_scored-datatable").data("source"),
    "pagingType": "full_numbers",
    "columns": [
      { "data": "id" },
      { "data": "reference" },
      { "data": "label" },
      { "data": "min_score" },
      { "data": "description" },
      { "data": "actions", "className": "text-right" },
    ],
    'columnDefs': [ {
      'targets': [5],
      'orderable': false,
    }]
  });

  // Update the prepend every time the user pick another category
  $("#questions_sequence_type").change(function() {
    var prepend = $(this).closest("form").find(".input-group-text");
    var type = $("#questions_sequence_type option:selected").val();

    if (type.trim()){
      $.ajax({
        url: window.location.origin + "/questions_sequences/reference_prefix",
        data: {type: type},
        complete: function(response){
          prepend.text(response.responseText);
        }
      });
    } else {
      prepend.text("_");
    }
  });
});
