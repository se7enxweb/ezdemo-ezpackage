/*
 * ezdemo: the behavior of the design's templates, in a file instead of inline scripts and on...= attributes,
 * so a site can run with a Content Security Policy of script-src 'self'.
 *
 * Templates print this file with {ezscript( array( 'ezdemo_actions.js' ) )} where they need it; it may be printed
 * more than once on a page and sets itself up only once. Markup it reads:
 *
 *   data-ezdemo-toggle-checkboxes="<name>"   click inverts the checkboxes named <name> in the form named by
 *     data-ezdemo-form (or the closest form)
 *   data-ezdemo-select-all                   button switching all DeleteIDArray[] checkboxes of its form on and off;
 *     labels in data-ezdemo-label-select / data-ezdemo-label-deselect
 *   data-ezdemo-datepicker="date|datetime"   click calls showDatePicker( data-ezdemo-datepicker-base,
 *     data-ezdemo-datepicker-id, type ) when the page loaded the date picker
 *   data-ezdemo-show="<id>"                  click shows the element <id> and hides the link
 *   data-ezdemo-noop                         click does nothing (menu links while editing)
 *   data-ezdemo-diff-mode="<class>"          click sets the class of data-ezdemo-diff-target (version differences);
 *     .ezdemo-js-only[hidden] is shown when scripts run
 *   data-ezdemo-disable-buttons              click disables #PublishButton and #CancelButton right after the submit
 *   data-ezdemo-reset="<id>"                 change sets the value of the element <id> to 0
 *   data-ezdemo-autofocus                    the field is selected and focused when the page has loaded
 *   meta[name="ezdemo-print-link"]           adds the print <link> with the current query string
 *   fieldset.ezcca-collapsible                collapsible attribute groups of the edit page (jQuery)
 *   object[data-ezdemo-silverlight-autosize] the Silverlight plug-in takes the size of its content
 *   video[data-ezdemo-video-swf]             Flash fallback of video.js (_V_.options.flash.swf), set when printed
 *   .twitter-share-button, .fb-like + #fb-root, .g-plusone   the social buttons' scripts are loaded
 *   [data-ezdemo-campaign]                   campaign block: ezSimpleGallery()
 *   [data-ezdemo-gallery="full|embed|block"] the $.eZ.Gallery of the gallery full view, embed view and gallery block
 *   select[data-ezdemo-add-block="<attribute id>"]  landing page editor: names #addtoblock after the chosen block
 *   [data-ezdemo-ajax-search="<object id>"]  landing page editor: eZAJAXSearch with data-ezdemo-ajax-search-bullet
 *   [data-ezdemo-gmap-id]                    Google map of a location (data-ezdemo-gmap-lat, -lng) once the page loaded
 */
(function ( window, document )
{
    'use strict';

    // Silverlight plug-in callbacks, named by <param name="onError|onLoad|onResize">; defined as soon as the file runs.
    if ( typeof window.onErrorHandler !== 'function' )
    {
        window.onErrorHandler = function () {};
    }
    if ( typeof window.onLoadHandler !== 'function' )
    {
        window.onLoadHandler = function () {};
    }
    if ( typeof window.onResizeHandler !== 'function' )
    {
        window.onResizeHandler = function ( sender )
        {
            var host = sender && sender.getHost ? sender.getHost() : null;
            if ( host && host.getAttribute && host.getAttribute( 'data-ezdemo-silverlight-autosize' ) !== null )
            {
                host.width = sender.content.actualWidth;
                host.height = sender.content.actualHeight;
            }
        };
    }

    // The print <link>: the template is cached without the query string, so it is added here.
    function addPrintLink()
    {
        var metas = document.querySelectorAll( 'meta[name="ezdemo-print-link"]:not([data-ezdemo-done])' );
        for ( var i = 0; i < metas.length; i++ )
        {
            var meta = metas[i], link = document.createElement( 'link' );
            meta.setAttribute( 'data-ezdemo-done', '1' );
            link.rel = 'Alternate';
            link.href = meta.getAttribute( 'content' ) + document.location.search;
            link.media = 'print';
            link.title = meta.getAttribute( 'data-title' ) || '';
            ( document.head || document.getElementsByTagName( 'head' )[0] ).appendChild( link );
        }
    }
    addPrintLink();

    // video.js: the Flash fallback, before video.js sets the players up when the page has loaded
    var video = document.querySelector( 'video[data-ezdemo-video-swf]' );
    if ( video && window._V_ && window._V_.options && window._V_.options.flash )
    {
        window._V_.options.flash.swf = video.getAttribute( 'data-ezdemo-video-swf' );
    }

    // The social buttons' scripts (each loaded once, as their own snippets did)
    function loadScript( id, src )
    {
        if ( document.getElementById( id ) )
        {
            return;
        }
        var js = document.createElement( 'script' ), first = document.getElementsByTagName( 'script' )[0];
        js.id = id;
        js.async = true;
        js.src = src;
        first.parentNode.insertBefore( js, first );
    }
    if ( document.querySelector( '.twitter-share-button' ) )
    {
        loadScript( 'twitter-wjs', '//platform.twitter.com/widgets.js' );
    }
    if ( document.getElementById( 'fb-root' ) )
    {
        loadScript( 'facebook-jssdk', '//connect.facebook.net/en_US/all.js#xfbml=1' );
    }
    if ( document.querySelector( '.g-plusone' ) )
    {
        loadScript( 'ezdemo-plusone', 'https://apis.google.com/js/plusone.js' );
    }

    // Google map of a location attribute (the maps API is loaded by the template)
    window.eZGmapLocation_MapView = window.eZGmapLocation_MapView || function ( attributeId, latitude, longitude )
    {
        var zoommax = 13, startPoint, zoom;
        if ( latitude && longitude )
        {
            startPoint = new google.maps.LatLng( latitude, longitude );
            zoom = zoommax;
        }
        else
        {
            startPoint = new google.maps.LatLng( 0, 0 );
            zoom = 0;
        }
        var map = new google.maps.Map( document.getElementById( 'ezgml-map-' + attributeId ), { center: startPoint, zoom: zoom, mapTypeId: google.maps.MapTypeId.ROADMAP } );
        var marker = new google.maps.Marker( { map: map, position: startPoint } );
        return marker;
    };

    if ( window.ezdemoActions )
    {
        return;
    }
    window.ezdemoActions = true;

    function closest( el, selector )
    {
        while ( el && el.nodeType === 1 )
        {
            if ( el.matches ? el.matches( selector ) : el.msMatchesSelector( selector ) )
            {
                return el;
            }
            el = el.parentNode;
        }
        return null;
    }

    function formOf( el )
    {
        var name = el.getAttribute( 'data-ezdemo-form' );
        return ( name && document.forms[name] ) || closest( el, 'form' );
    }

    function setCheckboxes( form, name, value )
    {
        if ( !form )
        {
            return;
        }
        for ( var i = 0, l = form.elements.length; i < l; i++ )
        {
            var e = form.elements[i];
            if ( e.type === 'checkbox' && e.name === name && !e.disabled )
            {
                e.checked = value === null ? !e.checked : value;
            }
        }
    }

    document.addEventListener( 'click', function ( event )
    {
        var el;
        if ( ( el = closest( event.target, '[data-ezdemo-toggle-checkboxes]' ) ) )
        {
            event.preventDefault();
            setCheckboxes( formOf( el ), el.getAttribute( 'data-ezdemo-toggle-checkboxes' ), null );
        }
        else if ( ( el = closest( event.target, '[data-ezdemo-select-all]' ) ) )
        {
            var select = el.value === el.getAttribute( 'data-ezdemo-label-select' );
            el.value = el.getAttribute( select ? 'data-ezdemo-label-deselect' : 'data-ezdemo-label-select' );
            setCheckboxes( formOf( el ), 'DeleteIDArray[]', select );
        }
        else if ( ( el = closest( event.target, '[data-ezdemo-datepicker]' ) ) )
        {
            if ( typeof window.showDatePicker === 'function' )
            {
                window.showDatePicker( el.getAttribute( 'data-ezdemo-datepicker-base' ),
                                       el.getAttribute( 'data-ezdemo-datepicker-id' ),
                                       el.getAttribute( 'data-ezdemo-datepicker' ) );
            }
        }
        else if ( ( el = closest( event.target, '[data-ezdemo-show]' ) ) )
        {
            var target = document.getElementById( el.getAttribute( 'data-ezdemo-show' ) );
            if ( target )
            {
                event.preventDefault();
                target.style.display = '';
                el.style.display = 'none';
            }
        }
        else if ( ( el = closest( event.target, '[data-ezdemo-noop]' ) ) )
        {
            event.preventDefault();
        }
        else if ( ( el = closest( event.target, '[data-ezdemo-diff-mode]' ) ) )
        {
            event.preventDefault();
            var view = document.getElementById( el.getAttribute( 'data-ezdemo-diff-target' ) || 'diffview' );
            if ( view )
            {
                view.className = el.getAttribute( 'data-ezdemo-diff-mode' );
            }
        }
        else if ( ( el = closest( event.target, '[data-ezdemo-disable-buttons]' ) ) )
        {
            window.setTimeout( function ()
            {
                var ids = [ 'PublishButton', 'CancelButton' ];
                for ( var i = 0; i < ids.length; i++ )
                {
                    var b = document.getElementById( ids[i] );
                    if ( b )
                    {
                        b.disabled = true;
                    }
                }
            }, 1 );
        }
    } );

    document.addEventListener( 'change', function ( event )
    {
        var el = closest( event.target, '[data-ezdemo-reset]' ), target;
        if ( el && ( target = document.getElementById( el.getAttribute( 'data-ezdemo-reset' ) ) ) )
        {
            target.value = 0;
        }
        el = closest( event.target, 'select[data-ezdemo-add-block]' );
        if ( el && ( target = document.getElementById( 'addtoblock' ) ) )
        {
            target.name = 'CustomActionButton[' + el.getAttribute( 'data-ezdemo-add-block' ) + '_new_item' + '-' + el.value + ']';
        }
    } );

    function ready()
    {
        addPrintLink();

        var hidden = document.querySelectorAll( '.ezdemo-js-only[hidden]' );
        for ( var i = 0; i < hidden.length; i++ )
        {
            hidden[i].removeAttribute( 'hidden' );
        }

        var $ = window.jQuery;
        if ( $ && document.querySelector( 'fieldset.ezcca-collapsible' ) )
        {
            $( 'fieldset.ezcca-collapsible legend a' ).on( 'click', function ( e )
            {
                e.preventDefault();
                var container = $( this.parentNode.parentNode ), inner = container.find( 'div.ezcca-collapsible-fieldset-content' );
                if ( container.hasClass( 'ezcca-collapsed' ) )
                {
                    container.removeClass( 'ezcca-collapsed' );
                    inner.slideDown( 150 );
                }
                else
                {
                    inner.slideUp( 150, function ()
                    {
                        $( this.parentNode ).addClass( 'ezcca-collapsed' );
                    } );
                }
            } );
            // Collapse by default
            $( 'fieldset.ezcca-collapsible' ).addClass( 'ezcca-collapsed' ).find( 'div.ezcca-collapsible-fieldset-content' ).hide();
        }

        if ( $ && $.fn.ezSimpleGallery && document.querySelector( '[data-ezdemo-campaign]' ) )
        {
            $( '[data-ezdemo-campaign]' ).ezSimpleGallery();
        }

        if ( $ && $.eZ && $.eZ.Gallery )
        {
            $( '[data-ezdemo-gallery]' ).each( function ()
            {
                var kind = this.getAttribute( 'data-ezdemo-gallery' ), conf = galleryConf();
                if ( kind === 'block' )
                {
                    conf.autoScrollOnSelect = false;
                    conf.navigator = { gallery: $( this ).find( '.block-gallery' ) };
                }
                else
                {
                    conf.navigator = { gallery: kind === 'embed' ? '.embed-gallery' : '.full-gallery' };
                }
                new $.eZ.Gallery( conf );
            } );
        }

        var search = document.querySelector( '[data-ezdemo-ajax-search]' );
        if ( search && window.eZAJAXSearch )
        {
            var id = search.getAttribute( 'data-ezdemo-ajax-search' ),
                bullet = search.getAttribute( 'data-ezdemo-ajax-search-bullet' ).replace( /"/g, '&quot;' );
            window.eZAJAXSearch.cfg = {
                searchstring: '#search-string-' + id,
                searchbutton: '#search-button-' + id,
                searchresults: '#search-results-' + id,
                dateformattype: 'shortdatetime',
                resulttemplate: '<div class="result-item float-break"><div class="item-title"><img src="' + bullet + '" />&nbsp;{title}</div><div class="item-published-date">[{class_name}] {date}</div><div class="item-selector"><input type="checkbox" value="{node_id}" name="SelectedNodeIDArray[]" /></div></div>'
            };
            window.eZAJAXSearch.init();
        }
    }

    // The $.eZ.Gallery configuration shared by the gallery views
    function galleryConf()
    {
        return {
            title: 'h3 a',
            caption: 'figcaption div',
            autoFixSizes: false,
            initFunc: function ()
            {
                var imgs = this.navigator.getImages();

                // make the browser caches images
                setTimeout( function ()
                {
                    imgs.each( function ( i, elem )
                    {
                        ( new Image() ).src = elem.getAttribute( 'data-gallery-src' );
                    } );
                }, 0 );
            },
            updateFunc: function ( item )
            {
                var node = item.imageNode,
                    viewerImage = this.container.find( '.gallery-viewer-image' ).first(),
                    img = viewerImage.children( 'img' ).first();

                if ( node.attr( 'data-gallery-item' ) == 'image' )
                {
                    this.container.find( '.visible' ).first().removeClass( 'visible' ).addClass( 'hidden' );
                    viewerImage.removeClass( 'hidden' ).addClass( 'visible' );
                }
                else if ( node.attr( 'data-gallery-item' ) == 'video' )
                {
                    viewerImage.removeClass( 'visible' ).addClass( 'hidden' );
                    this.container.find( '#gallery-viewer-video-' + node.attr( 'data-gallery-node-id' ) ).first().removeClass( 'hidden' ).addClass( 'visible' );
                }

                if ( img.length )
                {
                    img.attr( 'src', node.attr( 'data-gallery-src' ) );
                    img.attr( 'height', node.attr( 'data-gallery-height' ) );
                    img.attr( 'width', node.attr( 'data-gallery-width' ) );
                    img.attr( 'alt', node.prop( 'title' ) );
                }

                var t = this.container.find( '.visible ' + this.conf.title ).first(),
                    cap = this.container.find( '.visible ' + this.conf.caption ).first(),
                    c = this.container.find( '.visible ' + this.conf.counter ).first();

                t.text( node.prop( 'title' ) );
                t.attr( 'href', node.attr( 'data-gallery-node-url' ) );
                c.text( item.index + 1 );
                cap.html( node.find( 'figcaption' ).html() );
            }
        };
    }

    window.addEventListener( 'load', function ()
    {
        var field = document.querySelector( '[data-ezdemo-autofocus]' );
        if ( field )
        {
            field.select();
            field.focus();
        }

        var maps = document.querySelectorAll( '[data-ezdemo-gmap-id]' );
        for ( var i = 0; i < maps.length; i++ )
        {
            if ( window.google && window.google.maps )
            {
                window.eZGmapLocation_MapView( maps[i].getAttribute( 'data-ezdemo-gmap-id' ),
                                               parseFloat( maps[i].getAttribute( 'data-ezdemo-gmap-lat' ) ),
                                               parseFloat( maps[i].getAttribute( 'data-ezdemo-gmap-lng' ) ) );
            }
        }
    } );

    if ( document.readyState === 'loading' )
    {
        document.addEventListener( 'DOMContentLoaded', ready );
    }
    else
    {
        ready();
    }
})( window, document );
