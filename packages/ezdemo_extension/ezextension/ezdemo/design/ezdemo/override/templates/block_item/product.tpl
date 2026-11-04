{* A product in a block: picture, name, short description, price and "Add to basket". *}
<article class="ed-card ed-reveal ed-card-product">
    <div class="ed-card-media">{include uri='design:parts/ezdemo/image.tpl' node=$node alias='ezdemo_card' alt=''}</div>
    <div class="ed-card-body">
        <h3><a href={$node.url_alias|ezurl}>{$node.name|wash}</a></h3>
        {if $node.data_map.short_description.has_content}<div class="ed-card-text">{attribute_view_gui attribute=$node.data_map.short_description}</div>{/if}
        <div class="ed-card-foot">
            <span class="ed-price">{$node.data_map.price.content.inc_vat_price|l10n( 'currency' )}</span>
            <form method="post" action={'content/action'|ezurl}>
                <input type="hidden" name="Quantity" value="1" />
                <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
                <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
                <input type="hidden" name="ViewMode" value="full" />
                <button class="ed-btn ed-btn-primary ed-btn-s" type="submit" name="ActionAddToBasket">{'Add to basket'|i18n( 'design/ezdemo/block_item/product' )}<span class="ed-sr">: {$node.name|wash}</span></button>
            </form>
        </div>
    </div>
</article>
