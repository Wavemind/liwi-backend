jQuery(document).ready(function() {
  $("#questions-datatable").dataTable({
    "processing": true,
    "info": false,
    "bLengthChange": false,
    "serverSide": true,
    "ajax": $("#questions-datatable").data("source"),
    "pagingType": "full_numbers",
    "columns": [
      { "data": "reference" },
      { "data": "label" },
      { "data": "description" },
      { "data": "priority" },
      { "data": "category" },
      { "data": "answers" },
      { "data": "answer_type" },
      { "data": "actions", "className": "text-right" }
    ]
  });

  // Update the prepend every time the user pick another category
  $("#question_category_id").change(function() {
    let prepend = $(this).closest("form").find(".input-group-text");
    let questionUnavailable = $(this).closest("form").find("fieldset.question_unavailable");
    let id = $("#question_category_id option:selected").val();

    if (id.trim()) {
      $.ajax({
        url: window.location.origin + "/categories/" + id + "/reference",
        complete: function(response) {
          prepend.text(response.responseText + "_");

          if ($(questionUnavailable).hasClass("hidden") && response.responseText === "A") {
            $(questionUnavailable).removeClass("hidden");
          } else if(response.responseText !== "A") {
            $(questionUnavailable).addClass("hidden");
          }
        }
      });
    } else {
      prepend.text("_");
    }
  });
});
