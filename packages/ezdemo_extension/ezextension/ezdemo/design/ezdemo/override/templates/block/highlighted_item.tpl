{* Highlighted item: one piece of content beside its picture, with its intro and a link. *}
{def $node = $block.valid_nodes[0]}
{if $node}
<section class="ed-section ed-block ed-block-highlight">
    <div class="ed-wrap ed-split">
        <div class="ed-split-media ed-reveal">{include uri='design:parts/ezdemo/image.tpl' node=$node alias='ezdemo_wide'}</div>
        <div class="ed-reveal">
            {if $block.name|ne( '' )}<p class="ed-eyebrow">{$block.name|wash}</p>{/if}
            <h2>{if is_set( $node.data_map.title )}{$node.data_map.title.content|wash}{else}{$node.name|wash}{/if}</h2>
            {if is_set( $node.data_map.intro )}<div class="ed-lead">{attribute_view_gui attribute=$node.data_map.intro}</div>{/if}
            <p><a class="ed-btn ed-btn-primary" href={$node.url_alias|ezurl}>{'Learn more'|i18n( 'design/ezdemo/block' )}<span class="ed-sr">: {$node.name|wash}</span></a></p>
        </div>
    </div>
</section>
{/if}
{undef $node}
