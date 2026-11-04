{* The tag cloud: each tag's weight as one of five size classes (ed-tag-w1 to ed-tag-w5) instead of an inline
   font size. *}
{foreach $tag_cloud as $tag}
{def $ed_w = $tag['font_size']|div( 50 )|floor|max( 1 )|min( 5 )}
<a class="ed-tag-w{$ed_w}" href={concat( "/content/keyword/", $tag['tag']|rawurlencode )|ezurl()} title="{'%count items tagged %tag'|i18n( 'design/ezdemo/tagcloud', '', hash( '%count', $tag['count'], '%tag', $tag['tag'] ) )|wash}">{$tag['tag']|wash()}</a>
{undef $ed_w}
{/foreach}
