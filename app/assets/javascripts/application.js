
// Self Initialize DOM Factory Components
domFactory.handler.autoInit()



$(document).ready(function(){
  if($('#svg-object').length){
    document.getElementById('svg-object').addEventListener('load', function(){
      // Will get called after embed element was loaded
      svgPanZoom(document.getElementById('svg-object'), {
        zoomEnabled: false,
        controlIconsEnabled: true,
        zoomScaleSensitivity: 0.3,
        minZoom: 1,
        maxZoom: 3
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

});