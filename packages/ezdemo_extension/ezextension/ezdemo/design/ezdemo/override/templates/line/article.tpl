{* Article - Line view: a row with picture, title and intro. *}
<article class="ed-row-item has-media ed-reveal">
    <div>{include uri='design:parts/ezdemo/image.tpl' node=$node alias='ezdemo_card' alt=''}</div>
    <div>
        <h3><a href={$node.url_alias|ezurl}>{$node.data_map.title.content|wash}</a></h3>
        {if $node.data_map.intro.has_content}<div class="ed-card-text">{attribute_view_gui attribute=$node.data_map.intro}</div>{/if}
    </div>
</article>
