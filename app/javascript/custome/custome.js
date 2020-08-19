$(document).on('turbolinks:before-cache', function(e) {
    $("select.select2-hidden-accessible").select2('destroy');
});

document.addEventListener("turbolinks:load", function () {
    $('.select2').select2();
});
