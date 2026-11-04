{* "In this section": the siblings of a page (or its children when it has no parent section). Parameter: node. *}
{def $ed_parent = $node.parent
     $ed_items = fetch( 'content', 'list', hash( 'parent_node_id', $ed_parent.node_id, 'sort_by', $ed_parent.sort_array, 'limit', 12,
                                                  'class_filter_type', 'exclude', 'class_filter_array', array( 'image', 'comment', 'file', 'banner' ) ) )}
{if and( $ed_parent.node_id|ne( ezini( 'NodeSettings', 'RootNode', 'content.ini' ) ), $ed_items|count|gt( 1 ) )}
<nav class="ed-aside-box" aria-label="{$ed_parent.name|wash}">
    <h2>{$ed_parent.name|wash}</h2>
    <ul>
    {foreach $ed_items as $item}
        <li><a href={$item.url_alias|ezurl}{if $item.node_id|eq( $node.node_id )} aria-current="page"{/if}>{$item.name|wash}</a></li>
    {/foreach}
    </ul>
</nav>
{/if}
{undef $ed_parent $ed_items}
