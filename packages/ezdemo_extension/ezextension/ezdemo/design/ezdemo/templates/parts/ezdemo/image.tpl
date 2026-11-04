{* One <img> of a content node or an image attribute, with its width and height, lazy loaded unless eager.
   Parameters: node (an article's related image, a product's, place's or image's own image, a blog post's first
   embedded image) or image (an ezimage attribute); alias (default ezdemo_card); class; eager (true for the
   picture at the top of a page); alt (replaces the image's alternative text; '' for a decorative picture). *}
{def $ed_img = false()}
{if is_set( $image )}
    {set $ed_img = $image}
{elseif is_set( $node )}
    {if is_set( $node.data_map.image )}
        {if $node.data_map.image.data_type_string|eq( 'ezimage' )}
            {set $ed_img = $node.data_map.image}
        {elseif and( $node.data_map.image.data_type_string|eq( 'ezobjectrelation' ), $node.data_map.image.has_content )}
            {if is_set( $node.data_map.image.content.data_map.image )}{set $ed_img = $node.data_map.image.content.data_map.image}{/if}
        {/if}
    {elseif $node.class_identifier|eq( 'blog_post' )}
        {def $ed_rel = fetch( 'content', 'related_objects', hash( 'object_id', $node.contentobject_id, 'all_relations', array( 'xml_embed' ) ) )}
        {foreach $ed_rel as $ed_r}{if and( $ed_img|not, is_set( $ed_r.data_map.image ), $ed_r.data_map.image.data_type_string|eq( 'ezimage' ) )}{set $ed_img = $ed_r.data_map.image}{/if}{/foreach}
        {undef $ed_rel}
    {/if}
{/if}
{if and( $ed_img, $ed_img.has_content )}
{def $ed_a = $ed_img.content[first_set( $alias, 'ezdemo_card' )]}
<img src={$ed_a.url|ezroot} width="{$ed_a.width}" height="{$ed_a.height}" alt="{if is_set( $alt )}{$alt|wash}{else}{$ed_img.content.alternative_text|wash}{/if}"{if is_set( $class )} class="{$class}"{/if}{if first_set( $eager, false() )} fetchpriority="high"{else} loading="lazy" decoding="async"{/if} />
{undef $ed_a}
{/if}
{undef $ed_img}
