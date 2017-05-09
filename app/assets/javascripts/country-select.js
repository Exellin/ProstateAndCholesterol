/*global $*/
/*global location*/
$(document).ready(function() {
  var regex = /\/profiles\/\d+\/edit/;
  if ($(location).attr('pathname').match(regex)) {
    setCountry();
  }
  
  $('#profile_country').change(function() {
    var input_id = $(this).val();
    setDropdown(input_id, "administrative_division");
    $.ajax({
      url: "/find_administrative_division",
      type: 'GET',
      dataType: 'json',
      data: {
        id: input_id,
      },  
      success: function(result) {
        setDropdown(result[0][0], "city");
      }
    });
  });
  
  $('#profile_administrative_division').change(function() {
    setDropdown($(this).val(), "city");
  });
});
  
var setCountry = function() {
  var country_select = document.getElementById('profile_country');
  var country_check = ($('#country_data').data('country'));
  if (!country_check) {
      country_select.selectedIndex = 235; // United States
  }
};

var setDropdown = function(input_id, query) {
  var dropdown = $("#profile_" + query);
  var option;
  if (input_id == "") {
      dropdown.html("");
  } else {
      $.ajax({
      url: "/find_" + query,
      type: 'GET',
      dataType: 'json',
      data: {
        id: input_id,
      },  
      success: function(result) {
        dropdown.empty();
        console.log(result);
        result.forEach(function(result) {
          option = '<option value='+ result[0] +'>' + result[1] + '</option>';
          dropdown.append(option);
        });
      }
    });
  }
};
