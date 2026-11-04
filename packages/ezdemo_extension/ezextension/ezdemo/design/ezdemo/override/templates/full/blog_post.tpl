{* Blog post - Full view: header with date, author and tags; the body (its first embedded picture leads); sharing,
   related content and comments; the blog's tags and archive beside it. *}
{set scope=global persistent_variable=hash( 'left_menu', false(), 'extra_menu', false() )}
<article class="content-view-full class-blog-post">
    <header class="ed-page-head ed-wrap-text ed-post-head">
        <p class="ed-eyebrow"><a href={$node.parent.url_alias|ezurl}>{$node.parent.name|wash}</a></p>
        <h1>{$node.data_map.title.content|wash}</h1>
        <div class="ed-meta">
            <time datetime="{$node.data_map.publication_date.content.timestamp|datetime( 'custom', '%Y-%m-%d' )}">{$node.data_map.publication_date.content.timestamp|l10n( 'date' )}</time>
            <span>{$node.object.owner.name|wash}</span>
        </div>
        {if $node.data_map.tags.has_content}
        <ul class="ed-tags">
            {foreach $node.data_map.tags.content.keywords as $kw}<li><a href={concat( $node.parent.url_alias, '/(tag)/', $kw|rawurlencode )|ezurl}>{$kw|wash}</a></li>{/foreach}
        </ul>
        {/if}
    </header>
    <div class="ed-article-layout">
        <div>
            <div class="ed-prose ed-post-body">{attribute_view_gui attribute=$node.data_map.body}</div>
            {include uri='design:parts/social_buttons.tpl'}
            {include uri='design:parts/related_content.tpl'}
            {include uri='design:parts/ezdemo/post_comments.tpl' node=$node}
        </div>
        <aside class="ed-aside ed-blog-aside">
            <div class="ed-aside-box">{include uri='design:parts/blog/extra_info.tpl' used_node=$node.parent}</div>
        </aside>
    </div>
</article>
