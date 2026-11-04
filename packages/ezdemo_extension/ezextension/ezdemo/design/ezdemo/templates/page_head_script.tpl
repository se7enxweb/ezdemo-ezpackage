{* Only the light/dark choice runs in <head> (before the page paints); every other script is loaded at the end of
   the page by page_footer_script.tpl. *}
{ezscript_load( array( 'ezdemo/theme-init.js', ezini( 'JavaScriptSettings', 'JavaScriptList', 'design.ini' ) ) )}
