
$(document).ready(function(){
  document.getElementById('svg-object').addEventListener('load', function(){
    // Will get called after embed element was loaded
    svgPanZoom(document.getElementById('svg-object'), {
      zoomEnabled: true,
      controlIconsEnabled: true,
      zoomScaleSensitivity: 0.5,
      minZoom: 1,
      maxZoom: 2
    });
  });
});

// ENABLE TOOLTIPS
$('[data-toggle="tooltip"]').tooltip();

$('#new-group').on('show.bs.modal', function (e) {

    var button = $(e.relatedTarget);
    var modal = $(this);

    // load content from HTML string
    //modal.find('.modal-body').html("Nice modal body baby...");

    // or, load content from value of data-remote url
    modal.find('.modal-body').load(button.data("remote"));

});