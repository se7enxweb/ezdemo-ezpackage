{* Banner, internal: the banner image of the block's image_node_id, linked to the block's url. *}
{def $image_node = fetch( 'content', 'node', hash( 'node_id', $block.custom_attributes.image_node_id ) )
     $has_url = and( is_set( $block.custom_attributes.url ), ne( $block.custom_attributes.url, '' ) )}
{if $image_node}
<section class="ed-section ed-block ed-block-banner">
    <div class="ed-wrap">
        <div class="ed-cta ed-reveal">
            <div>
                {if $block.name|ne( '' )}<p class="ed-eyebrow">{$block.name|wash}</p>{/if}
                <h2>{$image_node.name|wash}</h2>
            </div>
            <div class="ed-cta-actions">{if $has_url}<a class="ed-btn ed-btn-primary" href={$block.custom_attributes.url|ezurl}>{'Read the announcement'|i18n( 'design/ezdemo/block' )}</a>{/if}</div>
        </div>
    </div>
</section>
{/if}
{undef $image_node $has_url}
