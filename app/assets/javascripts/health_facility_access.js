jQuery(document).ready(function () {
  $("#health_facility_accesses-datatable").dataTable({
    "processing": true,
    "info": false,
    "bLengthChange": false,
    "serverSide": true,
    "ajax": $("#health_facility_accesses-datatable").data("source"),
    "pagingType": "full_numbers",
    "columns": [
      { "data": "created_at" },
      { "data": "end_date" },
      { "data": "algorithm" },
      { "data": "version" },
    ]
  });

  if ($('#generate-json-file').length > 0) {
    setInterval(function(){
      $.ajax({
        url: 'http://localhost:3000/algorithms/1/versions/1/job_status',
        complete: function(response){
          console.log(response);
        }
      })
    }, 10000);
  }
});
