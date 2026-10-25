jQuery(function ($) {
    var elems = $('.transition-showed');

    if ( !elems.length ) {
        return;
    }
    // a click outside an element shown through the location hash hides it
    $(document).on('click', function (e) {
        elems.each(function () {
            if ( this !== e.target && !this.contains(e.target)
                    && this.id === location.hash.replace('#', '') ) {
                location.hash = '';
            }
        });
    });
});
