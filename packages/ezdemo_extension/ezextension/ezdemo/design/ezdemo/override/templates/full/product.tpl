{* Product - Full view: the picture beside a buy box (name, number, price, options, quantity, "Add to basket"),
   then the description, the category and what other buyers chose. *}
{set scope=global persistent_variable=hash( 'left_menu', false(), 'extra_menu', false() )}
<article class="content-view-full class-product">
    <div class="ed-split ed-product">
        <figure class="ed-split-media">
            {include uri='design:parts/ezdemo/image.tpl' node=$node alias='ezdemo_wide' eager=true()}
            {if $node.data_map.caption.has_content}<figcaption class="attribute-caption">{attribute_view_gui attribute=$node.data_map.caption}</figcaption>{/if}
        </figure>
        <div>
            <p class="ed-eyebrow"><a href={$node.parent.url_alias|ezurl}>{$node.parent.name|wash}</a></p>
            <h1>{$node.name|wash}</h1>
            {if $node.data_map.short_description.has_content}<div class="ed-lead">{attribute_view_gui attribute=$node.data_map.short_description}</div>{/if}
            <form class="ed-aside-box ed-buybox" method="post" action={'content/action'|ezurl}>
                <p class="ed-price">
                {if $node.data_map.price.has_discount}
                    {$node.data_map.price.content.discount_price_inc_vat|l10n( 'currency' )} <del>{$node.data_map.price.content.inc_vat_price|l10n( 'currency' )}</del>
                {else}
                    {$node.data_map.price.content.inc_vat_price|l10n( 'currency' )}
                {/if}
                <small>{'incl. VAT'|i18n( 'design/ezdemo/full/product' )}{if $node.data_map.product_number.has_content} · {$node.data_map.product_number.content|wash}{/if}</small></p>
                {if $node.data_map.additional_options.has_content}{attribute_view_gui attribute=$node.data_map.additional_options}{/if}
                <div class="form-inline">
                    <label for="ed-qty">{'Quantity'|i18n( 'design/ezdemo/full/product' )}</label>
                    <input id="ed-qty" type="number" min="1" value="1" name="Quantity" />
                    <button class="ed-btn ed-btn-primary" type="submit" name="ActionAddToBasket">{'Add to basket'|i18n( 'design/ezdemo/full/product' )}</button>
                </div>
                <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
                <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
                <input type="hidden" name="ViewMode" value="full" />
            </form>
        </div>
    </div>
    <div class="ed-article-layout ed-product-more">
        <div>
            {if $node.data_map.description.has_content}<div class="ed-prose">{attribute_view_gui attribute=$node.data_map.description}</div>{/if}
            {def $product_category_attribute = ezini( 'VATSettings', 'ProductCategoryAttribute', 'shop.ini' )}
            {if and( $product_category_attribute, is_set( $node.data_map.$product_category_attribute ) )}
                <p>{'Category'|i18n( 'design/ezdemo/full/product' )}: {attribute_view_gui attribute=$node.data_map.$product_category_attribute}</p>
            {/if}
            {undef $product_category_attribute}
            {include uri='design:parts/social_buttons.tpl'}
        </div>
        <aside class="ed-aside">
            {def $related_purchase = fetch( 'shop', 'related_purchase', hash( 'contentobject_id', $node.object.id, 'limit', 10 ) )}
            {if $related_purchase}
            <div class="ed-aside-box">
                <h2>{'People who bought this also bought'|i18n( 'design/ezdemo/full/product' )}</h2>
                <ul>{foreach $related_purchase as $product}<li>{content_view_gui view=text_linked content_object=$product}</li>{/foreach}</ul>
            </div>
            {/if}
            {undef $related_purchase}
            {include uri='design:parts/ezdemo/section_nav.tpl' node=$node}
        </aside>
    </div>
</article>
