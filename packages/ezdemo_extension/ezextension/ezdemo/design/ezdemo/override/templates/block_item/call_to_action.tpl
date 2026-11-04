{* A call to action in a block: a band with its title, description and button. *}
<div class="ed-cta ed-reveal">
    <div>
        <h3>{$node.name|wash}</h3>
        {if $node.data_map.description.has_content}{attribute_view_gui attribute=$node.data_map.description}{/if}
    </div>
    <div class="ed-cta-actions">
        <a href={$node.url_alias|ezurl} class="ed-btn ed-btn-primary">{if $node.data_map.action_button_label.has_content}{$node.data_map.action_button_label.data_text|wash( xhtml )}{else}{'Get started'|i18n( 'design/ezdemo/block_item/call_to_action' )}{/if}</a>
    </div>
</div>
