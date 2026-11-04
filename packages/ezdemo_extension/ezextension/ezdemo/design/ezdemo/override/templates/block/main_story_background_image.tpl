{* Main story, "Background image" view: a full-width hero with the story's picture, the block name as eyebrow, the
   story's title and intro, and links to the story and to the first section of the site. *}
{def $valid_node = $block.valid_nodes[0]}
{if $valid_node}
{def $ed_platform = fetch( 'content', 'node', hash( 'node_path', 'platform' ) )}
<section class="ed-hero ed-block-mainstory">
    <div class="ed-hero-media">{include uri='design:parts/ezdemo/image.tpl' node=$valid_node alias='ezdemo_hero' eager=true() alt=''}</div>
    <div class="ed-wrap ed-hero-body">
        {if $block.name|ne( '' )}<p class="ed-eyebrow">{$block.name|wash}</p>{/if}
        <h1>{if is_set( $valid_node.data_map.title )}{$valid_node.data_map.title.content|wash}{else}{$valid_node.name|wash}{/if}</h1>
        {if is_set( $valid_node.data_map.intro )}<div class="ed-lead">{attribute_view_gui attribute=$valid_node.data_map.intro}</div>{/if}
        <div class="ed-hero-actions">
            <a class="ed-btn ed-btn-primary" href={$valid_node.url_alias|ezurl}>{'Discover what is new'|i18n( 'design/ezdemo/block' )}</a>
            {if $ed_platform}<a class="ed-btn ed-btn-light" href={$ed_platform.url_alias|ezurl}>{'Explore the platform'|i18n( 'design/ezdemo/block' )}</a>{/if}
        </div>
    </div>
</section>
{undef $ed_platform}
{/if}
{undef $valid_node}
