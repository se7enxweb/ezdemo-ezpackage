/**
 * jQuery.fn.ezTransition: animates CSS properties with native CSS transitions.
 *
 * Shared by the Exponential demo design scripts (ezflyout, ezsimplegallery,
 * ezgallerynavigator, ezgallery).
 *
 * conf accepts:
 *  - duration (seconds, default 0.5), easing (default "ease"), delay (seconds)
 *  - on: { start: function, end: function } callbacks, called with the element as this
 *  - any other key is a CSS property (camelCase or dashed) and its value is
 *    either the target value or an object { value, duration, easing, delay }
 */
(function ($) {
    'use strict';

    var RESERVED = { duration: 1, easing: 1, delay: 1, on: 1 },
        TIMER_KEY = 'ezTransitionTimer';

    function toNumber(v, def) {
        v = parseFloat(v);
        return isNaN(v) ? def : v;
    }

    function toEasing(e, def) {
        if ( typeof e !== 'string' || e === '' ) {
            return def;
        }
        if ( window.CSS && typeof window.CSS.supports === 'function'
                && !window.CSS.supports('transition-timing-function', e) ) {
            // an invalid timing function falls back to the CSS default
            return 'ease';
        }
        return e;
    }

    function dashed(name) {
        return name.replace(/[A-Z]/g, function (m) {
            return '-' + m.toLowerCase();
        });
    }

    function run(el, conf, done) {
        var duration = toNumber(conf.duration, 0.5),
            easing = toEasing(conf.easing, 'ease'),
            delay = toNumber(conf.delay, 0),
            on = conf.on || {},
            props = [], longest = 0, computed, k, v, p, i,
            previous = $.data(el, TIMER_KEY);

        for ( k in conf ) {
            if ( !Object.prototype.hasOwnProperty.call(conf, k) || RESERVED[k] ) {
                continue;
            }
            v = conf[k];
            p = { name: dashed(k), duration: duration, easing: easing, delay: delay };
            if ( v !== null && typeof v === 'object' ) {
                p.duration = toNumber(v.duration, duration);
                p.easing = toEasing(v.easing, easing);
                p.delay = toNumber(v.delay, delay);
                v = v.value;
            }
            p.value = String(v);
            props.push(p);
            longest = Math.max(longest, p.duration + p.delay);
        }

        if ( previous ) {
            clearTimeout(previous);
        }

        // start from the current (possibly mid transition) values
        computed = window.getComputedStyle(el);
        el.style.transition = 'none';
        for ( i = 0; i < props.length; i++ ) {
            el.style.setProperty(props[i].name, computed.getPropertyValue(props[i].name));
        }
        void el.offsetWidth;

        el.style.transition = props.map(function (p) {
            return p.name + ' ' + p.duration + 's ' + p.easing + ' ' + p.delay + 's';
        }).join(', ');

        if ( typeof on.start === 'function' ) {
            on.start.call(el);
        }
        for ( i = 0; i < props.length; i++ ) {
            el.style.setProperty(props[i].name, props[i].value);
        }

        $.data(el, TIMER_KEY, setTimeout(function () {
            $.removeData(el, TIMER_KEY);
            el.style.transition = '';
            if ( typeof on.end === 'function' ) {
                on.end.call(el);
            }
            if ( typeof done === 'function' ) {
                done.call(el);
            }
        }, longest * 1000 + 20));
    }

    $.fn.ezTransition = function (conf, done) {
        conf = conf || {};
        return this.each(function () {
            run(this, conf, done);
        });
    };

})(jQuery);
