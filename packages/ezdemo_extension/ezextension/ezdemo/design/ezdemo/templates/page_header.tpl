{* The site header: account links and languages on a slim bar, then logo, navigation, search, theme switch and the
   phone menu button. The phone layout opens the navigation as a panel (javascript/ezdemo/site.js). *}
<div class="ed-topbar">
    <div class="ed-wrap">
        {include uri='design:page_header_languages.tpl'}
        {include uri='design:page_header_links.tpl'}
    </div>
</div>
<header class="ed-header">
    <div class="ed-wrap ed-header-bar">
        {include uri='design:page_header_logo.tpl'}
        <nav class="ed-nav" id="ed-nav" aria-label="{'Main'|i18n( 'design/ezdemo/pagelayout' )}">
            {if $pagedata.top_menu}
                {include uri='design:page_topmenu.tpl'}
            {/if}
            <div class="ed-search-mobile">{include uri='design:page_header_searchbox.tpl' search_suffix='-mobile'}</div>
        </nav>
        <div class="ed-actions">
            {include uri='design:page_header_searchbox.tpl'}
            <button type="button" class="ed-icon-btn ed-theme-btn" data-ed-theme="1" aria-pressed="false"
                    aria-label="{'Use the dark theme'|i18n( 'design/ezdemo/pagelayout' )}"
                    data-label-dark="{'Use the dark theme'|i18n( 'design/ezdemo/pagelayout' )}"
                    data-label-light="{'Use the light theme'|i18n( 'design/ezdemo/pagelayout' )}">
                <svg class="ed-i-moon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M21 12.8A9 9 0 1 1 11.2 3a7 7 0 0 0 9.8 9.8z"/></svg>
                <svg class="ed-i-sun" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" aria-hidden="true"><circle cx="12" cy="12" r="4"/><path d="M12 2v2M12 20v2M4.9 4.9l1.4 1.4M17.7 17.7l1.4 1.4M2 12h2M20 12h2M4.9 19.1l1.4-1.4M17.7 6.3l1.4-1.4"/></svg>
            </button>
            <button type="button" class="ed-icon-btn ed-menu-btn" data-ed-menu="1" aria-controls="ed-nav" aria-expanded="false"
                    aria-label="{'Menu'|i18n( 'design/ezdemo/pagelayout' )}">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" aria-hidden="true"><path d="M4 7h16M4 12h16M4 17h16"/></svg>
            </button>
        </div>
    </div>
</header>
