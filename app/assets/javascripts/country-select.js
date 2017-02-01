/*global $*/
/*global location*/
$(document).ready(function(){
  var regex = /\/profiles\/\d+\/edit/;
  if($(location).attr('pathname').match(regex)) {
    setCountry();
  }
});
  
var setCountry = function() {
  var country_select = document.getElementById('profile_country');
  var country_check = ($('#country_data').data('country'));
  if (!country_check) {
      country_select.selectedIndex = 236; // United States
  }
};
