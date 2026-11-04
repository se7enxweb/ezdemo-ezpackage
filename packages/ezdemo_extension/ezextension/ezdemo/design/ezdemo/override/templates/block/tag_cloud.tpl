<section class="ed-section ed-block ed-block-tags">
    <div class="ed-wrap">
        <div class="ed-section-head"><h2>{$block.name|wash}</h2></div>
        {if is_set( $block.custom_attributes.subtree_node_id )}
            <div class="ed-tagcloud">{eztagcloud( hash( 'parent_node_id', $block.custom_attributes.subtree_node_id ) )}</div>
        {/if}
    </div>
</section>
