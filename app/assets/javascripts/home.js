$(function() {
  $('#person-select').change(function() {
    $(this).parents('form').submit();
  })
})