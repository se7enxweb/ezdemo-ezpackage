<aside class="ed-aside ed-side-menu" aria-label="{'Section menu'|i18n( 'design/ezdemo/pagelayout' )}">
    {if is_array( $pagedata.left_menu )}
        {foreach $pagedata.left_menu as $left_menu}
            {include uri=concat( 'design:menu/', $left_menu, '.tpl' )}
        {/foreach}
    {else}
        {include uri=concat( 'design:menu/', $pagedata.left_menu, '.tpl' )}
    {/if}
</aside>
