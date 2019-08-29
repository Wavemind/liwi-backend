jQuery(document).ready(function() {

  if (!$("#question_unavailable").hasClass("edit_A")) {
    $("#question_unavailable").closest("fieldset").addClass("d-none");
  }
  $("#question_formula").closest(".form-group").addClass("d-none");

  if ($("#new_question").length || $("#edit_question").length) {
    categoryChange();
  };

  $("#question_type").change(categoryChange);

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
  function categoryChange(){
    let prepend = $("#question_type").closest("form").find(".input-group-text");
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

          // Force answer type to boolean if it's ChiefComplaint or Vaccine
          if (response.responseText === "CC" || response.responseText === "V") {
            $("#question_answer_type_displayed").val("1").attr("disabled", true);
            $("#question_answer_type_hidden").val("1");
          } else if (response.responseText === "VS") {
            $("#question_answer_type_displayed").val("4").attr("disabled", true);
            $("#question_answer_type_hidden").val("4");
          } else {
            $("#question_answer_type_displayed").attr("disabled", false);
          }

          // Force triage stage for ChiefComplaint, VitalSign, ChronicalCondition and FirstLookAssessment
          if (response.responseText === "CC" || response.responseText === "VS" || response.responseText === "CH" || response.responseText === "FL") {
            $("#question_stage_displayed").val("triage").attr("disabled", true);
            $("#question_stage_hidden").val("triage")
          } else {
            $("#question_stage_displayed").attr("disabled", false);
          }
        }
      });
    } else {
      prepend.text("_");
    }
  }

  // Hide or show formula field if formula answer type is selected
  $("#question_answer_type_display").change(function() {
    let questionFormula = $("#question_formula").closest(".form-group");
    let answerType = $("#question_answer_type_id option:selected").val();
    $("#question_answer_type_hidden").val(answerType);

    if ($(questionFormula).hasClass("d-none") && answerType === "5") {
      $(questionFormula).removeClass("d-none");
    } else if(answerType !== "5") {
      $(questionFormula).addClass("d-none");
    }
  });

  $("#question_stage_display").change(function() {
    let stage = $("#question_stage_display option:selected").val();
    $("#question_stage_hidden").val(stage);
  });
});
