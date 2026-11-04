<aside class="ed-aside ed-extra-menu">
    {if is_array( $pagedata.extra_menu )}
        {foreach $pagedata.extra_menu as $extra_menu}
            {include uri=concat( 'design:parts/', $extra_menu, '.tpl' )}
        {/foreach}
    {else}
        {include uri=concat( 'design:parts/', $pagedata.extra_menu, '.tpl' )}
    {/if}
</aside>
