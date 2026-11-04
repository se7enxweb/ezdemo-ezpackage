{* Article - Full view: header with eyebrow, title, intro and byline; the picture; the body; tags, sharing and
   comments; the section's other pages and a contact box beside it. *}
{set scope=global persistent_variable=hash( 'left_menu', false(), 'extra_menu', false() )}
<article class="content-view-full class-article">
    <header class="ed-page-head">
        <p class="ed-eyebrow">{$node.parent.name|wash}</p>
        <h1>{$node.data_map.title.content|wash}</h1>
        {if and( eq( ezini( 'article', 'SummaryInFullView', 'content.ini' ), 'enabled' ), $node.data_map.intro.content.is_empty|not )}
            <div class="ed-lead">{attribute_view_gui attribute=$node.data_map.intro}</div>
        {/if}
        <div class="ed-meta">
            <time datetime="{$node.object.published|datetime( 'custom', '%Y-%m-%d' )}">{$node.object.published|l10n( 'date' )}</time>
            {if $node.data_map.author.content.is_empty|not()}<span>{attribute_view_gui attribute=$node.data_map.author}</span>{/if}
        </div>
    </header>
    {if and( eq( ezini( 'article', 'ImageInFullView', 'content.ini' ), 'enabled' ), $node.data_map.image.has_content )}
    <figure class="ed-figure">
        {include uri='design:parts/ezdemo/image.tpl' node=$node alias='ezdemo_wide' eager=true()}
        {if $node.data_map.image.content.data_map.caption.has_content}<figcaption>{attribute_view_gui attribute=$node.data_map.image.content.data_map.caption}</figcaption>{/if}
    </figure>
    {/if}
    <div class="ed-article-layout">
        <div>
            {if $node.data_map.body.content.is_empty|not}
            <div class="ed-prose">{attribute_view_gui attribute=$node.data_map.body}</div>
            {/if}
            {if is_set( $node.data_map.tags )}<div class="attribute-tags">{attribute_view_gui attribute=$node.data_map.tags}</div>{/if}
            {include uri='design:parts/social_buttons.tpl'}
            {include uri='design:parts/related_content.tpl'}
            {if $node.data_map.enable_comments.data_int}
                {include uri='design:parts/article/comments.tpl'}
            {/if}
        </div>
        <aside class="ed-aside">
            {include uri='design:parts/ezdemo/section_nav.tpl' node=$node}
            {include uri='design:parts/ezdemo/contact_box.tpl'}
        </aside>
    </div>
</article>
