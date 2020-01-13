jQuery(document).ready(function() {

  $("#question_formula").closest(".form-group").addClass("d-none");

  // Trigger categoryChange function only on edit or create question form
  if ($("#new_question").length || $("#edit_question").length) {
    categoryChange();
    answer_type_change();
  }

  $("#question_type").change(categoryChange);
  $("#question_answer_type_displayed").change(answer_type_change);

  $("#questions-datatable").dataTable({
    "processing": true,
    "info": false,
    "bLengthChange": false,
    "serverSide": true,
    "ajax": $("#questions-datatable").data("source"),
    "pagingType": "full_numbers",
    "columns": [
      { "data": "id" },
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
      'targets': [6,7,8],
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
          if (["CC", "V"].includes(response.responseText)) {
            $("#question_answer_type_displayed").val("1").attr("disabled", true);
            $("#question_answer_type_hidden").val("1");
          } else if (response.responseText === "VS") {
            $("#question_answer_type_displayed").val("4").attr("disabled", true);
            $("#question_answer_type_hidden").val("4");
          } else {
            $("#question_answer_type_displayed").attr("disabled", false);
          }

          // Force priority depending on the category
          if (["CC"].includes(response.responseText)){
            $("#question_priority_displayed").val("mandatory").attr("disabled", true);
            $("#question_priority_hidden").val("mandatory");
          } else {
            $("#question_priority_displayed").attr("disabled", false);
          }

          // Force stage depending on the category (except basic measurement)
          if (["CC", "FL"].includes(response.responseText)) { // Force triage stage for Complaint category and FirstLookAssessment
            $("#question_stage_displayed").val("triage").attr("disabled", true);
            $("#question_stage_hidden").val("triage");
          } else if (["CH", "V", "D"].includes(response.responseText)) { // Force registration stage for Chronical Condition, Vaccin and Demographic categories
            $("#question_stage_displayed").val("registration").attr("disabled", true);
            $("#question_stage_hidden").val("registration")
          } else if (["E", "PE", "S"].includes(response.responseText)) { // Force consultation stage for Exposure, Physical exam and Symptom categories
            $("#question_stage_displayed").val("consultation").attr("disabled", true);
            $("#question_stage_hidden").val("consultation")
          }  else if (response.responseText === "A") { // Force test stage for Assessment test category
            $("#question_stage_displayed").val("test").attr("disabled", true);
            $("#question_stage_hidden").val("test")
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
  function answer_type_change() {
    let questionFormula = $("#question_formula").closest(".form-group");
    let answerType = $("#question_answer_type_displayed option:selected").val();
    $("#question_answer_type_hidden").val(answerType);

    if ($(questionFormula).hasClass("d-none") && answerType === "5") {
      $(questionFormula).removeClass("d-none");
    } else if(answerType !== "5") {
      $(questionFormula).addClass("d-none");
    }
  }

  // Update the right priority field
  $("#question_priority_displayed").change(function() {
    let priority = $("#question_priority_displayed option:selected").val();
    $("#question_priority_hidden").val(priority);
  });

  // Update the right stage field
  $("#question_stage_displayed").change(function() {
    let stage = $("#question_stage_displayed option:selected").val();
    $("#question_stage_hidden").val(stage);
  });
});
