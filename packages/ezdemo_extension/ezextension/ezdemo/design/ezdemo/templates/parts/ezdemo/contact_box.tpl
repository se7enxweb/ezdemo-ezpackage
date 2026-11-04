{* A small call to action to the site's contact form (the first feedback form below the root), when there is one. *}
{def $ed_contact = fetch( 'content', 'list', hash( 'parent_node_id', ezini( 'NodeSettings', 'RootNode', 'content.ini' ), 'limit', 1,
                                                    'class_filter_type', 'include', 'class_filter_array', array( 'feedback_form' ) ) )}
{if $ed_contact|count}
<div class="ed-aside-box ed-aside-cta">
    <h2>{'Questions?'|i18n( 'design/ezdemo/full' )}</h2>
    <p>{'Talk to the team about your project.'|i18n( 'design/ezdemo/full' )}</p>
    <a class="ed-btn ed-btn-primary ed-btn-s" href={$ed_contact[0].url_alias|ezurl}>{'Contact us'|i18n( 'design/ezdemo/full' )}</a>
</div>
{/if}
{undef $ed_contact}
