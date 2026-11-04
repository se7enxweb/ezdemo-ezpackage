{* One menu link; parameters: item (node), link_class, current (node id). *}
{if eq( $item.class_identifier, 'link' )}
<a class="{$link_class}" href={if eq( $ui_context, 'browse' )}{concat( 'content/browse/', $item.node_id )|ezurl}{else}{$item.data_map.location.content|ezurl}{/if}{if $pagedata.is_edit} data-ezdemo-noop="1"{/if}>{if $item.data_map.location.data_text}{$item.data_map.location.data_text|wash}{else}{$item.name|wash}{/if}</a>
{else}
<a class="{$link_class}" href={if eq( $ui_context, 'browse' )}{concat( 'content/browse/', $item.node_id )|ezurl}{else}{$item.url_alias|ezurl}{/if}{if $item.node_id|eq( $current )} aria-current="page"{/if}{if $pagedata.is_edit} data-ezdemo-noop="1"{/if}>{$item.name|wash}</a>
{/if}
