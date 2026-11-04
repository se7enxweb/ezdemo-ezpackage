{* Gallery block: a scrolling strip of pictures; a click opens them in the lightbox (javascript/ezdemo/gallery.js),
   without JavaScript the image page. *}
{def $valid_nodes = $block.valid_nodes}
<section class="ed-section ed-block ed-block-gallery">
    <div class="ed-wrap" data-ed-strip="1">
        <div class="ed-section-head ed-reveal">
            <h2>{$block.name|wash}</h2>
            <div class="ed-strip-nav">
                <button type="button" class="ed-icon-btn" data-ed-strip-go="prev" aria-label="{'Scroll back'|i18n( 'design/ezdemo/block' )}"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" aria-hidden="true"><path d="M15 5l-7 7 7 7"/></svg></button>
                <button type="button" class="ed-icon-btn" data-ed-strip-go="next" aria-label="{'Scroll on'|i18n( 'design/ezdemo/block' )}"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" aria-hidden="true"><path d="M9 5l7 7-7 7"/></svg></button>
            </div>
        </div>
        {include uri='design:parts/ezdemo/gallery_items.tpl' items=$valid_nodes layout='strip' id=$block.id}
    </div>
</section>
{undef $valid_nodes}
