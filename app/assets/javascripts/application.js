// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require plugins/jquery-ui/jquery-ui
//= require plugins/bootstrap/js/bootstrap.min
//= require plugins/rs-plugin/js/jquery.themepunch.tools.min
//= require plugins/rs-plugin/js/jquery.themepunch.revolution.min
//= require plugins/owl-carousel/owl.carousel
//= require plugins/selectbox/jquery.selectbox-0.1.3.min
//= require plugins/countdown/jquery.syotimer
//= require js/custom
//= require_self

function getBaseParams() {
  let baseParams = {};
  let query = location.search;

  if (query) {
    let currentQueryParams = location.search.substring(1).split('&');

    currentQueryParams.forEach(function(currentQuery, index) {
      let item = currentQuery.split('=');
      baseParams[item[0]] = item[1];
    });
    return baseParams;
  } else {
    return baseParams;
  }
}

function getBaseUrl() {
  return location.href.replace(/\?.*$/, '');
}


$(function(){
  // $('#guiest_id1').val('2');
  // $('.select-drop-test').selectbox({
  // });
  $('#sorting_select').on('change', function(){

    let baseUrl = getBaseUrl();
    let value = $(this).val();

    if (value != '') {
      let newParams = Object.assign(getBaseParams(), { sort: value });
      location.href = baseUrl + '?' + $.param(newParams);
    }
  });

  if ('sort' in getBaseParams()) {
    console.log('in sort');
    console.log(getBaseParams()['sort']);
    // $('#sorting_select option').attr('selected', false);
    $('#sorting_select' + ' option[value="' + getBaseParams()['sort'] +'"]').attr('selected', true);
  } else {
    console.log('not in sort');
  }
});
