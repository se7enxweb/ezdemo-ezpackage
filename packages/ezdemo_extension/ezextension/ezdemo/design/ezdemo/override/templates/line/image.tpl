{* Image - Line view: a tile. *}
<a class="ed-tile" href={$node.url_alias|ezurl}>{include uri='design:parts/ezdemo/image.tpl' node=$node alias='ezdemo_card'}<span class="ed-tile-caption">{$node.name|wash}</span></a>
