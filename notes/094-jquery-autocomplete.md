- <https://github.com/crowdint/rails3-jquery-autocomplete>

~~~

<script>
  $('#collab').bind('input', function() {
    $('.btn-collab').attr("disabled", true);
  });
  $('#collab').bind('railsAutocomplete.select', function(){
    $('.btn-collab').attr("disabled", false);
  });
</script>
~~~

~~~
.ui-menu .ui-menu-item a.ui-corner-all:hover, .ui-menu .ui-menu-item a.ui-corner-all:focus,
.ui-menu .ui-menu-item a.ui-corner-all:active {
  background: #4183c4;
  color: #ffffff;
  border-radius: 0;
}
.ui-state-hover, .ui-widget-content .ui-state-hover, .ui-widget-header .ui-state-hover,
.ui-state-focus, .ui-widget-content .ui-state-focus, .ui-widget-header .ui-state-focus {
  background: #4183c4 !important;
  border: none;
  color: #ffffff !important;
  border-radius: 0;
  font-weight: normal;
}
~~~