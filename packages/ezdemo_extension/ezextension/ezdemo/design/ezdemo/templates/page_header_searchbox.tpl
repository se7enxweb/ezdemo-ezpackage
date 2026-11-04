{* The site search: posts to content/search, with the kernel's suggestions while typing
   (parts/front_search_suggest.tpl, restyled through the --exps-* tokens in theme.css). *}
{def $sfx = first_set( $search_suffix, '' )}
<form class="ed-search" method="post" action="{'/content/search'|ezurl( 'no' )}" id="site-wide-search{$sfx}" role="search">
    <label for="site-wide-search-field{$sfx}" class="ed-sr">{'Search'|i18n( 'design/ezdemo/pagelayout' )}</label>
    <svg class="ed-search-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" aria-hidden="true"><circle cx="11" cy="11" r="7"/><path d="M20 20l-3.5-3.5"/></svg>
    {if $pagedata.is_edit}
        <input class="ed-search-field" type="search" name="SearchText" id="site-wide-search-field{$sfx}" placeholder="{'Search'|i18n( 'design/ezdemo/pagelayout' )}" disabled="disabled" />
    {else}
        <input class="ed-search-field" type="search" name="SearchText" id="site-wide-search-field{$sfx}" placeholder="{'Search'|i18n( 'design/ezdemo/pagelayout' )}" autocomplete="off" />
        {include uri='design:parts/front_search_suggest.tpl' suggest_id=concat( 'site-search-suggest', $sfx )}
        {if eq( $ui_context, 'browse' )}
         <input name="Mode" type="hidden" value="browse" />
        {/if}
    {/if}
</form>
{undef $sfx}
