{* Image - Full view: the picture large, its caption and credit, previous and next picture of the same folder. *}
{set scope=global persistent_variable=hash( 'left_menu', false(), 'extra_menu', false() )}
{def $parent = $node.parent
     $siblings = fetch( 'content', 'list', hash( 'parent_node_id', $parent.node_id, 'class_filter_type', 'include', 'class_filter_array', array( 'image' ),
                                                 'sort_by', $parent.sort_array, 'limit', 1000, 'as_object', false() ) )
     $index = 0 $prev = false() $next = false()}
{foreach $siblings as $k => $s}{if $s.node_id|eq( $node.node_id )}{set $index = $k}{/if}{/foreach}
{if $index|gt( 0 )}{set $prev = fetch( 'content', 'node', hash( 'node_id', $siblings[$index|dec].node_id ) )}{/if}
{if $index|lt( $siblings|count|dec )}{set $next = fetch( 'content', 'node', hash( 'node_id', $siblings[$index|inc].node_id ) )}{/if}
<article class="content-view-full class-image">
    <header class="ed-page-head">
        <p class="ed-eyebrow"><a href={$parent.url_alias|ezurl}>{$parent.name|wash}</a></p>
        <h1>{$node.name|wash}</h1>
    </header>
    <figure class="ed-figure ed-figure-natural">
        {include uri='design:parts/ezdemo/image.tpl' node=$node alias='ezdemo_hero' eager=true()}
        {if $node.data_map.caption.has_content}<figcaption>{attribute_view_gui attribute=$node.data_map.caption}</figcaption>{/if}
    </figure>
    <nav class="ed-pager" aria-label="{'Pictures'|i18n( 'design/ezdemo/full/image' )}">
        <span>{if $prev}<a href={$prev.url_alias|ezurl} rel="prev">&larr; {$prev.name|wash}</a>{/if}</span>
        <span>{if $next}<a href={$next.url_alias|ezurl} rel="next">{$next.name|wash} &rarr;</a>{/if}</span>
    </nav>
    {include uri='design:parts/social_buttons.tpl'}
</article>
{undef $parent $siblings $index $prev $next}
