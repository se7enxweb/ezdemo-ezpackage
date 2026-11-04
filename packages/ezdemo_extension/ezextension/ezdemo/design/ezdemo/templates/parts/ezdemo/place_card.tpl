{* A place as a card: picture, name, address, description and a link to its map (OpenStreetMap, no script). *}
{def $loc = $node.data_map.location}
<article class="ed-card ed-reveal">
    <div class="ed-card-media">{include uri='design:parts/ezdemo/image.tpl' node=$node alias='ezdemo_card' alt=''}</div>
    <div class="ed-card-body">
        <h3><a href={$node.url_alias|ezurl}>{$node.name|wash}</a></h3>
        {if $loc.has_content}<p class="ed-meta">{$loc.content.address|wash}</p>{/if}
        {if $node.data_map.description.has_content}<div class="ed-card-text">{attribute_view_gui attribute=$node.data_map.description}</div>{/if}
        {if $loc.has_content}<div class="ed-card-foot"><a class="ed-more ed-card-extra" href="https://www.openstreetmap.org/?mlat={$loc.content.latitude}&amp;mlon={$loc.content.longitude}#map=12/{$loc.content.latitude}/{$loc.content.longitude}" rel="noopener">{'View on the map'|i18n( 'design/ezdemo/full/place' )}</a></div>{/if}
    </div>
</article>
{undef $loc}
