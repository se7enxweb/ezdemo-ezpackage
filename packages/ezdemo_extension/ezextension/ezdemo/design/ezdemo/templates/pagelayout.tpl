<!DOCTYPE html>
<html lang="{$site.http_equiv.Content-language|wash}">
<head>
{def $basket_is_empty   = cond( $current_user.is_logged_in, fetch( shop, basket ).is_empty, 1 )
     $user_hash         = concat( $current_user.role_id_list|implode( ',' ), ',', $current_user.limited_assignment_value_list|implode( ',' ) )}

{include uri='design:page_head_displaystyles.tpl'}

{if is_set( $extra_cache_key )|not}
    {def $extra_cache_key = ''}
{/if}
{* Error pages can arrive with the same URI while their title and path name the error: key them
   by error type and number too (every other page keeps the plain URI key) *}
{def $uri_cache_key = $module_result.uri}
{if is_set( $module_result.errorType )}
{set $uri_cache_key = concat( $module_result.uri, '|error|', $module_result.errorType, '|', first_set( $module_result.errorNumber, '' ) )}
{/if}

{def $pagedata        = ezpagedata()
     $inner_column_size = $pagedata.inner_column_size
     $outer_column_size = $pagedata.outer_column_size
     $ed_class        = first_set( $module_result.content_info.class_identifier, '' )
     $ed_full         = and( $ed_class|eq( 'landing_page' ), $pagedata.left_menu|not, $pagedata.extra_menu|not, $pagedata.is_edit|not )}

{cache-block keys=array( $uri_cache_key, $basket_is_empty, $current_user.contentobject_id, $extra_cache_key )}
{def $pagestyle        = $pagedata.css_classes
     $locales          = fetch( 'content', 'translation_list' )
     $current_node_id  = $pagedata.node_id}

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="color-scheme" content="light dark">
    <meta name="theme-color" content="#fbfaf7" media="(prefers-color-scheme: light)">
    <meta name="theme-color" content="#0e0d1a" media="(prefers-color-scheme: dark)">

{include uri='design:page_head.tpl'}
{include uri='design:page_head_style.tpl'}
{include uri='design:page_head_script.tpl'}

</head>
<body>
<a class="ed-skip" href="#main">{'Skip to content'|i18n( 'design/ezdemo/pagelayout' )}</a>

<div id="page" class="{$pagestyle}{if $ed_full} ed-page-full{/if}">

    {if and( is_set( $pagedata.persistent_variable.extra_template_list ),
             $pagedata.persistent_variable.extra_template_list|count() )}
    {foreach $pagedata.persistent_variable.extra_template_list as $extra_template}
        {include uri=concat('design:extra/', $extra_template)}
    {/foreach}
    {/if}

    {include uri='design:page_header.tpl'}
    {cache-block keys=array( $uri_cache_key, $user_hash, $extra_cache_key, $current_user.contentobject_id|eq( $pagedata.owner_id ) )}

    {if and( $pagedata.website_toolbar, $pagedata.is_edit|not)}
        {include uri='design:page_toolbar.tpl'}
    {/if}

    <main id="main" class="ed-main{if $ed_full} ed-main-full{/if}" tabindex="-1">
    {if and( $pagedata.show_path, $ed_full|not, $current_node_id|ne( $pagedata.root_node ) )}
        {include uri='design:page_toppath.tpl'}
    {/if}
    <div class="ed-main-inner">
    {if $ed_full|not}<div class="ed-wrap"><div class="ed-columns{if $pagedata.left_menu} has-left{/if}{if $pagedata.extra_menu} has-extra{/if}">{/if}
    {if and( $ed_full|not, $pagedata.left_menu )}
        {include uri='design:page_leftmenu.tpl'}
    {/if}
    {/cache-block}
    {/cache-block}
            {include uri='design:page_mainarea.tpl'}
    {cache-block keys=array( $uri_cache_key, $user_hash, $access_type.name, $extra_cache_key )}
    {if and( $ed_full|not, $pagedata.extra_menu )}
        {include uri='design:page_extramenu.tpl'}
    {/if}
    {if $ed_full|not}</div></div>{/if}
    </div>
    </main>

    {include uri='design:page_footer.tpl'}

</div>

{include uri='design:page_footer_script.tpl'}

{/cache-block}

{* This comment will be replaced with actual debug report (if debug is on). *}
<!--DEBUG_REPORT-->
</body>
</html>
