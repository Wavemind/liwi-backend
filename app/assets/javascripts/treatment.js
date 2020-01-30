jQuery(document).ready(function () {

  treatmentTypeChange();

  $("#health_cares_treatment_treatment_type").change(treatmentTypeChange);

  $("#treatments-datatable").dataTable({
    "processing": true,
    "info": false,
    "bLengthChange": false,
    "serverSide": true,
    "ajax": $("#treatments-datatable").data("source"),
    "pagingType": "full_numbers",
    "columns": [
      { "data": "id" },
      { "data": "reference" },
      { "data": "label" },
      { "data": "description" },
      { "data": "actions", "className": "text-right" },
    ],
    'columnDefs': [ {
      'targets': [4],
      'orderable': false,
    }]
  });

  // Show pill size field only if treatment type is pill
  function treatmentTypeChange() {
    let pillSize = $("#health_cares_treatment_pill_size").closest(".form-group");
    let treatmentType = $("#health_cares_treatment_treatment_type option:selected").val();
    // $("#question_answer_type_hidden").val(treatmentType);

    if ($(pillSize).hasClass("d-none") && treatmentType === "pill") {
      $(pillSize).removeClass("d-none");
    } else if(treatmentType !== "pill") {
      $(pillSize).addClass("d-none");
    }
  }
});
