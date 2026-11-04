{* Flash player - Gallery line view *}
<div class="content-view-galleryline">
    <div class="class-flash-player">

    {if $node.data_map.thumbnail.has_content}
    <div class="attribute-image">
        <p>{attribute_view_gui attribute=$node.data_map.thumbnail image_class=gallerythumbnail
                               href=$node.url_alias|ezurl}</p>
    </div>    
    {else}
    <a class="attribute-thumbnail" href="{$node.url_alias|ezurl( 'no' )}">
    </a>
    {/if}

    <div class="attribute-name">
        <p>{$node.name|shorten(14)|wash}</p>
    </div>

    </div>
</div>