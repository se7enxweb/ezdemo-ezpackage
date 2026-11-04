/*!
 * ezdemo: the behavior of the page frame, in plain JavaScript on expui's Exp core (no jQuery), CSP-safe.
 * GNU General Public License v2.0 (or any later version). Exponential Foundation and 7x.
 *
 * Replaces the jQuery scripts of the old design: toggle_class.js (data-action="toggleclass"), handle_transition.js
 * and eztransition.js (the login form and language list shown through the location hash), init_ua.js (browser
 * classes, now feature queries in the stylesheet) and heightresize.js (equal heights, now CSS grid).
 *
 *   [data-ed-menu]          the menu button of the phone layout: opens the navigation, Escape closes it
 *   [data-ed-disclosure]    a button that shows the element named by aria-controls (the "More" menu, the login form)
 *   [data-ed-theme]         the light/dark switch (stored in localStorage "ezdemo-theme")
 *   .ed-reveal              fades in when scrolled into view (only when the reader allows motion)
 *   [data-action=toggleclass][data-class][data-target]   toggles a class on the targets (older templates)
 *   .transition-showed      shown through the location hash; a click outside hides it again (older templates)
 */
(function (window, document) {
    'use strict';

    var Exp = window.Exp || {};
    var reduced = window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches;

    function each(sel, fn, ctx) { Array.prototype.forEach.call((ctx || document).querySelectorAll(sel), fn); }

    // ---- disclosures: "More" in the menu, the sign-in form ----------------------------------------------------
    function closeDisclosure(btn) {
        var target = document.getElementById(btn.getAttribute('aria-controls'));
        btn.setAttribute('aria-expanded', 'false');
        if (target) { target.hidden = true; }
    }
    function closeAll(except) {
        each('[data-ed-disclosure][aria-expanded="true"]', function (b) { if (b !== except) { closeDisclosure(b); } });
    }
    document.addEventListener('click', function (e) {
        var btn = e.target.closest ? e.target.closest('[data-ed-disclosure]') : null;
        if (btn) {
            var open = btn.getAttribute('aria-expanded') === 'true';
            closeAll(btn);
            var target = document.getElementById(btn.getAttribute('aria-controls'));
            btn.setAttribute('aria-expanded', open ? 'false' : 'true');
            if (target) {
                target.hidden = open;
                var first = !open && target.querySelector('input, a, button');
                if (first && btn.hasAttribute('data-ed-focus')) { first.focus(); }
            }
            return;
        }
        each('[data-ed-disclosure][aria-expanded="true"]', function (b) {
            var target = document.getElementById(b.getAttribute('aria-controls'));
            if (target && !target.contains(e.target)) { closeDisclosure(b); }
        });
    });

    // ---- the phone menu ---------------------------------------------------------------------------------------
    function setMenu(header, btn, open) {
        header.classList.toggle('is-open', open);
        document.body.classList.toggle('ed-nav-open', open);
        btn.setAttribute('aria-expanded', open ? 'true' : 'false');
    }
    each('[data-ed-menu]', function (btn) {
        var header = btn.closest('.ed-header');
        if (!header) { return; }
        btn.addEventListener('click', function () { setMenu(header, btn, !header.classList.contains('is-open')); });
        window.matchMedia('(min-width: 961px)').addEventListener('change', function (m) { if (m.matches) { setMenu(header, btn, false); } });
    });
    document.addEventListener('keydown', function (e) {
        if (e.key !== 'Escape') { return; }
        var open = document.querySelector('[data-ed-disclosure][aria-expanded="true"]');
        if (open) { closeDisclosure(open); open.focus(); return; }
        each('.ed-header.is-open [data-ed-menu]', function (btn) { setMenu(btn.closest('.ed-header'), btn, false); btn.focus(); });
    });

    // ---- light / dark -----------------------------------------------------------------------------------------
    function currentTheme() {
        var t = document.documentElement.getAttribute('data-theme');
        if (t) { return t; }
        return window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
    }
    each('[data-ed-theme]', function (btn) {
        var label = function () {
            var dark = currentTheme() === 'dark';
            btn.setAttribute('aria-pressed', dark ? 'true' : 'false');
            btn.setAttribute('aria-label', btn.getAttribute(dark ? 'data-label-light' : 'data-label-dark') || btn.getAttribute('aria-label'));
        };
        label();
        btn.addEventListener('click', function () {
            var next = currentTheme() === 'dark' ? 'light' : 'dark';
            document.documentElement.setAttribute('data-theme', next);
            try { window.localStorage.setItem('ezdemo-theme', next); } catch (e) { /* not stored: this page only */ }
            label();
        });
    });

    // ---- scroll reveal ----------------------------------------------------------------------------------------
    var reveal = document.querySelectorAll('.ed-reveal');
    if (reveal.length) {
        if (reduced || !('IntersectionObserver' in window)) {
            each('.ed-reveal', function (el) { el.classList.add('is-in'); });
        } else {
            var io = new IntersectionObserver(function (entries) {
                entries.forEach(function (en) { if (en.isIntersecting) { en.target.classList.add('is-in'); io.unobserve(en.target); } });
            }, { rootMargin: '0px 0px -8% 0px', threshold: 0.08 });
            each('.ed-reveal', function (el) { io.observe(el); });
        }
    }

    // ---- older templates: data-action="toggleclass" and .transition-showed --------------------------------------
    document.addEventListener('click', function (e) {
        var el = e.target.closest ? e.target.closest('[data-action="toggleclass"]') : null;
        if (el) {
            e.preventDefault();
            each(el.getAttribute('data-target'), function (t) { t.classList.toggle(el.getAttribute('data-class')); });
            return;
        }
        each('.transition-showed', function (box) {
            if (box.id && box.id === window.location.hash.slice(1) && !box.contains(e.target)) {
                history.replaceState(null, '', window.location.pathname + window.location.search);
                box.classList.remove('is-shown');
            }
        });
    });

    // ---- the strip of the gallery block: previous / next buttons ----------------------------------------------
    each('[data-ed-strip]', function (wrap) {
        var track = wrap.querySelector('.ed-strip');
        if (!track) { return; }
        each('[data-ed-strip-go]', function (b) {
            b.addEventListener('click', function () {
                var dir = b.getAttribute('data-ed-strip-go') === 'next' ? 1 : -1;
                track.scrollBy({ left: dir * track.clientWidth * 0.8, behavior: reduced ? 'auto' : 'smooth' });
            });
        }, wrap);
    });

    if (Exp.emit) { Exp.emit('ezdemo:ready'); }
})(window, document);

// ---- "Copy link" of the share buttons (parts/social_buttons.tpl) ------------------------------------------------
document.addEventListener('click', function (e) {
    var b = e.target.closest ? e.target.closest('[data-ed-copy]') : null;
    if (!b || !navigator.clipboard) { return; }
    navigator.clipboard.writeText(b.getAttribute('data-ed-copy')).then(function () {
        b.classList.add('is-done');
        var s = b.parentNode.querySelector('.ed-share-status');
        if (s) { s.textContent = b.getAttribute('data-text-done') || ''; }
        setTimeout(function () { b.classList.remove('is-done'); }, 2000);
    });
});
