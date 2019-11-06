jQuery(document).ready(function() {
  $("#question_snomed_label").autocomplete({
    source: function(request, response) {
      $.ajax({
        url: "https://browser.ihtsdotools.org/snowstorm/snomed-ct/v2/MAIN/concepts?term=" + request.term + "&limit=50",
        dataType: "json",
        crossDomain: true,
        success: function(data) {
          response(data.items);
        }
      });
    },
    minLength: 1,
    select: function(event, ui) {
      $("#question_snomed_label").val(ui.item.fsn.term);
      $("#question_snomed_id").val(ui.item.id);
      return false;
    },
    focus: function(event, ui) {
      $("#question_snomed").val(ui.item.fsn.term);
      return false;
    }
  }).data("ui-autocomplete")._renderItem = function(ul, item) {
    return $("<li></li>")
      .data("item.autocomplete", item)
      .append("<a>" + item.fsn.term + "</a>")
      .appendTo(ul);
  };
});
