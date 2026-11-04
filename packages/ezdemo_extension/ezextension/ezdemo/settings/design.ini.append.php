<?php /*

[ExtensionSettings]
DesignExtensions[]=ezdemo

[StylesheetSettings]
# The kernel's t02 colour sheets are not part of this design (they do not exist in it)
SiteCSS=
ClassesCSS=

# The design's scripts, in plain JavaScript (no jQuery) on expui's core; loaded at the end of the page by
# page_footer_script.tpl after exp::core::shared and exp::io. They replace the jQuery scripts of the old design:
# site.js (menu, disclosures, theme switch, reveal; was toggle_class, handle_transition, eztransition, init_ua,
# heightresize), carousel.js (campaign block; was ezsimplegallery), gallery.js (lightbox; was ezgallery and
# ezgallerynavigator), ezdemo_actions.js (template actions; no jQuery any more).
[JavaScriptSettings]
JavaScriptFooterList[]
FrontendJavaScriptList[]
FrontendJavaScriptList[]=ezdemo/site.js
FrontendJavaScriptList[]=ezdemo/carousel.js
FrontendJavaScriptList[]=ezdemo/gallery.js
FrontendJavaScriptList[]=ezdemo_actions.js

*/ ?>
