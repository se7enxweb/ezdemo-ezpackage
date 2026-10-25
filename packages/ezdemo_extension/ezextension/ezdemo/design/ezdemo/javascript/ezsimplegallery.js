(function ($) {
    'use strict';

    $.eZ = $.eZ || {};

    var defaultConfig = {
        gallery: '',
        next: '.next',
        prev: '.prev',
        indicators: '.indicator li',
        selectedIndactorClass: 'selected',
        container: '.images',
        images: 'figure',
        transitionDuration: 0.8,
        easing: 'cubic-bezier'
    };

    /**
     * Constructor of $.eZ.SimpleGallery component
     *
     * @param conf configuration object containing:
     *      - gallery (required): the element (DOM or jQuery) or a selector to the element containing the gallery
     *      - next (default .next): selector to the element that allows to see the next image
     *      - prev (default .prev): selector to the element that allows to see the previous image
     *      - indicators (default .indicators li): selector to elements that will be used as an indicator of the position in the gallery
     *      - selectedIndactorClass (default selected): class to set on the indicator corresponding to the selected image
     *      - container (default .images): selector to the element containing the images, its left CSS value will be changed
     *      - images (default figure): selector to element representing an image
     *      - transitionDuration (default 0.8): number of second the transition should last between two images
     *      - easing: the easing to use for the transition (a CSS timing function)
     */
    function eZSG(conf) {
        this.conf = $.extend({}, defaultConfig, conf);

        this.gallery = $(this.conf.gallery).first();

        this.container = this.gallery.find(this.conf.container).first();
        this.next = this.gallery.find(this.conf.next).first();
        this.prev = this.gallery.find(this.conf.prev).first();
        this.indicators = this.gallery.find(this.conf.indicators);

        this.index = 0;
        this.total = this.gallery.find(this.conf.images).length;

        this._init();
    }

    /**
     * Initialises the component:
     *  - init click events on prev/next links and on the indicators
     *  - init resize event to adapt the position of the currently seen images
     */
    eZSG.prototype._init = function () {
        var that = this;

        this.next.on('click', function (e) {
            e.preventDefault();
            that.showNext();
        });
        this.prev.on('click', function (e) {
            e.preventDefault();
            that.showPrev();
        });
        $(window).on('resize', function () {
            // realign the gallery when the window is resized
            that.scrollTo(that.index);
        });

        this.indicators.each(function (k, ind) {
            $(ind).on('click', function () {
                if ( !this.classList.contains(that.conf.selectedIndactorClass) ) {
                    that.scrollTo(k);
                }
            });
        });
    };

    /**
     * Scrolls to the next images if there's one
     */
    eZSG.prototype.showNext = function () {
        if ( this.index == (this.total - 1) ) {
            return;
        }
        this.scrollTo(this.index + 1);
    };

    /**
     * Scrolls to the previous images if there's one
     */
    eZSG.prototype.showPrev = function () {
        if ( this.index == 0 ) {
            return;
        }
        this.scrollTo(this.index - 1);
    };

    /**
     * Scrolls to a given image by its index
     */
    eZSG.prototype.scrollTo = function (newIndex) {
        var f = 1, s = this.conf.selectedIndactorClass,
            c = this.container, o = this.index * this._getOffset() * -1,
            hasIndicator = (this.indicators.length > 0);

        f = this.index - newIndex;

        if ( f != 0 ) {
            if ( hasIndicator )
                this.indicators.eq(this.index).removeClass(s);
            this.index = newIndex;
            if ( hasIndicator )
                this.indicators.eq(this.index).addClass(s);
        }

        var target = o + (f * this._getOffset());
        c.ezTransition({
            left: {
                value: target + 'px',
                duration: this.conf.transitionDuration,
                easing: this.conf.easing
            }
        });
        this._handleNavigationLink();
    };

    /**
     * Calculates the offset between two images
     */
    eZSG.prototype._getOffset = function () {
        return this.gallery[0].clientWidth;
    };

    /**
     * Shows and Hides previous/next links when needed
     */
    eZSG.prototype._handleNavigationLink = function () {
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
            this.prev.ezTransition(hideC);
        } else if ( this.index >= 1 ) {
            this.prev.ezTransition(showC);
        }

        if ( this.index == (this.total - 1) ) {
            this.next.ezTransition(hideC);
        } else if ( this.index <= (this.total - 2) ) {
            this.next.ezTransition(showC);
        }
    };

    $.eZ.SimpleGallery = eZSG;

    /**
     * $(selector).ezSimpleGallery(conf): one $.eZ.SimpleGallery per element,
     * the element being the gallery
     */
    $.fn.ezSimpleGallery = function (conf) {
        return this.each(function () {
            if ( !$.data(this, 'ezSimpleGallery') ) {
                $.data(this, 'ezSimpleGallery', new eZSG($.extend({}, conf, { gallery: this })));
            }
        });
    };

})(jQuery);
