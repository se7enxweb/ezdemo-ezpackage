{* The language switcher, when the content is available in more than one siteaccess language. *}
{def $avail_translation = array()}
{if and( is_set( $DesignKeys:used.url_alias ), $DesignKeys:used.url_alias|count|ge( 1 ) )}
    {set $avail_translation = language_switcher( $DesignKeys:used.url_alias )}
{else}
    {set $avail_translation = language_switcher( $site.uri.original_uri )}
{/if}
{if $avail_translation|count|gt( 1 )}
<ul class="ed-lang" aria-label="{'Languages'|i18n( 'design/ezdemo/pagelayout' )}">
    {foreach $avail_translation as $siteaccess => $lang}
    <li{if $siteaccess|eq( $access_type.name )} class="current"{/if}><a href={$lang.url|ezurl} hreflang="{$lang.locale|wash}"{if $siteaccess|eq( $access_type.name )} aria-current="true"{/if}>{$lang.text|wash}</a></li>
    {/foreach}
</ul>
{else}
    {def $ed_launch = fetch( 'content', 'node', hash( 'node_path', 'launch' ) )}
    {if $ed_launch}<p class="ed-topbar-note">{'New: Exponential 6.0.15 is here.'|i18n( 'design/ezdemo/pagelayout' )} <a href={$ed_launch.url_alias|ezurl}>{'See what is new'|i18n( 'design/ezdemo/pagelayout' )}</a></p>{else}<span></span>{/if}
    {undef $ed_launch}
{/if}
{undef $avail_translation}
