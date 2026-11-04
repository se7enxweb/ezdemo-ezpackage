{* Account links: basket, profile and sign out for a signed-in user; sign in (a disclosure with the form) and
   register for a visitor. The full sign-in page (passkeys, two-factor) stays at user/login. *}
<ul class="ed-userbar">
    <li><a href={concat( '/content/view/sitemap/', $pagedata.root_node )|ezurl}>{'Site map'|i18n( 'design/ezdemo/pagelayout' )}</a></li>
    {if $basket_is_empty|not()}
    <li><a href={'/shop/basket/'|ezurl}>{'Shopping basket'|i18n( 'design/ezdemo/pagelayout' )}</a></li>
    {/if}
{if $current_user.is_logged_in}
    <li><a href={'/user/edit/'|ezurl}>{'My profile'|i18n( 'design/ezdemo/pagelayout' )}</a></li>
    <li><a href={'/user/logout'|ezurl}>{'Logout'|i18n( 'design/ezdemo/pagelayout' )} ({$current_user.contentobject.name|wash})</a></li>
{else}
    {if ezmodule( 'user/register' )}
    <li><a href={'/user/register'|ezurl}>{'Register'|i18n( 'design/ezdemo/pagelayout' )}</a></li>
    {/if}
    <li><a href={'/user/login'|ezurl}>{'Login'|i18n( 'design/ezdemo/pagelayout' )}</a></li>
{/if}
</ul>
