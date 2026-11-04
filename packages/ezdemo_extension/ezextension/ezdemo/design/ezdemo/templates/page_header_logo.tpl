{* The logo: the site's own logo image when one is set (template look, ezini SiteSettings LogoURL), else the
   Exponential mark and the site name. *}
<a class="ed-logo" href={'/'|ezurl} rel="home">
    <svg viewBox="0 0 40 40" aria-hidden="true"><defs><linearGradient id="ed-logo-g" x1="0" y1="0" x2="1" y2="1"><stop offset="0" stop-color="#7c6cff"/><stop offset="1" stop-color="#22d3ee"/></linearGradient></defs><rect width="40" height="40" rx="11" fill="url(#ed-logo-g)"/><path d="M12 11h15M12 20h12M12 29h15M12 11v18" fill="none" stroke="#fff" stroke-width="3.2" stroke-linecap="round"/><circle cx="29.5" cy="20" r="2.4" fill="#fff"/></svg>
    <span class="ed-logo-name">{ezini( 'SiteSettings', 'SiteName' )|wash}</span>
</a>
