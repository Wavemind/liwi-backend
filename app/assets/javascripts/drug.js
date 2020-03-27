jQuery(document).ready(function () {

  medicationFormChange();

  $("#health_cares_formulation_medication_form").change(medicationFormChange);

  $("#drugs-datatable").dataTable({
    "processing": true,
    "info": false,
    "bLengthChange": false,
    "serverSide": true,
    "ajax": $("#drugs-datatable").data("source"),
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

  // Show pill size field only if medication form is capsule
  function medicationFormChange() {
    let pillSize = $("#health_cares_drug_formulation_pill_size").closest(".form-group");
    let medicationForm = $("#health_cares_drug_formulation_medication_form option:selected").val();

    if ($(pillSize).hasClass("d-none") && medicationForm === "pill") {
      $(pillSize).removeClass("d-none");
    } else if(medicationForm !== "pill") {
      $(pillSize).addClass("d-none");
    }
  }
});
