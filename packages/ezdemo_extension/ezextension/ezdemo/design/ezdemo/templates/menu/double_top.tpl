{* The top menu of design.ini/menu.ini TopMenu=double_top: the design's one main navigation (parts/ezdemo/topmenu.tpl). *}
{if $pagedata.is_edit}{ezscript( array( 'ezdemo_actions.js' ) )}{/if}
{include uri='design:parts/ezdemo/topmenu.tpl'}
