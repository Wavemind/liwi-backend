jQuery(document).ready(function () {
  $("#health_facilities-datatable").dataTable({
    "processing": true,
    "info": false,
    "bLengthChange": false,
    "serverSide": true,
    "ajax": $("#health_facilities-datatable").data("source"),
    "pagingType": "full_numbers",
    "columns": [
      { "data": "name" },
      { "data": "country" },
      { "data": "area" },
      { "data": "nb_people" },
      { "data": "actions", "className": "text-right" },
    ],
    'columnDefs': [ {
      'targets': [2],
      'orderable': false,
    }]
  });

  /**
   * Shows/hides medAL-hub IP field when the page loads
   */
  toggleMedalHubIpField();

  /**
   * Shows/hides medAL-hub IP field when the architecture field changes
   */
  $("#health_facility_architecture").change(function(){
    toggleMedalHubIpField();
  })
});

/**
 * Hides the MedalHubIP field if architecture is standalone
 */
const toggleMedalHubIpField = () => {
  const input = $('.health_facility_local_data_ip');
  $("#health_facility_architecture").val() === 'standalone' ? input.hide() : input.show();
};

