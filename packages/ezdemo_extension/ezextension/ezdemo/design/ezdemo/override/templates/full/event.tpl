{* Event - Full view: date badge, title, time, category and text, with an "add to calendar" link. *}
{set scope=global persistent_variable=hash( 'left_menu', false(), 'extra_menu', false() )}
{def $ed_from = $node.data_map.from_time.content.timestamp
     $ed_to = cond( $node.data_map.to_time.has_content, $node.data_map.to_time.content.timestamp, $ed_from )}
<article class="content-view-full class-event">
    <header class="ed-page-head ed-event-head">
        <div class="ed-date" aria-hidden="true"><span>{$ed_from|datetime( 'custom', '%M' )}</span><b>{$ed_from|datetime( 'custom', '%j' )}</b><span>{$ed_from|datetime( 'custom', '%Y' )}</span></div>
        <div>
            <p class="ed-eyebrow"><a href={$node.parent.url_alias|ezurl}>{$node.parent.name|wash}</a></p>
            <h1>{$node.data_map.title.content|wash}</h1>
            <div class="ed-meta">
                <time datetime="{$ed_from|datetime( 'custom', '%Y-%m-%dT%H:%i' )}">{$ed_from|l10n( 'datetime' )}</time>
                {if $ed_to|ne( $ed_from )}<span>{'until'|i18n( 'design/ezdemo/full/event' )} {$ed_to|l10n( 'datetime' )}</span>{/if}
                {if $node.data_map.category.has_content}<span class="ed-tag">{$node.data_map.category.content.keyword_string|wash}</span>{/if}
                {if gt( currentdate(), $ed_to )}<span class="ed-tag">{'Past event'|i18n( 'design/ezdemo/full/event' )}</span>{/if}
            </div>
        </div>
    </header>
    <div class="ed-article-layout">
        <div class="ed-prose">{attribute_view_gui attribute=$node.data_map.text}</div>
        <aside class="ed-aside">
            {include uri='design:parts/ezdemo/section_nav.tpl' node=$node}
            {include uri='design:parts/ezdemo/contact_box.tpl'}
        </aside>
    </div>
</article>
{undef $ed_from $ed_to}
