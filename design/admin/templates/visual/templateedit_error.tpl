<div class="message-warning">

<h2><span class="time">[{currentdate()|l10n( shortdatetime )}]</span> {'The temple can not be edited.'|i18n( 'design/admin/visual/templateedit' )}</h2>

{section show=$template_exists}
    {section show=$is_readable}
    <p>{'The web server does not have write access to the requested template.'|i18n( 'design/admin/visual/templateedit' )}</p>
    {section-else}
    <p>{'The web server does not have read access to the requested template.'|i18n( 'design/admin/visual/templateedit' )}</p>
    {/section}
{section-else}
    <p>{'The requested template does not exist or is not being used as an override.'|i18n( 'design/admin/visual/templateedit' )}</p>
{/section}

</div>

<form action={concat( 'visual/templateedit/', $template )|ezurl} method="post">

{section show=$original_template}
<input type="hidden" name="RedirectToURI" value="{concat( '/visual/templateview', $original_template )}" />
{section-else}
<input type="hidden" name="RedirectToURI" value="/visual/templatelist" />
{/section}


<div class="context-block">

{* DESIGN: Header START *}<div class="box-header"><div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">

<h1 class="context-title">{'Edit <%template_name> [Template]'|i18n( 'design/admin/visual/templateedit',, hash( '%template_name', $template ) )|wash}</h1>

{* DESIGN: Mainline *}<div class="header-mainline"></div>

{* DESIGN: Header END *}</div></div></div></div></div></div>

{* DESIGN: Content START *}<div class="box-ml"><div class="box-mr"><div class="box-content">

<div class="context-attributes">

<div class="block">
<label>{'Requested template'|i18n( 'design/admin/visual/templateedit' )}:</label>
{$template|wash}
</div>

<div class="block">
<label>{'Siteaccess'|i18n( 'design/admin/visual/templateedit' )}:</label>
{$site_access|wash}
</div>

{section show=$original_template}
<div class="block">
<label>{'Overrides template'|i18n( 'design/admin/visual/templateedit' )}:</label>
<a href={concat( 'visual/templateview', $original_template )|ezurl}>{$original_template|wash}</a>
</div>
{/section}

</div>

{* DESIGN: Content END *}</div></div></div>

<div class="controlbar">
{* DESIGN: Control bar START *}<div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-tc"><div class="box-bl"><div class="box-br">
<div class="block">
<input {section show=or( not( $template_exists ), not( $is_readable ) )}class="button-disabled" disabled="disabled"{section-else}class="button"{/section} type="submit" name="OpenReadOnly" value="{'Open as read only'|i18n( 'design/admin/visual/templateedit' )}" />
<input class="button" type="submit" name="Cancel" value="{'Cancel'|i18n( 'design/admin/visual/templateedit' )}" />
</div>
{* DESIGN: Control bar END *}</div></div></div></div></div></div>
</div>

</div>

</form>
