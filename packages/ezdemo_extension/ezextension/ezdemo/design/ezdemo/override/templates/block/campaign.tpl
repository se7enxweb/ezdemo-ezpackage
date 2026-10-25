{def $valid_nodes = $block.valid_nodes
     $images = array()
     $several = $valid_nodes|count|gt( 1 )}
<!-- BLOCK: START -->
<div class="block-type-campaign" data-ezdemo-campaign="1">
    <div class="campaign">
        <a href="#" class="navig prev" style="opacity:0;"><span class="hide">&lt;</span></a>
        <a href={cond( $several, $valid_nodes[1].url_alias|ezurl, '"#"' )} class="navig next{cond( $several|not, ' disabled', '' )}"><span class="hide">&gt;</span></a>
        <ul class="indicator{cond( $several|not, ' disabled', '' )}">
            {for 1 to $valid_nodes|count as $i}
            <li{cond( $i|eq( 1 ), ' class="selected"', '' )}><span class="hide">{$i}</span></li>
            {/for}
        </ul>
        <ul class="images">
        {foreach $valid_nodes as $k => $img_node}<li>{node_view_gui view='block_item_campaign' image_class='campaign' content_node=$img_node}</li>{/foreach}
        </ul>
    </div>
</div>
<!-- BLOCK: END -->
{ezscript( array( 'ezdemo_actions.js' ) )}
{undef $valid_nodes $images $several}
