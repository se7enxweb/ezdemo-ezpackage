{* A card for a node in a grid (content grid blocks, folder and blog lists). Products and calls to action have
   their own block_item views; every other class gets image, eyebrow, title, summary and a "read more".
   Parameters: node; eyebrow (optional); heading_level (default 3). *}
{if array( 'product', 'call_to_action' )|contains( $node.class_identifier )}
    {node_view_gui view='block_item' content_node=$node}
{else}
{def $ed_h = first_set( $heading_level, 3 )
     $ed_dm = $node.data_map
     $ed_summary = false()}
{if is_set( $ed_dm.intro )}{set $ed_summary = $ed_dm.intro}
{elseif is_set( $ed_dm.short_description )}{set $ed_summary = $ed_dm.short_description}
{elseif is_set( $ed_dm.description )}{set $ed_summary = $ed_dm.description}
{elseif is_set( $ed_dm.caption )}{set $ed_summary = $ed_dm.caption}{/if}
<article class="ed-card ed-reveal">
    <div class="ed-card-media">{include uri='design:parts/ezdemo/image.tpl' node=$node alias='ezdemo_card' alt=''}</div>
    <div class="ed-card-body">
        {if is_set( $eyebrow )}<p class="ed-eyebrow">{$eyebrow|wash}</p>
        {elseif $node.class_identifier|eq( 'blog_post' )}<p class="ed-eyebrow">{$ed_dm.publication_date.content.timestamp|l10n( 'date' )}</p>
        {elseif $node.class_identifier|eq( 'event' )}<p class="ed-eyebrow">{$ed_dm.from_time.content.timestamp|l10n( 'shortdate' )}</p>{/if}
        <h{$ed_h}><a href={$node.url_alias|ezurl}>{if is_set( $ed_dm.title )}{$ed_dm.title.content|wash}{else}{$node.name|wash}{/if}</a></h{$ed_h}>
        {if and( $ed_summary, $ed_summary.has_content )}<div class="ed-card-text">{attribute_view_gui attribute=$ed_summary}</div>
        {elseif and( is_set( $ed_dm.metadata ), $ed_dm.metadata.has_content )}<p>{$ed_dm.metadata.content.description|shorten( 160 )|wash}</p>{/if}
        <div class="ed-card-foot"><span class="ed-more" aria-hidden="true">{'Read more'|i18n( 'design/ezdemo/block' )}</span></div>
    </div>
</article>
{undef $ed_h $ed_dm $ed_summary}
{/if}
