{* Place - Full view: picture, name, address, description, keywords and a link to its map. *}
{set scope=global persistent_variable=hash( 'left_menu', false(), 'extra_menu', false() )}
{def $loc = $node.data_map.location}
<article class="content-view-full class-place">
    <header class="ed-page-head">
        <p class="ed-eyebrow"><a href={$node.parent.url_alias|ezurl}>{$node.parent.name|wash}</a></p>
        <h1>{$node.name|wash}</h1>
        {if $loc.has_content}<p class="ed-lead">{$loc.content.address|wash}</p>{/if}
    </header>
    <figure class="ed-figure">{include uri='design:parts/ezdemo/image.tpl' node=$node alias='ezdemo_wide' eager=true()}</figure>
    <div class="ed-article-layout">
        <div class="ed-prose">
            {attribute_view_gui attribute=$node.data_map.description}
            {if $loc.has_content}<p><a class="ed-btn" href="https://www.openstreetmap.org/?mlat={$loc.content.latitude}&amp;mlon={$loc.content.longitude}#map=12/{$loc.content.latitude}/{$loc.content.longitude}" rel="noopener">{'View on the map'|i18n( 'design/ezdemo/full/place' )}</a></p>{/if}
        </div>
        <aside class="ed-aside">{include uri='design:parts/ezdemo/section_nav.tpl' node=$node}</aside>
    </div>
</article>
{undef $loc}
