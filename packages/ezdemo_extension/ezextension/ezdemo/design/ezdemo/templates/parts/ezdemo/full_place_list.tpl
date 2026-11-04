{* Place list - Full view: header with the description, the places as cards with a link to their map. *}
{set scope=global persistent_variable=hash( 'left_menu', false(), 'extra_menu', false() )}
<section class="content-view-full class-place-list">
    <header class="ed-page-head">
        <p class="ed-eyebrow"><a href={$node.parent.url_alias|ezurl}>{$node.parent.name|wash}</a></p>
        <h1>{$node.name|wash}</h1>
        {if $node.data_map.description.has_content}<div class="ed-lead">{attribute_view_gui attribute=$node.data_map.description}</div>{/if}
    </header>
    <div class="ed-grid ed-grid-2">
    {foreach fetch( 'content', 'list', hash( 'parent_node_id', $node.node_id, 'sort_by', $node.sort_array, 'class_filter_type', 'include', 'class_filter_array', array( 'place' ) ) ) as $place}
        {include uri='design:parts/ezdemo/place_card.tpl' node=$place}
    {/foreach}
    </div>
</section>
