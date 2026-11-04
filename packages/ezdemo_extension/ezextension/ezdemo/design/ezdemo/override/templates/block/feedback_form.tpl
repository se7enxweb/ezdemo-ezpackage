{* Feedback form block: the contact form of the block's feedback form object, in a call to action band. The
   fields come from the feedback form's collect templates (datatype/collect/*_feedback_form.tpl), with labels. *}
{def $node = $block.valid_nodes[0]}
{if $node}
<section class="ed-section ed-block ed-block-contact">
    <div class="ed-wrap">
        <div class="ed-cta ed-reveal">
            <div>
                <p class="ed-eyebrow">{$node.name|wash}</p>
                <h2>{$block.name|wash}</h2>
                {if $node.data_map.description.has_content}<div>{attribute_view_gui attribute=$node.data_map.description}</div>{/if}
            </div>
            <form method="post" action={'content/action'|ezurl} class="ed-form-grid">
                {foreach array( 'first_name', 'last_name', 'email', 'subject' ) as $f}
                <div>{attribute_view_gui attribute=$node.data_map[$f] label=$node.data_map[$f].contentclass_attribute.name|wash}</div>
                {/foreach}
                <div class="ed-field-wide">
                    <label>{$node.data_map.country.contentclass_attribute.name|wash}{attribute_view_gui attribute=$node.data_map.country}</label>
                </div>
                <div class="ed-field-wide">{attribute_view_gui attribute=$node.data_map.message label=$node.data_map.message.contentclass_attribute.name|wash}</div>
                <div class="ed-field-wide">
                    <button type="submit" class="ed-btn ed-btn-primary" name="ActionCollectInformation">{'Send message'|i18n( 'design/ezdemo/block/feedback_form' )}</button>
                    <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
                    <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
                    <input type="hidden" name="ViewMode" value="full" />
                </div>
            </form>
        </div>
    </div>
</section>
{/if}
{undef $node}
