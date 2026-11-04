{* Gallery pictures as tiles that open the lightbox (javascript/ezdemo/gallery.js); without JavaScript the links
   open the image pages. Parameters: items (image nodes), layout (strip or masonry), id (unique on the page). *}
<div class="{if $layout|eq( 'strip' )}ed-strip{else}ed-masonry{/if}" data-ed-gallery="1"
     data-text-close="{'Close'|i18n( 'design/ezdemo/gallery' )}" data-text-prev="{'Previous picture'|i18n( 'design/ezdemo/gallery' )}"
     data-text-next="{'Next picture'|i18n( 'design/ezdemo/gallery' )}" data-text-count="{'%index of %count'|i18n( 'design/ezdemo/gallery' )}"
     data-text-label="{'Gallery'|i18n( 'design/ezdemo/gallery' )}">
{foreach $items as $item}
    {if is_set( $item.data_map.image )}
    {def $ed_full = $item.data_map.image.content['ezdemo_hero']}
    <a class="ed-tile ed-reveal" href={$item.url_alias|ezurl} data-ed-full={$ed_full.url|ezroot} data-ed-title="{$item.name|wash}" data-ed-alt="{$item.data_map.image.content.alternative_text|wash}" data-ed-caption-id="ed-cap-{$id}-{$item.node_id}">
        {include uri='design:parts/ezdemo/image.tpl' node=$item alias=cond( $layout|eq( 'strip' ), 'ezdemo_card', 'ezdemo_card' )}
        <span class="ed-tile-caption">{$item.name|wash}</span>
    </a>
    <div id="ed-cap-{$id}-{$item.node_id}" hidden="hidden">{attribute_view_gui attribute=$item.data_map.caption}</div>
    {undef $ed_full}
    {/if}
{/foreach}
</div>
