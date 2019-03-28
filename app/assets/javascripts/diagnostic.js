jQuery(document).ready(function () {
  $("#diagnostics-datatable").dataTable({
    "processing": true,
    "info": false,
    "bLengthChange": false,
    "serverSide": true,
    "ajax": $("#diagnostics-datatable").data("source"),
    "pagingType": "full_numbers",
    "columns": [
      {"data": "reference"},
      {"data": "label"},
      {"data": "last_update"},
      {"data": "actions", "className": "text-right"},
    ]
  });
});

function editInstance() {
  console.log(this);
  $.ajax({
    url: window.location.origin + "/diagnostics/" + this.dataset.diagnostic + "/instances/by_reference",
    data: {reference: this.dataset.reference},
    complete: function (response) {
      window.location.href = response.responseText
    }
  });
}
