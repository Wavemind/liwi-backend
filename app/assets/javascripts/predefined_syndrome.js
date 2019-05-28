jQuery(document).ready(function () {
  $("#predefined_syndromes-datatable").dataTable({
    "processing": true,
    "info": false,
    "bLengthChange": false,
    "serverSide": true,
    "ajax": $("#predefined_syndromes-datatable").data("source"),
    "pagingType": "full_numbers",
    "columns": [
      { "data": "reference" },
      { "data": "category" },
      { "data": "label" },
      { "data": "description" },
      { "data": "actions", "className": "text-right" },
    ]
  });

  $("#predefined_syndromes_scored-datatable").dataTable({
    "processing": true,
    "info": false,
    "bLengthChange": false,
    "serverSide": true,
    "ajax": $("#predefined_syndromes_scored-datatable").data("source"),
    "pagingType": "full_numbers",
    "columns": [
      { "data": "reference" },
      { "data": "category" },
      { "data": "label" },
      { "data": "min_score" },
      { "data": "description" },
      { "data": "actions", "className": "text-right" },
    ]
  });

  // Update the prepend every time the user pick another category
  $("#predefined_syndrome_category_id").change(function() {
    var prepend = $(this).closest("form").find(".input-group-text");
    var id = $("#predefined_syndrome_category_id option:selected").val();

    if (id.trim()){
      $.ajax({
        url: window.location.origin + "/categories/" + id + "/reference",
        complete: function(response){
          prepend.text(response.responseText);
        }
      });
    } else {
      prepend.text("_");
    }
  });
});
