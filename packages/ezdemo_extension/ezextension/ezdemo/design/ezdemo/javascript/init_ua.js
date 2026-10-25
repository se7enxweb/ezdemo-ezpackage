jQuery(function ($) {
    var h = document.documentElement,
        ua = navigator.userAgent,
        m;

    // turns "1.9.2" into 1.92, like the version numbers used before
    function numberify(s) {
        var c = 0;
        return parseFloat(s.replace(/\./g, function () {
            return (c++ === 1) ? '' : '.';
        }));
    }

    function addClasses() {
        for ( var i = 0; i < arguments.length; i++ ) {
            h.classList.add(arguments[i]);
        }
    }

    h.classList.add('js-enabled');

    if ( h.classList.contains('ie') ) {
        // conditional comments did the job
        return;
    }
    // the user agent string is a bad source,
    // but should be used only to fix "small" CSS issues
    if ( /MSIE |Trident\//.test(ua) ) {
        addClasses('ie', 'ie-gt9');
    } else if ( (m = ua.match(/AppleWebKit\/([^\s]*)/)) ) {
        addClasses('webkit', 'vers_' + (numberify(m[1]) + '').replace('.', '_'));
    } else if ( /Gecko\//.test(ua) && (m = ua.match(/rv:([^\s\)]*)/)) ) {
        addClasses('gecko', 'vers_' + (numberify(m[1]) + '').replace('.', '_'));
    }
});
