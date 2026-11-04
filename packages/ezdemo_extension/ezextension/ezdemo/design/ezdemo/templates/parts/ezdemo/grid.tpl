{* The content grid blocks: a section with the block name and its items as cards.
   Parameters: block; max (items); cols (2, 3 or 4); alt (true: the alternate background). *}
<section class="ed-section ed-block ed-block-grid{if first_set( $alt, false() )} ed-section-alt{/if}">
    <div class="ed-wrap">
        {if $block.name|ne( '' )}
        <div class="ed-section-head ed-reveal"><h2>{$block.name|wash}</h2></div>
        {/if}
        <div class="ed-grid ed-grid-{first_set( $cols, 3 )}">
        {def $ed_max = first_set( $max, 6 )}
        {foreach $block.valid_nodes as $item max $ed_max}
            {include uri='design:parts/ezdemo/card.tpl' node=$item}
        {/foreach}
        </div>
        {undef $ed_max}
    </div>
</section>
