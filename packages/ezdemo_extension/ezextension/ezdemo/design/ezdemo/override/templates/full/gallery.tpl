{* Gallery - Full view: header with name and descriptions, the pictures as a masonry wall that opens the lightbox
   (javascript/ezdemo/gallery.js), paged by the view parameter offset. *}
{set scope=global persistent_variable=hash( 'left_menu', false(), 'extra_menu', false() )}
{def $page_limit = 24
     $children_count = fetch( 'content', 'list_count', hash( 'parent_node_id', $node.node_id, 'class_filter_type', 'include', 'class_filter_array', array( 'image' ) ) )
     $children = fetch( 'content', 'list', hash( 'parent_node_id', $node.node_id, 'class_filter_type', 'include', 'class_filter_array', array( 'image' ),
                                                 'sort_by', $node.sort_array, 'offset', $view_parameters.offset, 'limit', $page_limit ) )}
<section class="content-view-full class-gallery">
    <header class="ed-page-head">
        <h1>{$node.name|wash}</h1>
        {if $node.data_map.short_description.has_content}<div class="ed-lead">{attribute_view_gui attribute=$node.data_map.short_description}</div>{/if}
        {if $node.data_map.description.has_content}<div class="ed-meta">{attribute_view_gui attribute=$node.data_map.description}</div>{/if}
        <p class="ed-meta">{'%count pictures'|i18n( 'design/ezdemo/full/gallery', '', hash( '%count', $children_count ) )}</p>
    </header>
    {if $children_count}
        {include uri='design:parts/ezdemo/gallery_items.tpl' items=$children layout='masonry' id=$node.node_id}
        {include name=navigator uri='design:navigator/google.tpl' page_uri=$node.url_alias item_count=$children_count view_parameters=$view_parameters item_limit=$page_limit}
    {/if}
</section>
{undef $page_limit $children_count $children}
