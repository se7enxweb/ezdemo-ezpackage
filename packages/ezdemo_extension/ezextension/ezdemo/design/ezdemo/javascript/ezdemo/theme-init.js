/*!
 * ezdemo: the reader's light or dark choice, applied before the page paints (loaded in <head>, no inline script).
 * GNU General Public License v2.0 (or any later version). Exponential Foundation and 7x.
 * Without a stored choice the page follows the system setting (prefers-color-scheme, in the stylesheet).
 */
(function (root) {
    'use strict';
    var choice = null;
    try { choice = window.localStorage.getItem('ezdemo-theme'); } catch (e) { /* storage blocked: follow the system */ }
    if (choice === 'light' || choice === 'dark') {
        root.setAttribute('data-theme', choice);
    }
    root.classList.add('js');
})(document.documentElement);
