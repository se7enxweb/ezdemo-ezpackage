{* The footer: the site name and the footer article (content.ini [FooterSettings]: RemoteID, else NodeID; its
   intro is the contact block, its body the links), the latest articles and the main sections. *}
{def $footer_node = false()}
{if ezini_hasvariable( 'FooterSettings', 'RemoteID', 'content.ini' )}
    {def $footer_object = fetch( 'content', 'object', hash( 'remote_id', ezini( 'FooterSettings', 'RemoteID', 'content.ini' ) ) )}
    {if $footer_object}{set $footer_node = $footer_object.main_node}{/if}
    {undef $footer_object}
{/if}
{if $footer_node|not}
    {set $footer_node = fetch( 'content', 'node', hash( 'node_id', ezini( 'FooterSettings', 'NodeID', 'content.ini' ) ) )}
{/if}
<footer class="ed-footer">
    <div class="ed-wrap ed-footer-grid">
        <div>
            {include uri='design:page_header_logo.tpl'}
            {if $footer_node}{include uri='design:footer/address.tpl' node=$footer_node}{/if}
        </div>
        <div>{include uri='design:footer/latest_news.tpl'}</div>
        <div>
            <h2>{'Explore'|i18n( 'design/ezdemo/footer' )}</h2>
            {def $root_node = fetch( 'content', 'node', hash( 'node_id', $pagedata.root_node ) )}
            <ul>
            {foreach fetch( 'content', 'list', hash( 'parent_node_id', $pagedata.root_node, 'sort_by', $root_node.sort_array, 'limit', 8,
                                                     'class_filter_type', 'include', 'class_filter_array', ezini( 'MenuContentSettings', 'TopIdentifierList', 'menu.ini' ) ) ) as $item}
                <li><a href={$item.url_alias|ezurl}>{$item.name|wash}</a></li>
            {/foreach}
            </ul>
            {undef $root_node}
        </div>
        <div>{if $footer_node}{include uri='design:footer/links.tpl' node=$footer_node}{/if}</div>
    </div>
    <div class="ed-wrap ed-footer-base">
        <p>&copy; {currentdate()|datetime( 'custom', '%Y' )} {ezini( 'SiteSettings', 'SiteName' )|wash}</p>
        <p>{'Powered by'|i18n( 'design/ezdemo/footer' )} <a href="https://exponential.earth">Exponential</a>, {'open source content management by the Exponential Foundation and 7x.'|i18n( 'design/ezdemo/footer' )}</p>
    </div>
</footer>
{undef $footer_node}
