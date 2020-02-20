jQuery(document).ready(function() {

  // $("#question_formula").closest(".form-group").addClass("d-none");
  $(".formula").addClass("d-none");
  $("#question_system").closest(".form-group").addClass("d-none");
  $("#question_unavailable").closest(".form-group").addClass("d-none");

  // Trigger categoryChange function only on edit or create question form
  if ($("#new_question").length || $("[id^='edit_question']").length) {
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
      { "data": "is_mandatory" },
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

          if (!$("[id^='edit_question']").length) {
            // Force answer type to boolean if it's ChiefComplaint or Vaccine
            if (["CC", "V"].includes(response.responseText)) {
              $("#question_answer_type_displayed").val("1").attr("disabled", true);
              $("#question_answer_type_hidden").val("1");
            } else if (["VC", "VT"].includes(response.responseText)) { // Force answer type to numerif if it is a vital sign (triage or consultation)
              $("#question_answer_type_displayed").val("4").attr("disabled", true);
              $("#question_answer_type_hidden").val("4");
            } else if (response.responseText === "BC") { // Force formula answer type when the category is a Background Calculation
              $("#question_answer_type_displayed").val("5").attr("disabled", true);
              $("#question_answer_type_hidden").val("5");
              answer_type_change();
            } else {
              $("#question_answer_type_displayed").attr("disabled", false);
            }
          }

          // Force stage depending on the category
          if (["CC", "ES", "VT"].includes(response.responseText)) { // Force triage stage for Complaint category emergency sign and vital sign triage
            $("#question_stage_displayed").val("triage").attr("disabled", true);
            $("#question_stage_hidden").val("triage");
          } else if (["CH", "V", "D"].includes(response.responseText)) { // Force registration stage for Chronic Condition, Vaccine and Demographic categories
            $("#question_stage_displayed").val("registration").attr("disabled", true);
            $("#question_stage_hidden").val("registration")
          } else if (["E", "PE", "OS", "S", "VC"].includes(response.responseText)) { // Force consultation stage for Exposure, Background calculation, Physical exam, Observed physical signs, Symptom and vital sign consultation categories
            $("#question_stage_displayed").val("consultation").attr("disabled", true);
            $("#question_stage_hidden").val("consultation")
          }  else if (response.responseText === "A") { // Force test stage for Assessment test category
            $("#question_stage_displayed").val("test").attr("disabled", true);
            $("#question_stage_hidden").val("test")
          }  else if (response.responseText === "TQ") { // Force diagnosis and management stage for treatment questions
            $("#question_stage_displayed").val("diagnosis_management").attr("disabled", true);
            $("#question_stage_hidden").val("diagnosis_management")
          } else {
            $("#question_stage_displayed").attr("disabled", false);
          }

          // Hide stage for Background calculation
          if (response.responseText === "BC") {
            $("#question_stage_displayed").val("").closest(".form-group").attr("hidden", true);
          } else {
            $("#question_stage_displayed").closest(".form-group").attr("hidden", false);
          }

          // Hide or not the system field if it is a consultation category
          if ($("#question_system").closest(".form-group") && ["OS", "PE", "S"].includes(response.responseText)) {
            $("#question_system").closest(".form-group").removeClass("d-none");
          } else {
            $("#question_system").closest(".form-group").addClass("d-none");
          }
        }
      });
    } else {
      prepend.text("_");
    }
  }

  // Hide or show formula field if formula answer type is selected
  function answer_type_change() {
    // let questionFormula = $("#question_formula").closest(".form-group");
    let questionFormula = $(".formula");
    let answerType = $("#question_answer_type_displayed option:selected").val();
    $("#question_answer_type_hidden").val(answerType);

    if ($(questionFormula).hasClass("d-none") && answerType === "5") {
      $(questionFormula).removeClass("d-none");
    } else if(answerType !== "5") {
      $(questionFormula).addClass("d-none");
    }
  }

  // Update the right stage field
  $("#question_stage_displayed").change(function() {
    let stage = $("#question_stage_displayed option:selected").val();
    $("#question_stage_hidden").val(stage);
  });
});
