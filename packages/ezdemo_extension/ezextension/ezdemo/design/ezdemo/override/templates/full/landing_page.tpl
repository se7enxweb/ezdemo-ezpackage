{* Landing page: its ezflow zones and blocks; the page has no other frame (pagelayout: ed-main-full). *}
<div class="content-view-full class-landing-page">
    <h1 class="ed-sr">{$node.name|wash}</h1>
    {attribute_view_gui attribute=$node.object.data_map.page}
</div>
