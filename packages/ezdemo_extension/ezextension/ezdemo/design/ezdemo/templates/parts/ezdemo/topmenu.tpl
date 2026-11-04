{* The main navigation (menu.ini [MenuContentSettings] TopIdentifierList): the first menu.ini [EzdemoTopMenu]
   VisibleItems items, the rest under "More" (a disclosure, javascript/ezdemo/site.js), the classes of
   CallToActionClasses (the contact form) as a button at the end. Links of the link class point to their URL. *}
{def $root_node = fetch( 'content', 'node', hash( 'node_id', $pagedata.root_node ) )
     $items = fetch( 'content', 'list', hash( 'parent_node_id', $root_node.node_id,
                                              'sort_by', $root_node.sort_array,
                                              'class_filter_type', 'include',
                                              'class_filter_array', ezini( 'MenuContentSettings', 'TopIdentifierList', 'menu.ini' ) ) )
     $visible = ezini( 'EzdemoTopMenu', 'VisibleItems', 'menu.ini' )|int
     $cta_classes = ezini( 'EzdemoTopMenu', 'CallToActionClasses', 'menu.ini' )
     $in_path = first_set( $pagedata.path_array[1].node_id, 0 )
     $menu = array()
     $more = array()
     $cta = array()}
{foreach $items as $item}
    {if $cta_classes|contains( $item.class_identifier )}{set $cta = $cta|append( $item )}
    {elseif $menu|count|lt( $visible )}{set $menu = $menu|append( $item )}
    {else}{set $more = $more|append( $item )}{/if}
{/foreach}
<ul class="ed-nav-list">
{foreach $menu as $item}
    <li{if $in_path|eq( $item.node_id )} class="is-current"{/if}>{include uri='design:parts/ezdemo/menu_link.tpl' item=$item link_class='ed-nav-link' current=$current_node_id}</li>
{/foreach}
{if $more|count}
    <li>
        <button type="button" class="ed-nav-link" data-ed-disclosure="1" aria-expanded="false" aria-controls="ed-nav-more">{'More'|i18n( 'design/ezdemo/pagelayout' )}
            <svg class="ed-chevron" viewBox="0 0 12 12" fill="none" stroke="currentColor" stroke-width="1.8" aria-hidden="true"><path d="M2 4l4 4 4-4"/></svg></button>
        <ul class="ed-nav-more" id="ed-nav-more" hidden="hidden">
        {foreach $more as $item}
            <li>{include uri='design:parts/ezdemo/menu_link.tpl' item=$item link_class='' current=$current_node_id}</li>
        {/foreach}
        </ul>
    </li>
{/if}
{foreach $cta as $item}
    <li><a class="ed-btn ed-btn-primary ed-btn-s" href={$item.url_alias|ezurl}{if $pagedata.is_edit} data-ezdemo-noop="1"{/if}>{$item.name|wash}</a></li>
{/foreach}
</ul>
{undef $root_node $items $visible $cta_classes $in_path $menu $more $cta}
