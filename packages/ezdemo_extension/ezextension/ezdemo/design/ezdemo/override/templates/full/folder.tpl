{* Folder - Full view: header with name and short description, the description, then the children as cards
   (paged, view parameter offset) and the folder's call for action. *}
{set scope=global persistent_variable=hash( 'left_menu', false(), 'extra_menu', false() )}
{def $rss_export = fetch( 'rss', 'export_by_node', hash( 'node_id', $node.node_id ) )}
<section class="content-view-full class-folder">
    <header class="ed-page-head">
        {if $node.depth|gt( 2 )}<p class="ed-eyebrow">{$node.parent.name|wash}</p>{/if}
        <h1>{$node.name|wash}</h1>
        {if and( eq( ezini( 'folder', 'SummaryInFullView', 'content.ini' ), 'enabled' ), $node.object.data_map.short_description.has_content )}
            <div class="ed-lead">{attribute_view_gui attribute=$node.data_map.short_description}</div>
        {/if}
        {if $rss_export}<p><a class="ed-more" href="{concat( '/rss/feed/', $rss_export.access_url )|ezurl( 'no' )}">{'RSS feed'|i18n( 'design/ezdemo/full/folder' )}</a></p>{/if}
    </header>
    {if $node.object.data_map.description.has_content}
        <div class="ed-prose ed-wrap-text ed-folder-intro">{attribute_view_gui attribute=$node.data_map.description}</div>
    {/if}
    {if $node.object.data_map.show_children.data_int}
        {def $page_limit = 12
             $classes = ezini( 'MenuContentSettings', 'ExtraIdentifierList', 'menu.ini' )
             $children_count = fetch_alias( 'children_count', hash( 'parent_node_id', $node.node_id, 'class_filter_type', 'exclude', 'class_filter_array', $classes ) )}
        {if $children_count}
        <div class="ed-grid ed-grid-3 ed-folder-children">
            {foreach fetch_alias( 'children', hash( 'parent_node_id', $node.node_id, 'offset', $view_parameters.offset, 'sort_by', $node.sort_array,
                                                     'class_filter_type', 'exclude', 'class_filter_array', $classes, 'limit', $page_limit ) ) as $child}
                {if array( 'link', 'event', 'article' )|contains( $child.class_identifier )|not}
                    {node_view_gui view='line' content_node=$child}
                {elseif $child.class_identifier|eq( 'article' )}
                    {include uri='design:parts/ezdemo/card.tpl' node=$child}
                {else}
                    {node_view_gui view='line' content_node=$child}
                {/if}
            {/foreach}
        </div>
        {include name=navigator uri='design:navigator/google.tpl' page_uri=$node.url_alias item_count=$children_count view_parameters=$view_parameters item_limit=$page_limit}
        {/if}
        {undef $page_limit $classes $children_count}
    {/if}
    {if $node.data_map.call_for_action.has_content}<div class="attribute-call-for-action">{attribute_view_gui attribute=$node.data_map.call_for_action}</div>{/if}
</section>
{undef $rss_export}
