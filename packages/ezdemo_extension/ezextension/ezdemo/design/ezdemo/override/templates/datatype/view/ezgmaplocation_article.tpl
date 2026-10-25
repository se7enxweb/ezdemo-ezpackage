{* Make sure to normalize floats from db  *}
{def $latitude  = $attribute.content.latitude|explode(',')|implode('.')
     $longitude = $attribute.content.longitude|explode(',')|implode('.')}
{run-once}
<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor={ezini('GMapSettings', 'UseSensor', 'ezgmaplocation.ini')}"></script>
{/run-once}

{if $attribute.has_content}
{ezscript( array( 'ezdemo_actions.js' ) )}
<div id="ezgml-map-{$attribute.id}" data-ezdemo-gmap-id="{$attribute.id}" data-ezdemo-gmap-lat="{first_set( $latitude, '0.0')|wash}" data-ezdemo-gmap-lng="{first_set( $longitude, '0.0')|wash}" style="width: 100%; height: 330px;">
{/if}
