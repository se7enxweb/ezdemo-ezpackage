{* Main story, "Highlighted" view: the story beside its picture, on the page background. *}
{def $valid_node = $block.valid_nodes[0]}
{if $valid_node}
<section class="ed-block-mainstory-split">
    <div class="ed-wrap ed-hero-split">
        <div>
            {if $block.name|ne( '' )}<p class="ed-eyebrow">{$block.name|wash}</p>{/if}
            <h1>{if is_set( $valid_node.data_map.title )}{$valid_node.data_map.title.content|wash}{else}{$valid_node.name|wash}{/if}</h1>
            {if is_set( $valid_node.data_map.intro )}<div class="ed-lead">{attribute_view_gui attribute=$valid_node.data_map.intro}</div>{/if}
            <div class="ed-hero-actions"><a class="ed-btn ed-btn-primary" href={$valid_node.url_alias|ezurl}>{'Read the story'|i18n( 'design/ezdemo/block' )}</a></div>
        </div>
        <div class="ed-hero-figure">{include uri='design:parts/ezdemo/image.tpl' node=$valid_node alias='ezdemo_wide' eager=true()}</div>
    </div>
</section>
{/if}
{undef $valid_node}
