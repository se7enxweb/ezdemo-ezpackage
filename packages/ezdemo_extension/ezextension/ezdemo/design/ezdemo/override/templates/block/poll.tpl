{* Poll block: the question of the poll named by the block's poll_node_id, as a card beside the block name. *}
{def $poll_node = fetch( 'content', 'node', hash( 'node_id', $block.custom_attributes.poll_node_id ) )}
{if $poll_node}
{def $poll_object = $poll_node.object
     $question_attribute = $poll_object.data_map.question}
<section class="ed-section ed-block ed-block-poll">
    <div class="ed-wrap ed-split">
        <div class="ed-reveal">
            <p class="ed-eyebrow">{$block.name|wash}</p>
            <h2>{$question_attribute.content.name|wash}</h2>
            {if $poll_object.data_map.description.has_content}<div class="ed-lead">{attribute_view_gui attribute=$poll_object.data_map.description}</div>{/if}
            <p><a class="ed-more" href={$poll_node.url_alias|ezurl}>{'See the results'|i18n( 'design/ezdemo/block' )}</a></p>
        </div>
        <form class="ed-aside-box ed-reveal" method="post" action={'content/action'|ezurl}>
            <input type="hidden" name="ContentNodeID" value="{$poll_object.main_node_id}" />
            <input type="hidden" name="ContentObjectID" value="{$poll_object.id}" />
            <input type="hidden" name="ViewMode" value="full" />
            <fieldset>
                <legend class="ed-sr">{$question_attribute.content.name|wash}</legend>
                <div class="ed-poll-options">
                {foreach $question_attribute.content.option_list as $index => $option}
                    <label class="radio" for="poll_option_{$question_attribute.id}_{$option.id}"><input type="radio" name="ContentObjectAttribute_data_option_value_{$question_attribute.id}" value="{$option.id}"{if eq( $index, '0' )} checked="checked"{/if} id="poll_option_{$question_attribute.id}_{$option.id}" /> {$option.value|wash}</label>
                {/foreach}
                </div>
            </fieldset>
            <button type="submit" name="ActionCollectInformation" class="ed-btn ed-btn-primary">{'Vote'|i18n( 'design/ezflow/embed/poll' )}</button>
        </form>
    </div>
</section>
{undef $poll_object $question_attribute}
{/if}
{undef $poll_node}
