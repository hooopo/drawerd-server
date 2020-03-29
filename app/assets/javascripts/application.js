
// Self Initialize DOM Factory Components
domFactory.handler.autoInit()

// Connect button(s) to drawer(s)
var sidebarToggle = Array.prototype.slice.call(document.querySelectorAll('[data-toggle="sidebar"]'))

sidebarToggle.forEach(function (toggle) {
  toggle.addEventListener('click', function (e) {
    var selector = e.currentTarget.getAttribute('data-target') || '#default-drawer'
    var drawer = document.querySelector(selector)
    if (drawer) {
      drawer.mdkDrawer.toggle()
    }
  })
})


let drawers = document.querySelectorAll('.mdk-drawer')
drawers = Array.prototype.slice.call(drawers)
drawers.forEach((drawer) => {
  drawer.addEventListener('mdk-drawer-change', (e) => {
    if (!e.target.mdkDrawer) {
      return
    }
    document.querySelector('body').classList[e.target.mdkDrawer.opened ? 'add' : 'remove']('has-drawer-opened')
    let button = document.querySelector('[data-target="#' + e.target.id + '"]')
    if (button) {
      button.classList[e.target.mdkDrawer.opened ? 'add' : 'remove']('active')
    }
  })
})

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