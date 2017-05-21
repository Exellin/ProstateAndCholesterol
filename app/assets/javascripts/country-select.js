/*global $*/
/*global location*/
$(document).ready(function() {
  var regex = /\/profiles\/\d+\/edit/;
  if ($(location).attr('pathname').match(regex)) {
    
    $('.chosen-select').chosen({
      no_results_text: "No resulted matched",
      width: '100%'
    });
    
    setFields();
  }
  
  $('#profile_country').change(function() {
    var input_id = $(this).val();
    getData(input_id, "administrative_division");
    $.ajax({
      url: "/find_administrative_division",
      type: 'GET',
      dataType: 'json',
      data: {
        id: input_id,
      },  
      success: function(result) {
        if (result[0] != undefined) {
          getData(result[0][0], "city");
        } else {
          var cityDropdown = $("#profile_city");
          replaceDropdownWithTextField(cityDropdown, "city");
        }
      }
    });
  });
  
  $('#profile_administrative_division').change(function() {
    getData($(this).val(), "city");
  });
});
  
function setFields() {
  var country_select = $("#profile_country");
  var administrative_division_select = $('#profile_administrative_division');
  var city_select = $("#profile_city");
  var country = ($('#country_data').data('country'));
  
  if (!country) {
    country_select.selectedIndex = 235; // United States
  }
  
  if (administrative_division_select[0].length === 0) {
    replaceDropdownWithTextField(administrative_division_select, "administrative_division");
  }
  
  if (city_select[0].length === 0) {
    replaceDropdownWithTextField(city_select, "city");
  }
}

function getData(input_id, query) {
  var inputField = $("#profile_" + query);
  $.ajax({
    url: "/find_" + query,
    type: 'GET',
    dataType: 'json',
    data: {
      id: input_id,
    },  
    success: function(result) {
      if (result.length === 0) {
        replaceDropdownWithTextField(inputField, query);
      } else {
        buildDropdown(inputField, query, result);
      }
    }
  });
} 

function replaceDropdownWithTextField(dropdown, query) {
  var value;
  if (query === "administrative_division") {
    value = ($('#country_data').data('administrative-division'));
  } else if (query === "city") {
    value = ($('#country_data').data('city'));
  }
  dropdown.chosen("destroy");
  var html = '<input class="form-control" type="text" value="' + value + '" name="profile[' + query + ']" id="profile_' + query + '">';
  dropdown.replaceWith(html);
}

function buildDropdown(inputField, query, result) {
  var option;
  var dropdown;
  var html ='<select class="chosen-select" name="profile[' + query + ']" id="profile_' + query + '">';
  if (inputField.prop('type') === 'text') {
    inputField.replaceWith(html);
    dropdown = $("#profile_" + query);
    dropdown.chosen({
      no_results_text: "No resulted matched",
      width: '100%'
    });
  } else {
    dropdown = inputField;
    dropdown.empty();
  }
  result.forEach(function(result) {
    option = '<option value='+ result[0] +'>' + result[1] + '</option>';
    dropdown.append(option);
  });
  dropdown.trigger("chosen:updated");    
}
