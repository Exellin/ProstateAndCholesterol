/*global $*/
/*global location*/
$(document).ready(function() {
  var regex = /\/profiles\/\d/;
  if ($(location).attr('pathname').match(regex) && document.querySelector('.chosen-select')) {

    $('.chosen-select').chosen({
      no_results_text: "No resulted matched"
    });

    $('.chosen-single-with-deselect').chosen({
      no_results_text: "No resulted matched",
      allow_single_deselect: true
    });

    setFields();
  }

  $('#profile_country').change(function() {
    var country_key = $(this).val();
    getData(country_key, "administrative_division");
    $.ajax({
      url: "/find_administrative_division",
      type: 'GET',
      dataType: 'json',
      data: {
        id: country_key,
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
    country_select.val("US").trigger("chosen:updated"); // United States
  }

  if (administrative_division_select[0] === undefined) {
    buildErrorTextField("administrative_division");
  } else if (administrative_division_select[0].length === 0) {
    replaceDropdownWithTextField(administrative_division_select, "administrative_division");
  }

  if (city_select[0] === undefined) {
    buildErrorTextField("city");
  } else if (city_select[0].length === 0) {
    replaceDropdownWithTextField(city_select, "city");
  }
}

function getData(key, query) {
  var inputField = $("#profile_" + query);
  $.ajax({
    url: "/find_" + query,
    type: 'GET',
    dataType: 'json',
    data: {
      id: key,
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
  if (value === undefined) {
    value = '';
  }
  var html = '<input class="form-control" type="text" value="' + value + '" name="profile[' + query + ']" id="profile_' + query + '">';
  dropdown.replaceWith(html);
}

function buildErrorTextField(query) {
  var container = $('#' + query + '_error_container')[0];
  var textField = document.createElement('input');
  textField.setAttribute('class', 'form-control');
  textField.setAttribute('type', 'text');
  textField.setAttribute('name', 'profile[' + query + ']');
  textField.setAttribute('id', 'profile_' + query);
  container.appendChild(textField);

  var errorSpan = document.createElement('span');
  errorSpan.setAttribute('class', 'help-block');
  errorSpan.setAttribute('id', query + '_error');
  errorSpan.innerText= "can't be blank";
  container.appendChild(errorSpan);
}

function buildDropdown(inputField, query, result) {
  var errorField = ($('#' + query + '_error'))[0];
  if (errorField) {
    errorField.parentNode.removeAttribute("class");
    errorField.parentNode.removeChild(errorField);
  }
  var option;
  var dropdown;
  var html ='<select class="chosen-select" name="profile[' + query + ']" id="profile_' + query + '" ></select>';
  if (inputField.prop('type') === 'text') {
    inputField.replaceWith(html);
    dropdown = $("#profile_" + query);
    dropdown.chosen({
      no_results_text: "No resulted matched"
    });
    if (query === "administrative_division") {
      dropdown.change(function() {
      getData($(this).val(), "city");
      });
    }
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
