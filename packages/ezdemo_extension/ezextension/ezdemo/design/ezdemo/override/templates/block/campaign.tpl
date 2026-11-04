{* Campaign: the items as slides of a carousel (javascript/ezdemo/carousel.js; scroll-snap without JavaScript). *}
{def $valid_nodes = $block.valid_nodes}
{if $valid_nodes|count}
<section class="ed-section ed-block ed-block-campaign">
    <div class="ed-wrap">
        <div class="ed-carousel" data-ed-carousel="1" data-ed-autoplay="8" aria-roledescription="{'carousel'|i18n( 'design/ezdemo/block' )}" aria-label="{$block.name|wash}">
            <div class="ed-carousel-track" tabindex="0">
            {foreach $valid_nodes as $k => $item}
                <div class="ed-carousel-slide" role="group" aria-roledescription="{'slide'|i18n( 'design/ezdemo/block' )}" aria-label="{$k|inc} / {$valid_nodes|count}">
                    {include uri='design:parts/ezdemo/image.tpl' node=$item alias='ezdemo_wide' alt='' eager=$k|eq( 0 )}
                    <div class="ed-carousel-body">
                        {if $block.name|ne( '' )}<p class="ed-eyebrow">{$block.name|wash}</p>{/if}
                        <h2>{if is_set( $item.data_map.title )}{$item.data_map.title.content|wash}{else}{$item.name|wash}{/if}</h2>
                        {if is_set( $item.data_map.intro )}<div class="ed-lead">{attribute_view_gui attribute=$item.data_map.intro}</div>{/if}
                        <p><a class="ed-btn ed-btn-light" href={$item.url_alias|ezurl}>{'Learn more'|i18n( 'design/ezdemo/block' )}<span class="ed-sr">: {$item.name|wash}</span></a></p>
                    </div>
                </div>
            {/foreach}
            </div>
            {if $valid_nodes|count|gt( 1 )}
            <div class="ed-carousel-controls">
                <ul class="ed-dots">
                {foreach $valid_nodes as $k => $item}
                    <li><button type="button" aria-current="{if $k|eq( 0 )}true{else}false{/if}" aria-label="{'Show slide %number'|i18n( 'design/ezdemo/block', '', hash( '%number', $k|inc ) )}"></button></li>
                {/foreach}
                </ul>
                <div class="ed-strip-nav">
                    <button type="button" class="ed-icon-btn" data-ed-go="prev" aria-label="{'Previous slide'|i18n( 'design/ezdemo/block' )}"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" aria-hidden="true"><path d="M15 5l-7 7 7 7"/></svg></button>
                    <button type="button" class="ed-icon-btn" data-ed-go="next" aria-label="{'Next slide'|i18n( 'design/ezdemo/block' )}"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" aria-hidden="true"><path d="M9 5l7 7-7 7"/></svg></button>
                </div>
            </div>
            {/if}
        </div>
    </div>
</section>
{/if}
{undef $valid_nodes}
