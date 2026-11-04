/*!
 * ezdemo: the gallery viewer, in plain JavaScript (no jQuery), CSP-safe.
 * GNU General Public License v2.0 (or any later version). Exponential Foundation and 7x.
 *
 * Replaces ezgallery.js, ezgallerynavigator.js and ezsimplegallery.js ($.eZ.Gallery and its navigator): every
 * [data-ed-gallery] holds links (a[data-ed-full]) to the large pictures; a click opens them in a <dialog> lightbox
 * with the title and caption, previous/next buttons, the arrow keys, swipe, Escape and a counter. Without
 * JavaScript the links open the image pages, as before.
 *   a[data-ed-full="<large image url>"][data-ed-title][data-ed-caption-id="<id of the caption element>"]
 * Texts come from data-text-close, data-text-prev, data-text-next, data-text-count ("%index of %count").
 */
(function (window, document) {
    'use strict';

    var dialog, img, title, caption, counter, items = [], index = 0, opener = null, pushed = false;

    // the browser's Back closes the lightbox (opening it adds a history entry)
    window.addEventListener('popstate', function () {
        if (dialog && dialog.open) { pushed = false; dialog.close(); }
    });

    function text(g, key, def) { return g.getAttribute('data-text-' + key) || def; }

    function build(g) {
        dialog = document.createElement('dialog');
        dialog.className = 'ed-lightbox';
        dialog.setAttribute('aria-label', text(g, 'label', 'Gallery'));
        dialog.innerHTML =
            '<div class="ed-lightbox-bar"><span class="ed-lightbox-count" aria-live="polite"></span>' +
            '<button type="button" class="ed-icon-btn" data-go="close"><svg viewBox="0 0 24 24" aria-hidden="true" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><path d="M6 6l12 12M18 6L6 18"/></svg><span class="ed-sr"></span></button></div>' +
            '<div class="ed-lightbox-stage"><button type="button" class="ed-icon-btn ed-lightbox-prev" data-go="prev"><svg viewBox="0 0 24 24" aria-hidden="true" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><path d="M15 5l-7 7 7 7"/></svg><span class="ed-sr"></span></button>' +
            '<figure><img alt=""><figcaption class="ed-lightbox-caption"><strong></strong><div></div></figcaption></figure>' +
            '<button type="button" class="ed-icon-btn ed-lightbox-next" data-go="next"><svg viewBox="0 0 24 24" aria-hidden="true" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><path d="M9 5l7 7-7 7"/></svg><span class="ed-sr"></span></button></div>';
        var sr = dialog.querySelectorAll('.ed-sr');
        sr[0].textContent = text(g, 'close', 'Close');
        sr[1].textContent = text(g, 'prev', 'Previous picture');
        sr[2].textContent = text(g, 'next', 'Next picture');
        img = dialog.querySelector('img');
        title = dialog.querySelector('figcaption strong');
        caption = dialog.querySelector('figcaption div');
        counter = dialog.querySelector('.ed-lightbox-count');
        dialog.addEventListener('click', function (e) {
            var b = e.target.closest('[data-go]');
            if (b) { go(b.getAttribute('data-go')); }
            // a click beside the picture (the backdrop, the empty stage or bar) closes
            else if (!e.target.closest('img, figcaption, a')) { go('close'); }
        });
        dialog.addEventListener('keydown', function (e) {
            if (e.key === 'ArrowRight') { go('next'); e.preventDefault(); }
            if (e.key === 'ArrowLeft') { go('prev'); e.preventDefault(); }
        });
        dialog.addEventListener('close', function () {
            // closed by the button, Escape or a click: drop the history entry the opening added
            if (pushed) { pushed = false; history.back(); }
            if (opener) { opener.focus(); }
        });
        var x0 = null;
        dialog.addEventListener('touchstart', function (e) { x0 = e.touches[0].clientX; }, { passive: true });
        dialog.addEventListener('touchend', function (e) {
            if (x0 === null) { return; }
            var dx = e.changedTouches[0].clientX - x0;
            if (Math.abs(dx) > 50) { go(dx < 0 ? 'next' : 'prev'); }
            x0 = null;
        });
        document.body.appendChild(dialog);
        dialog.setAttribute('data-count-text', text(g, 'count', '%index of %count'));
    }

    function show(i) {
        index = (i + items.length) % items.length;
        var a = items[index];
        img.src = a.getAttribute('data-ed-full');
        img.alt = a.getAttribute('data-ed-alt') || '';
        title.textContent = a.getAttribute('data-ed-title') || '';
        var cap = a.getAttribute('data-ed-caption-id') && document.getElementById(a.getAttribute('data-ed-caption-id'));
        caption.innerHTML = cap ? cap.innerHTML : '';
        counter.textContent = dialog.getAttribute('data-count-text').replace('%index', index + 1).replace('%count', items.length);
        var next = items[(index + 1) % items.length];
        if (next) { (new Image()).src = next.getAttribute('data-ed-full'); }
    }

    function go(what) {
        if (what === 'close') { dialog.close(); }
        else { show(index + (what === 'next' ? 1 : -1)); }
    }

    document.addEventListener('click', function (e) {
        var a = e.target.closest ? e.target.closest('[data-ed-gallery] a[data-ed-full]') : null;
        if (!a || e.metaKey || e.ctrlKey || e.shiftKey || typeof HTMLDialogElement !== 'function') { return; }
        e.preventDefault();
        var g = a.closest('[data-ed-gallery]');
        if (!dialog) { build(g); }
        items = Array.prototype.slice.call(g.querySelectorAll('a[data-ed-full]'));
        opener = a;
        show(items.indexOf(a));
        dialog.showModal();
        try { history.pushState({ edLightbox: true }, ''); pushed = true; } catch (err) { pushed = false; }
    });
})(window, document);
