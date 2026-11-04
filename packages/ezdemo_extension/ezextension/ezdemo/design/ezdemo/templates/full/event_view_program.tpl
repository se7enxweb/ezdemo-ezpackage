{* Event Calendar - Full Program view *}
{def
    $event_node = $node.node_id
    $curr_ts = currentdate()
    $curr_today = $curr_ts|datetime( custom, '%j')
    $curr_year = $curr_ts|datetime( custom, '%Y')
    $curr_month = $curr_ts|datetime( custom, '%n')
    $temp_oldest_event = ''
    $temp_newest_event = ''

    $temp_offset = cond( ne($view_parameters.offset, ''), $view_parameters.offset, 0)
    $daymode = false()
    $direction = ""
    $newer_event_count = fetch( 'content', 'list_count', hash(
            'parent_node_id', $event_node,
            'class_filter_type',  'include',
            'class_filter_array', array( 'event' ),
               'attribute_filter',    array( 'or',
                    array( 'event/from_time', '>=', $curr_ts  ),
                    array( 'event/to_time', '>=', $curr_ts  )
            )    ))
    $older_event_count = fetch( 'content', 'list_count', hash(
            'parent_node_id', $event_node,
            'class_filter_type',  'include',
            'class_filter_array', array( 'event' ),
               'attribute_filter',
            array( 'and', array( 'event/from_time', '<', $curr_ts  ),
                    array( 'event/to_time', '<', $curr_ts  )
            )    ))
}
{if ge($temp_offset,0)}
{set $temp_offset = $temp_offset|abs}
{def $events = fetch( 'content', 'list', hash(
            'parent_node_id', $event_node,
            'sort_by', array( 'attribute', true(), 'event/from_time' ),
            'class_filter_type',  'include',
            'class_filter_array', array( 'event' ),
            'limit', 15,
            'offset', $temp_offset|mul(15),
            'attribute_filter', array( 'or',
                    array( 'event/from_time', '>=', $curr_ts  ),
                    array( 'event/to_time', '>=', $curr_ts  )
            )    ))
}
{set $newer_event_count = $newer_event_count|sub( 15|mul( $temp_offset|inc ) )}
{else}
{set $temp_offset = $temp_offset|abs|dec
     $direction = "-"}
{def $events = fetch( 'content', 'list', hash(
            'parent_node_id', $event_node,
            'sort_by', array( 'attribute', true(), 'event/from_time' ),
            'class_filter_type',  'include',
            'class_filter_array', array( 'event' ),
            'limit', 15,
            'offset', $temp_offset|mul(15),
            'attribute_filter', array( 'and',
                    array( 'event/from_time', '<', $curr_ts  ),
                    array( 'event/to_time', '<', $curr_ts  )
            )))
}
{set $older_event_count = $older_event_count|sub( 15|mul( $temp_offset|inc ) )}
{/if}

{foreach $events as $event}
{if or(eq($temp_newest_event,''),gt($event.object.data_map.from_time.content.timestamp, $temp_newest_event))}
    {set $temp_newest_event=$event.object.data_map.from_time.content.timestamp}
{/if}
{if or(eq($temp_oldest_event,''),lt($event.object.data_map.from_time.content.timestamp, $temp_oldest_event))}
    {set $temp_oldest_event=$event.object.data_map.from_time.content.timestamp}
{/if}
{/foreach}

{if eq($temp_oldest_event|datetime(custom,"%M"),  $temp_newest_event|datetime(custom,"%M"))}
{set $daymode=true()}
{/if}

<div class="content-view-full class-event-calendar event-calendar-programview">
<header class="ed-page-head">
    <p class="ed-eyebrow">{'Program'|i18n( 'design/ezdemo/full/event_view_program' )}</p>
    <h1>{$node.name|wash()}</h1>
    <p class="ed-lead">{'Webinars, workshops and meetups. Add one to your calendar or join us live.'|i18n( 'design/ezdemo/full/event_view_program' )}</p>
</header>
<div class="ed-rows">
    {foreach $events as $event}
        {node_view_gui view='line' content_node=$event}
    {/foreach}
</div>
<nav class="ed-pager" aria-label="{'Events'|i18n( 'design/ezdemo/full/event_view_program' )}">
{if $direction}{* '-' direction  *}
    <div class="left">
    {if $older_event_count|gt(0)}
        <a href={concat("/content/view/full/",  $node.node_id, "/offset/-", $temp_offset|sum(2))|ezurl}>&lt;&lt; {"Past events"|i18n("design/ezdemo/full/event_view_program")}</a>
    {/if}
    </div>
    <div class="right">
    {if $temp_offset|gt(0)}
        <a href={concat("/content/view/full/",  $node.node_id, "/offset/-", $temp_offset)|ezurl}>{"Future events"|i18n("design/ezdemo/full/event_view_program")} &gt;&gt;</a>
    {elseif $newer_event_count|gt(0)}
        <a href={concat("/content/view/full/",  $node.node_id, "/offset/0")|ezurl}>{"Future events"|i18n("design/ezdemo/full/event_view_program")} &gt;&gt;</a>
    {/if}
    </div>
{else}
    <div class="left">
    {if $temp_offset|gt(0)}
        <a href={concat("/content/view/full/",  $node.node_id, "/offset/", $temp_offset|dec)|ezurl}>&lt;&lt; {"Past events"|i18n("design/ezdemo/full/event_view_program")}</a>
    {elseif $older_event_count|gt(0)}
        <a href={concat("/content/view/full/",  $node.node_id, "/offset/-1")|ezurl}>&lt;&lt; {"Past events"|i18n("design/ezdemo/full/event_view_program")}</a>
    {/if}
    </div>
    <div class="right">
    {if $newer_event_count|gt(0)}
        <a href={concat("/content/view/full/",  $node.node_id, "/offset/", $temp_offset|inc)|ezurl}>{"Future events"|i18n("design/ezdemo/full/event_view_program")} &gt;&gt;</a>
    {/if}
    </div>
{/if}
</nav>
{undef}
</div>
