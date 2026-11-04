<div class="content-view-full">
    <div class="class-silverlight">

    <div class="attribute-header">
        <h1>{$node.name|wash()}</h1>
    </div>

    <div class="attribute-long">
        {attribute_view_gui attribute=$node.data_map.description}
    </div>

    {def $attribute = $node.data_map.file
         $width = '1'
	 $height = '1'}

    {if $attribute.content.width|gt( 0 )}
        {set $width = $attribute.content.width}
    {/if}

    {if $attribute.content.height|gt( 0 )}
        {set $height = $attribute.content.height}
    {/if}

    {ezscript( array( 'ezdemo_actions.js' ) )}

    <div id="silverlightControlHost">
      <!-- Silverlight plug-in control -->
        <object data="data:application/x-silverlight," type="application/x-silverlight-2-b2" width="{$width}" height="{$height}" data-ezdemo-silverlight-autosize="1">
            <param name="source" value="{concat( "content/download/", $attribute.contentobject_id, "/", $attribute.content.contentobject_attribute_id, "/", $attribute.content.original_filename)|ezurl( 'no' )}" />
            <param name="onError" value="onErrorHandler" />
            <param name="onLoad" value="onLoadHandler" />
            <param name="onResize" value="onResizeHandler" />
            <a href="http://go2.microsoft.com/fwlink/?LinkId=108181">
                <img src="http://go2.microsoft.com/fwlink/?LinkId=108181" alt="Get Microsoft Silverlight" />
            </a>
        </object>
        <iframe class="ed-hidden-frame" title="" hidden="hidden"></iframe>
    </div>

    </div>
</div>
