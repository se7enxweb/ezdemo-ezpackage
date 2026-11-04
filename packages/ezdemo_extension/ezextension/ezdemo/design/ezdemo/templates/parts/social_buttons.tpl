{* Sharing: plain links to share the page (no third-party scripts or trackers on the page) and a "Copy link"
   button (javascript/ezdemo/site.js). Replaces the Twitter, Facebook and Google+ button scripts. *}
{def $ed_url = concat( 'https://', ezsys( 'hostname' ), $node.url_alias|ezurl( 'no' ) )
     $ed_title = $node.name}
<div class="ed-share" aria-label="{'Share this page'|i18n( 'design/ezdemo/share' )}" role="group">
    <span class="ed-share-label">{'Share'|i18n( 'design/ezdemo/share' )}</span>
    <a class="ed-icon-btn" href="https://www.linkedin.com/sharing/share-offsite/?url={$ed_url|rawurlencode}" rel="noopener" target="_blank" aria-label="{'Share on LinkedIn'|i18n( 'design/ezdemo/share' )}"><svg viewBox="0 0 24 24" fill="currentColor" aria-hidden="true"><path d="M4.98 3.5a2.5 2.5 0 1 1 0 5 2.5 2.5 0 0 1 0-5zM3 9.5h4V21H3zM9.5 9.5h3.8v1.6h.06c.53-1 1.84-2.06 3.79-2.06 4.05 0 4.8 2.67 4.8 6.13V21h-4v-5.1c0-1.22-.02-2.79-1.7-2.79-1.7 0-1.96 1.33-1.96 2.7V21h-4z"/></svg></a>
    <a class="ed-icon-btn" href="https://bsky.app/intent/compose?text={concat( $ed_title, ' ', $ed_url )|rawurlencode}" rel="noopener" target="_blank" aria-label="{'Share on Bluesky'|i18n( 'design/ezdemo/share' )}"><svg viewBox="0 0 24 24" fill="currentColor" aria-hidden="true"><path d="M6.3 4.2C8.6 5.9 11 9.4 12 11.4c1-2 3.4-5.5 5.7-7.2 1.6-1.2 4.3-2.2 4.3.9 0 .6-.4 5.2-.6 5.9-.7 2.5-3.3 3.2-5.6 2.8 4 .7 5 3 2.8 5.2-4.2 4.3-6-1.1-6.5-2.5l-.1-.3-.1.3c-.5 1.4-2.3 6.8-6.5 2.5-2.2-2.2-1.2-4.5 2.8-5.2-2.3.4-4.9-.3-5.6-2.8C2.4 10.3 2 5.7 2 5.1c0-3.1 2.7-2.1 4.3-.9z"/></svg></a>
    <a class="ed-icon-btn" href="mailto:?subject={$ed_title|rawurlencode}&amp;body={$ed_url|rawurlencode}" aria-label="{'Share by email'|i18n( 'design/ezdemo/share' )}"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><rect x="3" y="5" width="18" height="14" rx="2"/><path d="M3 7l9 6 9-6"/></svg></a>
    <button type="button" class="ed-icon-btn" data-ed-copy="{$ed_url|wash}" data-text-done="{'Link copied'|i18n( 'design/ezdemo/share' )}" aria-label="{'Copy link'|i18n( 'design/ezdemo/share' )}"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" aria-hidden="true"><path d="M10 13a5 5 0 0 0 7 0l3-3a5 5 0 0 0-7-7l-1 1"/><path d="M14 11a5 5 0 0 0-7 0l-3 3a5 5 0 0 0 7 7l1-1"/></svg></button>
    <span class="ed-share-status ed-sr" aria-live="polite"></span>
</div>
{undef $ed_url $ed_title}
