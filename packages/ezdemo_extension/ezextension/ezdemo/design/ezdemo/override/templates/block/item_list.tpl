{* Item list: rows with picture, date and summary (events get a date badge). *}
{def $valid_nodes = $block.valid_nodes}
<section class="ed-section ed-block ed-block-list ed-section-alt">
    <div class="ed-wrap">
        <div class="ed-section-head ed-reveal"><h2>{$block.name|wash}</h2></div>
        <div class="ed-grid ed-grid-2">
        {foreach $valid_nodes as $item}
            {if $item.class_identifier|eq( 'event' )}
                {node_view_gui view='line' content_node=$item}
            {else}
                {include uri='design:parts/ezdemo/card.tpl' node=$item}
            {/if}
        {/foreach}
        </div>
    </div>
</section>
{undef $valid_nodes}
