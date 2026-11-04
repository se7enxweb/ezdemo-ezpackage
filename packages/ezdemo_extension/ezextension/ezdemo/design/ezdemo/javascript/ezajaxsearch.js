/**
 * eZAJAXSearch: the search box of the front-end landing page editor, in plain JavaScript (no jQuery).
 * GNU General Public License v2.0 (or any later version). Exponential Foundation and 7x.
 *
 * The same API as before: set eZAJAXSearch.cfg (searchstring, searchbutton, searchresults, resulttemplate,
 * noresulttemplate, dateformattype, backendUri, customSearchAttributes) and call eZAJAXSearch.init().
 * The call goes through expui's Exp.io.call() (ezjscore/call, with the form token) when expui is on the page,
 * else through fetch to the same address. Values put into the templates are HTML-escaped.
 */
var eZAJAXSearch = (function ()
{
    'use strict';
    var ret = {};

    function esc( s )
    {
        return String( s === undefined || s === null ? '' : s ).replace( /[&<>"']/g, function ( c )
        {
            return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c];
        } );
    }

    function valueOf( sel )
    {
        var node = document.querySelector( sel );
        if ( !node )
            return null;
        var name = node.nodeName.toLowerCase();
        if ( name === 'input' && ( node.type === 'radio' || node.type === 'checkbox' ) )
        {
            var checked = document.querySelector( sel + ':checked' );
            return checked ? checked.value : null;
        }
        if ( name === 'select' && node.multiple )
            return Array.prototype.filter.call( node.options, function ( o ) { return o.selected; } ).map( function ( o ) { return o.value; } ).join( ',' );
        return node.value;
    }

    function render( content )
    {
        var target = document.querySelector( ret.cfg.searchresults );
        if ( !target || !content || content.SearchResult === undefined )
            return;
        var html = '';
        if ( !content.SearchResult.length && ret.cfg.noresulttemplate !== undefined )
            html = ret.cfg.noresulttemplate.replace( /\{+search_string+\}/, esc( content.SearchString ) );
        content.SearchResult.forEach( function ( item )
        {
            var date = item.published_date;
            if ( date === undefined )
                date = new Date( item.published * 1000 ).toLocaleString();
            html += ret.cfg.resulttemplate
                .replace( /\{+title+\}/, esc( item.name ) )
                .replace( /\{+date+\}/, esc( date ) )
                .replace( /\{+class_name+\}/, esc( item.class_name ) )
                .replace( /\{+url_alias+\}/, esc( item.url_alias ) )
                .replace( /\{+object_id+\}/, esc( item.id ) )
                .replace( /\{+node_id+\}/, esc( item.node_id ) );
        } );
        target.innerHTML = html;
        target.classList.remove( 'loading' );
    }

    function search()
    {
        var text = valueOf( ret.cfg.searchstring );
        if ( !text )
            return;
        var fields = { SearchStr: text, SearchLimit: valueOf( '[name=SearchLimit]' ) || 10,
                       EncodingFormatDate: ret.cfg.dateformattype || 'shortdatetime' };
        [ 'SearchOffset', 'SearchSectionID', 'SearchDate', 'SearchContentClassAttributeID', 'SearchContentClassID',
          'SearchContentClassIdentifier', 'SearchSubTreeArray', 'SearchTimestamp' ].forEach( function ( n )
        {
            var v = valueOf( '[name=' + n + ']' );
            if ( v )
                fields[n] = v;
        } );
        ( ret.cfg.customSearchAttributes || [] ).forEach( function ( sel )
        {
            var el = document.querySelector( sel );
            if ( el )
                fields[el.name] = el.value;
        } );
        var target = document.querySelector( ret.cfg.searchresults );
        if ( target )
            target.classList.add( 'loading' );
        var fn = ret.cfg.backendUri || 'ezjsc::search';
        if ( window.Exp && window.Exp.io )
        {
            window.Exp.io.call( fn, [], { data: fields } ).then( render ).catch( function () { if ( target ) target.classList.remove( 'loading' ); } );
            return;
        }
        var body = new URLSearchParams( fields );
        var token = document.getElementById( 'ezxform_token_js' );
        if ( token )
            body.append( 'ezxform_token', token.getAttribute( 'title' ) );
        var base = ( window.eZJSCoreRoot || '/' ).replace( /\/?$/, '/' );
        fetch( base + 'ezjscore/call/' + fn, { method: 'POST', credentials: 'same-origin', body: body,
                                               headers: { 'X-Requested-With': 'XMLHttpRequest', 'Accept': 'application/json' } } )
            .then( function ( r ) { return r.json(); } )
            .then( function ( r ) { render( r && r.content ); } )
            .catch( function () { if ( target ) target.classList.remove( 'loading' ); } );
    }

    ret.cfg = {};
    ret.init = function ()
    {
        var button = document.querySelector( ret.cfg.searchbutton ), field = document.querySelector( ret.cfg.searchstring );
        if ( button )
            button.addEventListener( 'click', function ( e ) { e.preventDefault(); search(); } );
        if ( field )
            field.addEventListener( 'keydown', function ( e ) { if ( e.key === 'Enter' ) { e.preventDefault(); search(); } } );
    };
    ret.search = search;
    return ret;
})();
