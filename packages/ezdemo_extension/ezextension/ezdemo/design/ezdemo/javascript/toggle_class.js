jQuery(function ($) {
    $('*[data-action=toggleclass]').each(function () {
        var elem = $(this),
            cl = elem.attr('data-class'),
            targets = $(elem.attr('data-target'));
        elem.on('click', function (e) {
            e.preventDefault();
            targets.toggleClass(cl);
        });
    });
});
