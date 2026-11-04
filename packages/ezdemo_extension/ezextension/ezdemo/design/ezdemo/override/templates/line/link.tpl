{* Link - Line view: a row with the link's name, description and address. *}
<article class="ed-row-item ed-reveal">
    <div>
        <h3><a href={$node.data_map.location.content|ezurl}>{$node.name|wash}</a></h3>
        {if $node.data_map.description.has_content}<div class="ed-card-text">{attribute_view_gui attribute=$node.data_map.description}</div>{/if}
        <p class="ed-meta">{$node.data_map.location.content|wash}</p>
    </div>
</article>
