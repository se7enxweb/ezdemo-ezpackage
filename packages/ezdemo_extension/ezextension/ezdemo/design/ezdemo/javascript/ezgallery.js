(function ($) {
    'use strict';

    $.eZ = $.eZ || {};

    var defaultConfig = {
        container: '.gallery-viewer',
        title: 'h2 a',
        counter: '.counter span',
        image: 'figure > img',
        caption: 'figcaption',
        figure: 'figure',
        transitionDuration: 0.8,
        autoScrollOnSelect: true,
        autoFixSizes: true,
        initFunc: function () { },
        updateFunc: function (elem) { },
        navigator: $.eZ.GalleryNavigator ? $.eZ.GalleryNavigator.DEFAULT_CONFIG : {}
    };

    /**
     * Constructor of the $.eZ.Gallery components
     * (needs ezgallerynavigator.js and eztransition.js)
     *
     * @param conf
     */
    function eZG(conf) {
        this.conf = $.extend({}, defaultConfig, conf);
        this.navigator = new $.eZ.GalleryNavigator(this.conf.navigator);
        this._init();

        this.hasStarted = false;
    }

    /**
     * Initialises the $.eZ.Gallery
     *  - call the init function from the configuration
     *  - set the event handler from $.eZ.GalleryNavigator
     *  - set the event handler on window resize
     */
    eZG.prototype._init = function () {
        var that = this;

        this.container = $(this.conf.container).first();
        this._fixSizes();
        this.conf.initFunc.call(this);

        this.navigator.on('select', function (item) {
            that.hasStarted = true;
            if ( that.conf.autoScrollOnSelect ) {
                that.container[0].scrollIntoView(true);
            }
            // if index == previous we are after a resize
            // so we don't need a transition
            that.update(item, (item.index != item.previous));
        });

        $(window).on('resize', function () {
            if ( that.hasStarted && that.conf.autoScrollOnSelect ) {
                that.container[0].scrollIntoView(true);
            }
            that.navigator.select();
        });
    };

    /**
     * Updates the visible image
     *
     * @param item object send by $.eZ.GalleryNavigator when a selection is done
     * @param animate bool, whether an animation is required or not
     */
    eZG.prototype.update = function (item, animate) {
        if ( animate ) {
            this.container.css('opacity', 0);
            this.conf.updateFunc.call(this, item);
            this._fixSizes();
            this.container.ezTransition({
                duration: this.conf.transitionDuration,
                opacity: 1
            });
        } else {
            this.conf.updateFunc.call(this, item);
            this._fixSizes();
        }
    };

    /**
     * fix the size of the figure and img element so that the gallery fits
     * on the browser window and the figcaption is visible if there's any
     *
     * @private
     */
    eZG.prototype._fixSizes = function () {
        if ( !this.conf.autoFixSizes ) {
            return;
        }
        var c = this.container,
            fig = c.find(this.conf.figure).first(),
            nav = this.navigator.getContainer(),
            caption = c.find(this.conf.caption).first(),
            img = c.find(this.conf.image).first(),
            offsetFig = 0, figH = 0, offsetImg = 0,
            imgRatio = parseInt(img.attr('width')) / parseInt(img.attr('height'));

        // compute the figure height so that the bottom of the navigator is aligned
        // with the bottom of the viewport.
        fig.css('height', 'auto');
        offsetFig = nav.offset().top + nav[0].offsetHeight - c.offset().top - window.innerHeight;
        figH = fig[0].offsetHeight - offsetFig;
        fig.css('height', figH + 'px');

        img.css({height: 'auto', width: 'auto'});
        offsetImg = img[0].offsetHeight + (caption.length ? caption[0].offsetHeight : 0) - figH;
        if ( offsetImg > 0 ) {
            var imgH = img[0].offsetHeight - offsetImg,
                imgW = imgH * imgRatio;
            if ( imgH > parseInt(img.attr('height')) ) {
                // don't upscale
                imgH = parseInt(img.attr('height'));
                imgW = imgH * imgRatio;
            }
            img.css({height: imgH + 'px', width: imgW + 'px'});
        }
    };

    $.eZ.Gallery = eZG;

})(jQuery);
