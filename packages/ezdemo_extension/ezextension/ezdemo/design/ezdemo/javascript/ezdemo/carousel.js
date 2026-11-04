/*!
 * ezdemo: the campaign carousel, in plain JavaScript (no jQuery), CSP-safe.
 * GNU General Public License v2.0 (or any later version). Exponential Foundation and 7x.
 *
 * Replaces ezsimplegallery.js and eztransition.js as used by the campaign block: [data-ed-carousel] holds a
 * scroll-snap track (.ed-carousel-track) of slides; the dots and the previous/next buttons move it, the arrow keys
 * work on the track, the current dot follows the scroll position. Optional autoplay
 * (data-ed-autoplay="<seconds>") pauses on hover and focus and never runs when the reader prefers reduced motion.
 * Without JavaScript the track still scrolls and snaps.
 */
(function (window, document) {
    'use strict';
    var reduced = window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches;

    Array.prototype.forEach.call(document.querySelectorAll('[data-ed-carousel]'), function (c) {
        var track = c.querySelector('.ed-carousel-track');
        var slides = track ? track.children : [];
        if (!track || slides.length < 2) { return; }
        var dots = c.querySelectorAll('.ed-dots button');
        var current = 0, timer = null, paused = false;

        function goTo(i) {
            current = (i + slides.length) % slides.length;
            track.scrollTo({ left: slides[current].offsetLeft - track.offsetLeft, behavior: reduced ? 'auto' : 'smooth' });
        }
        function mark() {
            var i = Math.round(track.scrollLeft / Math.max(1, track.clientWidth));
            current = Math.min(slides.length - 1, Math.max(0, i));
            Array.prototype.forEach.call(dots, function (d, k) { d.setAttribute('aria-current', k === current ? 'true' : 'false'); });
            Array.prototype.forEach.call(slides, function (s, k) { s.setAttribute('aria-hidden', k === current ? 'false' : 'true'); s.inert = k !== current; });
        }
        Array.prototype.forEach.call(dots, function (d, k) { d.addEventListener('click', function () { goTo(k); }); });
        Array.prototype.forEach.call(c.querySelectorAll('[data-ed-go]'), function (b) {
            b.addEventListener('click', function () { goTo(current + (b.getAttribute('data-ed-go') === 'next' ? 1 : -1)); });
        });
        track.addEventListener('keydown', function (e) {
            if (e.key === 'ArrowRight') { goTo(current + 1); e.preventDefault(); }
            if (e.key === 'ArrowLeft') { goTo(current - 1); e.preventDefault(); }
        });
        var t = null;
        track.addEventListener('scroll', function () { clearTimeout(t); t = setTimeout(mark, 80); }, { passive: true });
        mark();

        var secs = parseInt(c.getAttribute('data-ed-autoplay') || '0', 10);
        if (secs > 0 && !reduced) {
            ['mouseenter', 'focusin'].forEach(function (ev) { c.addEventListener(ev, function () { paused = true; }); });
            ['mouseleave', 'focusout'].forEach(function (ev) { c.addEventListener(ev, function () { paused = false; }); });
            timer = setInterval(function () { if (!paused && !document.hidden) { goTo(current + 1); } }, secs * 1000);
        }
    });
})(window, document);
