/**
 * eZAJAXSearch: the search box of the front-end landing page editor.
 * jQuery version, needs ezjsc::jquery and ezjsc::jqueryio ($.ez).
 *
 * Usage: set eZAJAXSearch.cfg (searchstring, searchbutton, searchresults,
 * resulttemplate, noresulttemplate, dateformattype, backendUri,
 * customSearchAttributes) and call eZAJAXSearch.init().
 */
var eZAJAXSearch = function ()
{
    var ret = {};

    var start = function ($)
    {
        var successCallBack = function (response)
        {
            if ( response && response.content && response.content.SearchResult !== undefined )
            {
                var itemCount = response.content.SearchResult.length;

                var resultsTarget = $(ret.cfg.searchresults).first();
                resultsTarget.html('');
                resultsTarget.addClass('loading');

                if ( itemCount == 0 && ret.cfg.noresulttemplate !== undefined )
                {
                    var template = ret.cfg.noresulttemplate;
                    template = template.replace(/\{+search_string+\}/, response.content.SearchString);

                    resultsTarget.append($($.parseHTML(template)));
                }

                for ( var i = 0; i < itemCount; i++ )
                {
                    var item = response.content.SearchResult[i];

                    var template = ret.cfg.resulttemplate;
                    template = template.replace(/\{+title+\}/, item.name);
                    if ( item.published_date === undefined )
                    {
                        var date = new Date( item.published * 1000 );
                        var dateString = date.getHours() + ':' + date.getMinutes() + ':' + date.getSeconds() + ' ' + date.getFullYear() + '/' + date.getMonth() + '/' + date.getDay();
                        template = template.replace(/\{+date+\}/, dateString);
                    }
                    else
                    {
                        template = template.replace(/\{+date+\}/, item.published_date);
                    }
                    template = template.replace(/\{+class_name+\}/, item.class_name);
                    template = template.replace(/\{+url_alias+\}/, item.url_alias);
                    template = template.replace(/\{+object_id+\}/, item.id);
                    template = template.replace(/\{+node_id+\}/, item.node_id);

                    resultsTarget.append($($.parseHTML(template)));
                }

                resultsTarget.removeClass('loading');
            }
        };

        var getValueForSelector = function (sel)
        {
            var value, node = $(sel).first();

            if ( node.length )
            {
                var name = node[0].nodeName.toLowerCase();
                if ( name === 'input' && ( node[0].type === 'radio' || node[0].type === 'checkbox' ) )
                {
                    var checked = $(sel + ':checked').first();
                    value = checked.length ? checked.val() : null;
                }
                else if ( name === 'select' && node[0].multiple )
                {
                    value = [];
                    $.each(node[0].options, function (i, option)
                    {
                        if ( option.selected )
                            value.push( option.value );
                    });
                    value = value.join(',');
                }
                else
                {
                    value = node.val();
                }
            }

            return value;
        };

        var performSearch = function ()
        {
            var searchString = getValueForSelector(ret.cfg.searchstring);
            var dateFormatType = ret.cfg.dateformattype !== undefined ? ret.cfg.dateformattype : 'shortdatetime';

            var value, data = 'SearchStr=' + encodeURIComponent(searchString);
            data += '&SearchLimit=' + getValueForSelector('[name=SearchLimit]');

            if ( (value = getValueForSelector('[name=SearchOffset]')) )
                data += '&SearchOffset=' + value;

            if ( (value = getValueForSelector('[name=SearchSectionID]')) )
                data += '&SearchSectionID=' + value;

            if ( (value = getValueForSelector('[name=SearchDate]')) )
                data += '&SearchDate=' + value;

            if ( (value = getValueForSelector('[name=SearchContentClassAttributeID]')) )
                data += '&SearchContentClassAttributeID=' + value;

            if ( (value = getValueForSelector('[name=SearchContentClassID]')) )
                data += '&SearchContentClassID=' + value;

            if ( (value = getValueForSelector('[name=SearchContentClassIdentifier]')) )
                data += '&SearchContentClassIdentifier=' + value;

            if ( (value = getValueForSelector('[name=SearchSubTreeArray]')) )
                data += '&SearchSubTreeArray=' + value;

            if ( (value = getValueForSelector('[name=SearchTimestamp]')) )
                data += '&SearchTimestamp=' + value;

            data += '&EncodingFormatDate=' + dateFormatType;

            if ( ret.cfg.customSearchAttributes !== undefined )
            {
                for ( var i = 0, l = ret.cfg.customSearchAttributes.length; i < l; i++ )
                {
                    var attr = $(ret.cfg.customSearchAttributes[i]).first();
                    data += '&' + attr.attr('name') + '=' + encodeURIComponent(attr.val());
                }
            }

            var backendUri = ret.cfg.backendUri ? ret.cfg.backendUri : 'ezjsc::search';

            if ( searchString )
            {
                $.ez(backendUri, data, successCallBack);
            }
        };

        $(ret.cfg.searchbutton).first().on('click', function (e)
        {
            performSearch();
            e.preventDefault();
        });

        $(ret.cfg.searchstring).first().on('keypress', function (e)
        {
            var key = e.which || e.keyCode;
            if ( key === 13 )
            {
                performSearch();
                e.preventDefault();
                e.stopPropagation();
                return false;
            }
        });
    };

    ret.cfg = {};

    ret.init = function ()
    {
        jQuery(start);
    };

    return ret;
}();
