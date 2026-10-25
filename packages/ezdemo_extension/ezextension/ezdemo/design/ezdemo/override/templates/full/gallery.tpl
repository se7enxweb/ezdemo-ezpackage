{* Gallery - Full view *}

<div class="content-view-full">
    <div class="class-gallery">

        <div class="attribute-header">
            <h1>{$node.name|wash()}</h1>
        </div>

        {def $children_count = fetch( 'content', 'list_count', hash( 'parent_node_id', $node.node_id,
                                                                     'class_filter_type', 'include',
                                                                     'class_filter_array', array( 'image', 'video' ) ) )
             $children = array()
             $first = false()
             $big_image_class = 'galleryfull'
             $render_image_once = false()}

        {if $children_count}
        <div class="full-gallery" data-ezdemo-gallery="full">
            {set $children = fetch( 'content', 'list', hash( 'parent_node_id', $node.node_id,
                                                             'class_filter_type', 'include',
                                                             'class_filter_array', array( 'image', 'video' ),
                                                             'sort_by', $node.sort_array ) )
                 $first = $children.0}
            <div class="gallery-viewer">
                {node_view_gui view='gallery_viewer' big_class=$big_image_class total_items=$children_count content_node=$first}
                {foreach $children as $gallery_item offset 1}
                    {if eq( $gallery_item.class_identifier, 'video' )}
                        {node_view_gui view='gallery_viewer' is_hidden=true() big_class=$big_image_class total_items=$children_count content_node=$gallery_item}
                    {/if}
                    {if and( eq( $gallery_item.class_identifier, 'image' ), $render_image_once|not() )}
                        {node_view_gui view='gallery_viewer' is_hidden=true() big_class=$big_image_class total_items=$children_count content_node=$gallery_item}
                        {set $render_image_once = true()}
                    {/if}
                {/foreach}
            </div>
            <div class="gallery-navigator">
                <a href="#" class="navig prev" style="opacity:0;"><span class="hide">&lt;</span></a>
                <a href="#" class="navig next"><span class="hide">&gt;</span></a>

                <img src={'fg-selected.png'|ezimage} alt="Selected indicator" class="cursor" />
                <ul class="images">
                {foreach $children as $gallery_item}
                    <li>{node_view_gui view='gallery_item' thumb_class='gallerythumbnail' big_class=$big_image_class content_node=$gallery_item}</li>
                {/foreach}
                </ul>
            </div>

        </div>
        {ezscript( array( 'ezdemo_actions.js' ) )}
        {/if}
        {undef $children_count $children $first $big_image_class $render_image_once}
    </div>
</div>
