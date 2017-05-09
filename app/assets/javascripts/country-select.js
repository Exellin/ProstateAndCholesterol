
/*global $*/
/*global location*/
$(document).ready(function() {
  var regex = /\/profiles\/\d+\/edit/;
  if ($(location).attr('pathname').match(regex)) {
    setCountry();
  }
  
  $('#profile_country').change(function() {
    var input_country_id = $(this).val();
    var administrative_division_select = $("#profile_administrative_division");
    if (input_country_id == "") {
      administrative_division_select.html("");
    } else {
      $.ajax({
        url: "/find_administrative_divisions",
        type: 'GET',
        dataType: 'json',
        data: {
          country_id: input_country_id
        },
        success: function(result) {
          administrative_division_select.empty();
          result.forEach(function(i) {
            var option = '<option value='+ i[0] +'>' + i[1] + '</option>';
            administrative_division_select.append(option);
          });
        }
      });
    }
  });
});
  
var setCountry = function() {
  var country_select = document.getElementById('profile_country');
  var country_check = ($('#country_data').data('country'));
  if (!country_check) {
      country_select.selectedIndex = 230; // United States
  }
};


