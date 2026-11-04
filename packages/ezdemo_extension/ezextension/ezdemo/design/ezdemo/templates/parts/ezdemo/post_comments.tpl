{* The comments below a blog post (comment objects below it) and a link to write one, when the reader may. *}
{def $ed_comments = fetch( 'content', 'list', hash( 'parent_node_id', $node.node_id, 'class_filter_type', 'include', 'class_filter_array', array( 'comment' ), 'sort_by', array( 'published', true() ) ) )}
<section class="ed-comments" aria-labelledby="ed-comments-{$node.node_id}">
    <h2 id="ed-comments-{$node.node_id}">{'Comments'|i18n( 'design/ezdemo/article/comments' )} <span class="ed-muted">({$ed_comments|count})</span></h2>
    <div class="ed-thread">
    {foreach $ed_comments as $c}
        <article class="ed-post">
            <div class="ed-comment-head"><span class="ed-avatar" aria-hidden="true">{$c.data_map.author.content|shorten( 1, '' )|upcase|wash}</span>
                <div><strong>{$c.data_map.author.content|wash}</strong><div class="ed-meta">{$c.object.published|l10n( 'shortdatetime' )}</div></div></div>
            <h3>{$c.data_map.subject.content|wash}</h3>
            <p>{$c.data_map.message.content|wash( xhtml )|nl2br}</p>
        </article>
    {/foreach}
    </div>
    {if fetch( 'content', 'access', hash( 'access', 'create', 'contentobject', $node, 'contentclass_id', 'comment' ) )}
    <form method="post" action={'content/action'|ezurl}>
        <input type="hidden" name="ClassIdentifier" value="comment" />
        <input type="hidden" name="NodeID" value="{$node.object.main_node.node_id}" />
        <input type="hidden" name="ContentLanguageCode" value="{ezini( 'RegionalSettings', 'ContentObjectLocale', 'site.ini' )}" />
        <button class="ed-btn" type="submit" name="NewButton">{'Write a comment'|i18n( 'design/ezdemo/article/comments' )}</button>
    </form>
    {/if}
</section>
{undef $ed_comments}
