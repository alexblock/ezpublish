{let search=false()}
{section show=$use_template_search}
    {set page_limit=10}
    {switch match=$search_page_limit}
    {case match=1}
        {set page_limit=5}
    {/case}
    {case match=2}
        {set page_limit=10}
    {/case}
    {case match=3}
        {set page_limit=20}
    {/case}
    {case match=4}
        {set page_limit=30}
    {/case}
    {case match=5}
        {set page_limit=50}
    {/case}
    {case/}
    {/switch}
    {set search=fetch(content,search,
                      hash(text,$search_text,
                           section_id,$search_section_id,
                           subtree_array,$search_sub_tree,
                           class_id,$search_contentclass_id,
                           class_attribute_id,$search_contentclass_attribute_id,
                           offset,$view_parameters.offset,
                           limit,$page_limit))}
    {set search_result=$search['SearchResult']}
    {set search_count=$search['SearchCount']}
    {set stop_word_array=$search['StopWordArray']}
    {set search_data=$search}
{/section}

<form action={"/content/advancedsearch/"|ezurl} method="get">
<div class="maincontentheader">
<h1>{"Advanced search"|i18n("design/standard/content/search")}</h1>
</div>

<div class="block">
<label>{"Search all the words"|i18n("design/standard/content/search")}</label><div class="labelbreak"></div>
<input class="box" type="text" size="40" name="SearchText" value="{$full_search_text|wash}" />
</div>
<div class="block">
<label>{"Search the exact phrase"|i18n("design/standard/content/search")}</label><div class="labelbreak"></div>
<input class="box" type="text" size="40" name="PhraseSearchText" value="{$phrase_search_text|wash}" />
</div>
{*<div class="block">
<label>{"Search with at least one of the words"|i18n("design/standard/content/search")}</label><div class="labelbreak"></div>
<input class="box" type="text" size="40" name="AnyWordSearchText" value="" />
</div>*}
<div class="block">

<div class="element">
<label>{"Class"|i18n("design/standard/content/search")}</label><div class="labelbreak"></div>
<select name="SearchContentClassID">
<option value="-1">{"Any class"|i18n("design/standard/content/search")}</option>
{section name=ContentClass loop=$content_class_array }

<option {switch name=sw match=$search_contentclass_id}
{case match=$ContentClass:item.id}
selected="selected"
{/case}
{case}
{/case}
{/switch} value="{$ContentClass:item.id}">{$ContentClass:item.name|wash}</option>

{/section}
</select>

</div>
<div class="element">

<label>{"Class attribute"|i18n("design/standard/content/search")}</label><div class="labelbreak"></div>

{section name=Attribute show=$search_contentclass_id|gt(0)}

<select name="SearchContentClassAttributeID">
<option value="-1">Any attribute</option>
{section name=ClassAttribute loop=$search_content_class_attribute_array}
<option value="{$Attribute:ClassAttribute:item.id}" 
        {section show=eq($search_contentclass_attribute_id,$Attribute:ClassAttribute:item.id)}
            selected="selected"
        {/section}>{$Attribute:ClassAttribute:item.name|wash}</option>
{/section}
</select>

&nbsp;

{/section}
<input class="smallbutton" type="submit" name="SelectClass" value="{'Update attributes'|i18n('design/standard/content/search')}"/>
</div>

<div class="break"></div>
</div>
<div class="block">
<div class="element">

<label>{"In"|i18n("design/standard/content/search")}</label><div class="labelbreak"></div>
<select name="SearchSectionID">
<option value="-1">{"Any section"|i18n("design/standard/content/search")}</option>
{section name=Section loop=$section_array }
<option {switch name=sw match=$search_section_id}
     {case match=$Section:item.id}
selected="selected"
{/case}
{case}
{/case}
{/switch} value="{$Section:item.id}">{$Section:item.name|wash}</option>
{/section}
</select>

</div>
<div class="element">

<label>{"Published"|i18n("design/standard/content/search")}</label><div class="labelbreak"></div>
<select name="SearchDate">
<option value="-1" {section show=eq($search_date,-1)}selected="selected"{/section}>{"Any time"|i18n("design/standard/content/search")}</option>
<option value="1" {section show=eq($search_date,1)}selected="selected"{/section}>{"Last day"|i18n("design/standard/content/search")}</option>
<option value="2" {section show=eq($search_date,2)}selected="selected"{/section}>{"Last week"|i18n("design/standard/content/search")}</option>
<option value="3" {section show=eq($search_date,3)}selected="selected"{/section}>{"Last month"|i18n("design/standard/content/search")}</option>
<option value="4" {section show=eq($search_date,4)}selected="selected"{/section}>{"Last three months"|i18n("design/standard/content/search")}</option>
<option value="5" {section show=eq($search_date,5)}selected="selected"{/section}>{"Last year"|i18n("design/standard/content/search")}</option>
</select>
</div>

{section show=$use_template_search}
<div class="element">
<label>{"Display per page"|i18n("design/standard/content/search")}</label><div class="labelbreak"></div>
<select name="SearchPageLimit">
<option value="1" {section show=eq($search_page_limit,1)}selected="selected"{/section}>{"5 items"|i18n("design/standard/content/search")}</option>
<option value="2" {section show=or(array(1,2,3,4,5)|contains($search_page_limit)|not,eq($search_page_limit,2))}selected="selected"{/section}>{"10 items"|i18n("design/standard/content/search")}</option>
<option value="3" {section show=eq($search_page_limit,3)}selected="selected"{/section}>{"20 items"|i18n("design/standard/content/search")}</option>
<option value="4" {section show=eq($search_page_limit,4)}selected="selected"{/section}>{"30 items"|i18n("design/standard/content/search")}</option>
<option value="5" {section show=eq($search_page_limit,5)}selected="selected"{/section}>{"50 items"|i18n("design/standard/content/search")}</option>
</select>
</div>
{/section}

<div class="break"></div>
</div>

<div class="buttonblock'">
<input class="button" type="submit" name="SearchButton" value="{'Search'|i18n('design/standard/content/search')}" />
</div>


{section show=$search_text}
<br/>
{switch name=Sw match=$search_count}
  {case match=0}
<div class="warning">
<h2>{'No results were found when searching for "%1"'|i18n("design/standard/content/search",,array($search_text|wash))}</h2>
</div>
  {/case}
  {case}
<div class="feedback">
<h2>{'Search for "%1" returned %2 matches'|i18n("design/standard/content/search",,array($search_text|wash,$search_count))}</h2>
</div>
  {/case}
{/switch}

{include name=Result
         uri='design:content/searchresult.tpl'
         search_result=$search_result}
{/section}

{include name=navigator
         uri='design:navigator/google.tpl'
         page_uri=concat('/content/advancedsearch')
         page_uri_suffix=concat('?SearchText=',$search_text|urlencode,'&PhraseSearchText=',$phrase_search_text|urlencode,'&SearchContentClassID=',$search_contentclass_id,'&SearchContentClassAttributeID=',$search_contentclass_attribute_id,'&SearchSectionID=',$search_section_id,$search_timestamp|gt(0)|choose('',concat('&SearchTimestamp=',$search_timestamp)),$search_sub_tree|gt(0)|choose( '', concat( '&SubTreeArray[]=', $search_sub_tree|implode( '&SubTreeArray[]=' ) ) ),'&SearchDate=',$search_date,'&SearchPageLimit=',$search_page_limit)
         item_count=$search_count
         view_parameters=$view_parameters
         item_limit=$page_limit}

</form>
{/let}
