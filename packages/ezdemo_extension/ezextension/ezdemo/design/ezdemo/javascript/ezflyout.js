(function ($) {
    'use strict';

    $.eZ = $.eZ || {};

    var defaultConfig = {
        element: '',
        close: '.close',
        scrollTrigger: 0,
        trackInitialScroll: true,
        hideTransition: {

        },
        showTransition: {

        }
    };

    function isPlainObject(v) {
        return v !== null && typeof v === 'object' && !(v instanceof $) && !v.nodeType;
    }

    /**
     * Constructor of $.eZ.FlyOut object
     *
     * @param conf configuration object containing the following elements:
     *      - element String (required), a selector to the element that will be shown/hidden
     *      - close String (default ".close"), a selector relative the element pointing to nodes on which a click will hide the element
     *      - scrollTrigger (default 0) int|string|element if it's an integer, the number of pixel to scroll to show the element;
     *          if it's a string, a selector to an element, its y position will be used as the limit;
     *          if it's an element (DOM or jQuery), its y position will be used as the limit
     *      - trackInitialScroll bool (default true), if true, the $.eZ.FlyOut will check the initial scroll to show the element
     *      - hideTransition configuration object for the transition to hide the element
     *      - showTransition (required) configuration object for the transition to show the element
     *
     * See eztransition.js ($.fn.ezTransition) for the hideTransition and showTransition
     * configuration objects: duration, easing, delay, on.start/on.end and the CSS properties.
     * In addition, $.eZ.FlyOut also allows to put function instead of plain values in the transition properties.
     */
    function eZFlyOut(conf) {
        this.conf = $.extend({}, defaultConfig, conf);
        this.element = $(this.conf.element).first();
        this.hidden = true;
        this.scrollSubscription = false;
        this._listeners = {};

        this._initEvents();
    }

    /**
     * Subscribes to an event ("ready", "show", "hide", "close")
     */
    eZFlyOut.prototype.on = function (type, fn) {
        (this._listeners[type] = this._listeners[type] || []).push(fn);
        return this;
    };

    /**
     * Fires an event, listeners are called with the instance as this
     */
    eZFlyOut.prototype.fire = function (type, data) {
        var l = (this._listeners[type] || []).slice(),
            e = $.extend({ type: type, target: this }, data);
        for ( var i = 0; i < l.length; i++ ) {
            l[i].call(this, e);
        }
    };

    /**
     * Checks wether the $.eZ.FlyOut is hidden or not
     */
    eZFlyOut.prototype.isHidden = function () {
        return this.hidden;
    };

    /**
     * Shows the $.eZ.FlyOut using the show transition configuration object.
     * It triggers the "show" event.
     */
    eZFlyOut.prototype.show = function () {
        if ( this.isHidden() ) {
            this.element.ezTransition(
                this._transitionConf(this.conf.showTransition)
            );
            this.hidden = false;
            this.fire('show');
        }
    };

    /**
     * Hides the $.eZ.FlyOut using the hide transition configuration object.
     * It triggers the "hide" event.
     */
    eZFlyOut.prototype.hide = function () {
        if ( !this.isHidden() ) {
            this.element.ezTransition(
                this._transitionConf(this.conf.hideTransition)
            );
            this.hidden = true;
            this.fire('hide');
        }
    };

    /**
     * Closes the $.eZ.FlyOut. This method is supposed to be called when
     * the user clicks on a "close" element. It hides the element and
     * completely disables the $.eZ.FlyOut instance;
     * It triggers the "close" event.
     */
    eZFlyOut.prototype.close = function () {
        if ( this.scrollSubscription ) {
            $(window).off('scroll', this.scrollSubscription);
            this.scrollSubscription = false;
        }
        this.hide();
        this.fire('close');
    };

    /**
     * Initializes the events needed by $.eZ.FlyOut:
     *   - scroll event to detect the scroll beyond the configured limit
     *   - click event on a "close" element
     * @private
     */
    eZFlyOut.prototype._initEvents = function () {
        var that = this,
            handleScroll = function () {
            var limit = false, trigger = that.conf.scrollTrigger;
            if ( typeof trigger === 'number' ) {
                limit = trigger;
            } else {
                if ( typeof trigger === 'string' || (trigger && (trigger.nodeType || trigger instanceof $)) ) {
                    limit = $(trigger).first();
                }
                if ( !limit || !limit.length ) {
                    return;
                }
                limit = limit.offset().top;
            }
            if ( window.pageYOffset >= limit ) {
                that.show();
            } else {
                that.hide();
            }
        };

        this.scrollSubscription = handleScroll;
        $(window).on('scroll', handleScroll);

        this.element.on('click', this.conf.close, function () {
            that.close();
        });

        this.fire('ready');
        if ( this.conf.trackInitialScroll ) {
            handleScroll();
        }
    };

    /**
     * Creates a transition config object by cloning the conf parameter and
     * executing the methods it contains.
     *
     * @param conf configuration object
     * @private
     * @return object
     */
    eZFlyOut.prototype._transitionConf = function (conf) {
        var res = {}, k, v;
        for ( k in conf ) {
            if ( !Object.prototype.hasOwnProperty.call(conf, k) ) {
                continue;
            }
            v = conf[k];
            if ( typeof v === 'function' ) {
                res[k] = v.call(this);
            } else if ( k !== 'on' && isPlainObject(v) ) {
                res[k] = this._transitionConf(v);
            } else {
                res[k] = v;
            }
        }
        return res;
    };

    $.eZ.FlyOut = eZFlyOut;

})(jQuery);
