{* The mail of collected information for a call to action of the ezdemo design: sent to the call to action's recipient,
   the visitor then sees its feedback page.

   On an Exponential kernel with the HTML mail layout (notification.ini [MailSettings] HTMLLayout is the setting that
   came with it) the mail is the kernel's: an HTML part and a plain-text part from content/collectedinfomail_body.tpl
   and design:mail/layout.tpl, each answer shown by its "info" view, as on the result page.
   On an older kernel the mail stays the plain text it always was. *}
{def $ezdemo_html_mail = ezini_hasvariable( 'MailSettings', 'HTMLLayout', 'notification.ini' )}
{* The subject is a mail header, text: the object's name as it is (washed only in the old plain-text mail, as before) *}
{if $ezdemo_html_mail}
{set-block scope=root variable=subject}{"Collected information from %1"|i18n("design/ezdemo/colledtedinfomail",,array($collection.object.name))}{/set-block}
{else}
{set-block scope=root variable=subject}{"Collected information from %1"|i18n("design/ezdemo/colledtedinfomail",,array($collection.object.name|wash))}{/set-block}
{/if}

{set-block scope=root variable=email_receiver}{$object.data_map.recipient.content}{/set-block}

{set-block scope=root variable=redirect_to_node_id}{$object.data_map.feedback_page.content.main_node_id}{/set-block}

{if $ezdemo_html_mail}
{include uri='design:content/collectedinfomail_body.tpl' collection=$collection ci_gui=true()
         ci_title="Collected information from %1"|i18n("design/ezdemo/colledtedinfomail",,array($collection.object.name))
         ci_intro="The following information was collected"|i18n("design/ezdemo/colledtedinfomail")}
{else}

{"The following information was collected"|i18n("design/ezdemo/colledtedinfomail")}:

{section name=Attribute loop=$collection.attributes}
{$Attribute:item.contentclass_attribute_name|wash}:
{$Attribute:item.data_text|wash}


{/section}


{/if}
{undef $ezdemo_html_mail}
