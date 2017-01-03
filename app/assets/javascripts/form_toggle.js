/*global $*/
$(document).ready(function() {
  if ($('#anonymous').is(":checked")) {
    clearAndHideNameFields();
  }
  
  $('#anonymous').click(function() {
    if($(this).is(":checked")) {
      clearAndHideNameFields();
    } else {
      $(".name").show();
    }
  });
});

function clearAndHideNameFields() {
  $(".name").hide();
  $("#user_first_name").val("");
  $("#user_last_name").val("");
}
