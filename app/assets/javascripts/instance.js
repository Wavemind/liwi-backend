jQuery(document).ready(function() {
  $("#instances-datatable").dataTable({
    processing: true,
    info: false,
    bLengthChange: false,
    serverSide: true,
    ajax: $("#instances-datatable").data("source"),
    pagingType: "full_numbers",
    columns: [
      { data: "reference" },
      { data: "type" },
      { data: "label" },
      { data: "children" },
      { data: "actions", className: "text-right" }
    ],
    columnDefs: [
      {
        targets: [4],
        orderable: false
      }
    ]
  });
});
