{def $valid_nodes = $block.valid_nodes
     $first = $valid_nodes.0
     $big_image_class = 'gallery'
     $render_image_once = false()}
<!-- BLOCK: START -->
<div class="block-type-gallery" data-ezdemo-gallery="block">

    <div class="block-gallery">
        <div class="gallery-viewer">
            {node_view_gui view='gallery_viewer' big_class=$big_image_class total_items=$valid_nodes|count content_node=$first}
            {foreach $valid_nodes as $gallery_item offset 1}
                {if eq( $gallery_item.class_identifier, 'video' )}
                    {node_view_gui view='gallery_viewer' is_hidden=true() big_class=$big_image_class total_items=$valid_nodes|count content_node=$gallery_item}
                {/if}
                {if and( eq( $gallery_item.class_identifier, 'image' ), $render_image_once|not() )}
                    {node_view_gui view='gallery_viewer' is_hidden=true() big_class=$big_image_class total_items=$valid_nodes|count content_node=$gallery_item}
                    {set $render_image_once = true()}
                {/if}
            {/foreach}
        </div>
        <div class="gallery-navigator">
            <a href="#" class="navig prev" style="opacity:0;"><span class="hide">&lt;</span></a>
            <a href="#" class="navig next"><span class="hide">&gt;</span></a>

            <img src={'fg-selected.png'|ezimage} alt="Selected indicator" class="cursor" />
            <ul class="images">
            {foreach $valid_nodes as $gallery_item}
                <li>{node_view_gui view='gallery_item' thumb_class='gallerythumbnail' big_class=$big_image_class content_node=$gallery_item}</li>
            {/foreach}
            </ul>
        </div>

    </div>
    {ezscript( array( 'ezdemo_actions.js' ) )}
{undef $valid_nodes $first $big_image_class $render_image_once}
</div>
<!-- BLOCK: END -->
