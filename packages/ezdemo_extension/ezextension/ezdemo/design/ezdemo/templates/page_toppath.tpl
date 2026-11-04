{* The breadcrumb of the current page. *}
<nav class="ed-wrap" aria-label="{'Breadcrumb'|i18n( 'design/ezdemo/pagelayout' )}">
    <ol class="ed-crumbs">
    {foreach $pagedata.path_array as $path}
        {if $path.url}
        <li><a href={cond( is_set( $path.url_alias ), $path.url_alias, $path.url )|ezurl}>{$path.text|shorten( 40 )|wash}</a></li>
        {else}
        <li><span aria-current="page">{$path.text|shorten( 60 )|wash}</span></li>
        {/if}
    {/foreach}
    </ol>
</nav>
