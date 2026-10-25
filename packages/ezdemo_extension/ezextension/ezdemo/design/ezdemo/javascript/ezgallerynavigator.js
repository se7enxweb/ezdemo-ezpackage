(function ($) {
    'use strict';

    $.eZ = $.eZ || {};

    var defaultConfig = {
        gallery: '',
        next: '.next',
        prev: '.prev',
        cursor: '.cursor',
        container: '.images',
        images: 'figure',
        transitionDuration: 0.5,
        easing: 'cubic-bezier'
    };

    // inline style first (the target of a running transition), computed style otherwise
    function style(el, prop) {
        el = $(el)[0];
        return el.style[prop] || window.getComputedStyle(el)[prop];
    }

    function width(el) {
        return parseInt(style(el, 'width'));
    }

    function left(el) {
        return parseInt(style(el, 'left'));
    }

    // x position of the element in the document
    function getX(el) {
        return $(el).offset().left;
    }

    /**
     * Constructor of the $.eZ.GalleryNavigator component
     *
     * @param conf
     */
    function eZGN(conf) {
        this.conf = $.extend({}, defaultConfig, conf);
        this._listeners = {};

        this.gallery = $(this.conf.gallery).first();

        this.container = this.gallery.find(this.conf.container).first();
        this.nextLink = this.gallery.find(this.conf.next).first();
        this.prevLink = this.gallery.find(this.conf.prev).first();

        this.images = this.container.find(this.conf.images);
        this.index = 0;
        this.total = this.images.length;

        this.cursor = this.gallery.find(this.conf.cursor).first();
        this.cursor.css({
            left: this._computeCursorX(this.getSelectedImage()) + 'px',
            display: 'inline-block'
        });

        this._init();
    }

    eZGN.DEFAULT_CONFIG = defaultConfig;

    eZGN.prototype._init = function () {
        var that = this;

        this.nextLink.on('click', function (e) {
            e.preventDefault();
            that.next();
        });

        this.prevLink.on('click', function (e) {
            e.preventDefault();
            that.previous();
        });

        this.images.each(function (k, img) {
            $(img).on('click', function (e) {
                e.preventDefault();
                that.select(k);
            });
        });
    };

    eZGN.NAME = 'gallerynavigator';

    /**
     * Subscribes to an event, "select" is fired when an image is selected.
     * Listeners are called with the navigator as this and an event object.
     */
    eZGN.prototype.on = function (type, fn) {
        (this._listeners[type] = this._listeners[type] || []).push(fn);
        return this;
    };

    /**
     * Fires an event
     */
    eZGN.prototype.fire = function (type, data) {
        var l = (this._listeners[type] || []).slice(),
            e = $.extend({ type: type, target: this }, data);
        for ( var i = 0; i < l.length; i++ ) {
            l[i].call(this, e);
        }
    };

    /**
     * Returns the selected figure
     *
     * @return jQuery
     */
    eZGN.prototype.getSelectedImage = function () {
        return this.images.eq(this.index);
    };

    /**
     * Returns a list of figures in the navigator
     *
     * @return jQuery
     */
    eZGN.prototype.getImages = function () {
        return this.images;
    };

    /**
     * Returns the main container of the navigator
     *
     * @return jQuery
     */
    eZGN.prototype.getContainer = function () {
        return this.container;
    };

    /**
     * Selects an image based on its position. When this method is called,
     * it fires the 'select' event.
     *
     * @param i integer
     */
    eZGN.prototype.select = function (i) {
        var p = this.index;

        if ( typeof i !== 'undefined' ) {
            this.index = i;
        }

        var s = this.getSelectedImage();
        this.fire('select', {
            index: this.index,
            previous: p,
            total: this.total,
            imageNode: s
        });
        this._handleNavigationLink();
        this._animate();
    };

    /**
     * Moves to the next image if possible
     */
    eZGN.prototype.next = function () {
        if ( this.index == (this.total - 1) ) {
            return;
        }
        this.select(this.index + 1);
    };

    /**
     * Moves to the previous image if possible
     */
    eZGN.prototype.previous = function () {
        if ( this.index == 0 ) {
            return;
        }
        this.select(this.index - 1);
    };

    /**
     * Checks whether the selected image is outside of the navigator
     * on the right
     *
     * @private
     */
    eZGN.prototype._isSelectedImageOutsideRight = function () {
        var s = this.getSelectedImage(),
            lRight = getX(this.gallery) + width(this.gallery);
        return (getX(s) + width(s)) > lRight;
    };

    /**
     * Checks whether the selected image is outside of the navigator
     * on the left
     *
     * @private
     */
    eZGN.prototype._isSelectedImageOutsideLeft = function () {
        return getX(this.getSelectedImage()) < getX(this.gallery);
    };

    /**
     * Computes the left position of the cusor so that it is centered
     * on the s figure.
     *
     * @param s jQuery object of the selected figure
     * @private
     */
    eZGN.prototype._computeCursorX = function (s) {
        var offset = getX(this.gallery),
            selectedWidth = width(s),
            cursorWidth = width(this.cursor);
        return getX(s) - offset + selectedWidth / 2 - cursorWidth / 2;
    };

    /**
     * Animates the cursor and/or the container of images
     *
     * @private
     */
    eZGN.prototype._animate = function () {
        var trConf = {
                duration: this.conf.transitionDuration,
                easing: this.conf.easing
            }, sel = this.getSelectedImage(),
            cursorX = this._computeCursorX(sel), containerX, containerXOrig;

        if ( this._isSelectedImageOutsideRight() ) {
            // Image is outside in the right
            // Moving images so that selected images becomes the first visible one
            containerXOrig = left(this.container);
            containerX = getX(this.container) - getX(sel);
            cursorX += containerX - containerXOrig;
            trConf['left'] = containerX + 'px';
            this._doTransition(this.container, trConf);
        } else if ( this._isSelectedImageOutsideLeft() ) {
            // Image is outside in the left
            // Looking for the image in the left so that the selected image is the last visible one
            containerXOrig = left(this.container);
            var selectedBorderLeft = getX(sel) + width(sel), sizeBetween,
                widthGallery = width(this.gallery);
            for ( var i = this.index; i >= 0; i-- ) {
                sizeBetween = selectedBorderLeft - getX(this.images.eq(i));
                if ( sizeBetween > widthGallery ) {
                    i++;
                    // this.images.eq(i) should be the first visible
                    break;
                }
            }
            if ( i < 0 )
                i = 0;
            containerX = getX(this.container) - getX(this.images.eq(i));
            cursorX += containerX - containerXOrig;
            trConf['left'] = containerX + 'px';
            this._doTransition(this.container, trConf);
        }
        trConf['left'] = cursorX + 'px';
        this._doTransition(this.cursor, trConf);
    };

    /**
     * Runs a CSS transition on node
     */
    eZGN.prototype._doTransition = function (node, conf) {
        node.ezTransition($.extend({}, conf));
    };

    /**
     * Shows and Hides previous/next links when needed
     */
    eZGN.prototype._handleNavigationLink = function () {
        var d = this.conf.transitionDuration,
            showC = {
                opacity: 1,
                duration: d
            },
            hideC = {
                opacity: 0,
                duration: d
            };

        if ( this.index == 0 ) {
            this.prevLink.ezTransition(hideC);
        } else if ( this.index >= 1 ) {
            this.prevLink.ezTransition(showC);
        }

        if ( this.index == (this.total - 1) ) {
            this.nextLink.ezTransition(hideC);
        } else if ( this.index <= (this.total - 2) ) {
            this.nextLink.ezTransition(showC);
        }
    };

    $.eZ.GalleryNavigator = eZGN;

})(jQuery);
