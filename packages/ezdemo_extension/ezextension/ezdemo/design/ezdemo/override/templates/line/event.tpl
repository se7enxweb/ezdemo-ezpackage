{* Event - Line view: a date badge, the title, the time and category, a short text. *}
{def $ed_from = $node.data_map.from_time.content.timestamp
     $ed_to = cond( $node.data_map.to_time.has_content, $node.data_map.to_time.content.timestamp, $ed_from )}
<article class="ed-event ed-reveal{if gt( currentdate(), $ed_to )} is-past{/if}">
    <div class="ed-date" aria-hidden="true"><span>{$ed_from|datetime( 'custom', '%M' )}</span><b>{$ed_from|datetime( 'custom', '%j' )}</b><span>{$ed_from|datetime( 'custom', '%Y' )}</span></div>
    <div>
        <h3><a href={$node.url_alias|ezurl}>{$node.data_map.title.content|wash}</a></h3>
        <div class="ed-meta">
            <time datetime="{$ed_from|datetime( 'custom', '%Y-%m-%dT%H:%i' )}">{$ed_from|l10n( 'shortdatetime' )}{if $ed_to|ne( $ed_from )} – {$ed_to|l10n( cond( $ed_to|datetime( 'custom', '%Y%m%d' )|eq( $ed_from|datetime( 'custom', '%Y%m%d' ) ), 'shorttime', 'shortdatetime' ) )}{/if}</time>
            {if $node.data_map.category.has_content}<span class="ed-tag">{$node.data_map.category.content.keyword_string|wash}</span>{/if}
        </div>
        {if $node.data_map.text.has_content}<p>{$node.data_map.text.content.output.output_text|strip_tags|shorten( 180 )|wash}</p>{/if}
    </div>
</article>
{undef $ed_from $ed_to}
