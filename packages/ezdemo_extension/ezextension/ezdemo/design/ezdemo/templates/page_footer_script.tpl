{* The design's scripts: expui's core and server calls without jQuery (exp::core::shared, exp::io) and the design's
   own plain JavaScript (design.ini [JavaScriptSettings] FrontendJavaScriptList), packed by ezjscore. Pages that
   still need jQuery (the editing screens) ask for ezjsc::jquery themselves.
   Override this template to add statistics (like an analytics script file). *}
{exp_config()}
{ezscript_load( array( 'exp::core::shared', 'exp::io', ezini( 'JavaScriptSettings', 'FrontendJavaScriptList', 'design.ini' ) ) )}
