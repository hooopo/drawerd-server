
// Self Initialize DOM Factory Components
domFactory.handler.autoInit()


function edit_table(url){
  modal = $('#edit-table');
  modal.find('.modal-body').load(url);
  modal.modal("toggle");
}

function edit_relationship(url){
  modal = $('#edit-relationship');
  modal.find('.modal-body').load(url);
  modal.modal("toggle");
}


$(document).ready(function(){
  if($('#svg-object').length){
    document.getElementById('svg-object').addEventListener('load', function(){
      // Will get called after embed element was loaded
      svgPanZoom(document.getElementById('svg-object'), {
        zoomEnabled: false,
        controlIconsEnabled: true,
        zoomScaleSensitivity: 0.3,
        minZoom: 0.5,
        maxZoom: 3,
        preventMouseEventsDefault: true
      });
    });
  }

  // ENABLE TOOLTIPS
  $('[data-toggle="tooltip"]').tooltip();

  if($('#new-group').length){

    $('#new-group').on('show.bs.modal', function (e) {


        var button = $(e.relatedTarget);
        var modal = $(this);

        // load content from HTML string
        //modal.find('.modal-body').html("Nice modal body baby...");

        // or, load content from value of data-remote url
        modal.find('.modal-body').load(button.data("remote"));

    });
  }

  if($('#new-table').length){

    $('#new-table').on('show.bs.modal', function (e) {


        var button = $(e.relatedTarget);
        var modal = $(this);

        // load content from HTML string
        //modal.find('.modal-body').html("Nice modal body baby...");

        // or, load content from value of data-remote url
        modal.find('.modal-body').load(button.data("remote"));

    });
  }

  if($('#new-relationship').length){

    $('#new-relationship').on('show.bs.modal', function (e) {


        var button = $(e.relatedTarget);
        var modal = $(this);

        // load content from HTML string
        //modal.find('.modal-body').html("Nice modal body baby...");

        // or, load content from value of data-remote url
        modal.find('.modal-body').load(button.data("remote"));

    });
  }

  var clipboard = new ClipboardJS('#copy_svg_link');
  
  $('#bg-color-picker').colorpicker({"color": $("#bg-color-picker input").val() || "#F7F8F9"});
  $('#table-header-color-picker').colorpicker({"color": $("#table-header-color-picker input").val() || "#ececfc"});
  $('#table-body-color-picker').colorpicker({"color": $("#table-body-color-picker input").val() || "#01f800"});
  $('#arrow-color-picker').colorpicker({"color": $("#arrow-color-picker input").val() || "#000000"});

});