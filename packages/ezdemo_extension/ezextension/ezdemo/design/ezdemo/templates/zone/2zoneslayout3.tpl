{* 2 zones (layout 3): the top zone and the bottom zone one below the other, at full width; every block draws its
   own section (override/templates/block/*.tpl). *}
<div class="zone-layout-{$zone_layout|downcase()} ed-zone-stack">
    {foreach $zones as $zone}
        {if and( is_set( $zone.blocks ), $zone.blocks|count() )}
        {foreach $zone.blocks as $block}
            {include uri='design:parts/zone_block.tpl' zone=$zone}
        {/foreach}
        {/if}
    {/foreach}
</div>
