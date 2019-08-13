jQuery(document).ready(function() {

  if (!$("#question_unavailable").hasClass("edit_A")) {
    $("#question_unavailable").closest("fieldset").addClass("d-none");
  }
  $("#question_formula").closest(".form-group").addClass("d-none");

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
    ],
    'columnDefs': [ {
      'targets': [5,6,7],
      'orderable': false,
    }]
  });

  // Update the prepend every time the user pick another category
  $("#question_type").change(function() {
    let prepend = $(this).closest("form").find(".input-group-text");
    let questionUnavailable = $("#question_unavailable").closest("fieldset");
    let type = $("#question_type option:selected").val();

    if (type.trim()) {
      $.ajax({
        url: window.location.origin + "/questions/reference_prefix",
        data: {type: type},
        complete: function(response) {
          prepend.text(response.responseText);
          if ($(questionUnavailable).hasClass("d-none") && response.responseText === "A") {
            $(questionUnavailable).removeClass("d-none");
          } else if(response.responseText !== "A") {
            $(questionUnavailable).addClass("d-none");
          }

          // Block answer type to boolean if it's ChiefComplaint or Vaccine
          if (response.responseText === "CC" || response.responseText === "V") {
            $("#question_answer_type_id").val("1").attr("disabled", true);
          } else {
            $("#question_answer_type_id").attr("disabled", false);
          }

          // Block stage to triage if it's ChiefComplaint or VitalSign
          if (response.responseText === "CC" || response.responseText === "VS") {
            $("#question_stage").val("triage").attr("disabled", true); // Force triage for CC and V
          } else {
            $("#question_stage").attr("disabled", false);
          }
        }
      });
    } else {
      prepend.text("_");
    }
  });

  // Hide or show formula field if formula answer type is selected
  $("#question_answer_type_id").change(function() {
    let questionFormula = $("#question_formula").closest(".form-group");
    let answerType = $("#question_answer_type_id option:selected").val();

    if ($(questionFormula).hasClass("d-none") && answerType === "5") {
      $(questionFormula).removeClass("d-none");
    } else if(answerType !== "5") {
      $(questionFormula).addClass("d-none");
    }
  });
});
