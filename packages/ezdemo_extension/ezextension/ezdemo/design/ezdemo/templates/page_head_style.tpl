{* The design's stylesheets, packed by ezjscore: theme.css (tokens, light and dark, every component) and the lists of
   design.ini [StylesheetSettings]. The kernel's t02 colour sheets (SiteCSS, ClassesCSS) only when a site sets them. *}
{if is_unset( $load_css_file_list )}
    {def $load_css_file_list = true()}
{/if}
<link rel="preload" href={'fonts/inter-latin.woff2'|ezdesign} as="font" type="font/woff2" crossorigin="anonymous" />
{if $load_css_file_list}
  {ezcss_load( array( 'ezdemo/theme.css',
                      'debug.css',
                      ezini( 'StylesheetSettings', 'CSSFileList', 'design.ini' ),
                      ezini( 'StylesheetSettings', 'FrontendCSSFileList', 'design.ini' ) ) )}
{else}
  {ezcss_load( array( 'ezdemo/theme.css', 'debug.css' ) )}
{/if}
{if ne( ezini( 'StylesheetSettings', 'ClassesCSS', 'design.ini' ), '' )}
<link rel="stylesheet" href={ezini( 'StylesheetSettings', 'ClassesCSS', 'design.ini' )|ezroot()} />
{/if}
{if ne( ezini( 'StylesheetSettings', 'SiteCSS', 'design.ini' ), '' )}
<link rel="stylesheet" href={ezini( 'StylesheetSettings', 'SiteCSS', 'design.ini' )|ezroot()} />
{/if}
