<#-----
 
Creates a horizontal navigation component for desktop. At smaller view ports the slide out menu will be used instead. The component supports
between 1 - 3 levels of nesting. See documentation for visual examples.
 
Options:
   depth = [number] the levels of community structure to be shown in the nav
   communityLink = [true/false] show a community home link
 
-->
 
<#-- include macros -->
<#include "theme-lib.common-functions.ftl" />
 
<@compress single_line=true>
 
   <#assign depth = env.context.component.getParameter("depth")!"2" />
   <#if depth?is_number && depth?number gt 0>
       <#if depth?number gt 3>
           <#assign depth = 3>
       </#if>
   </#if>
   <#assign communityLink = env.context.component.getParameter("communityLink")!"true" />
 
   <#assign liql_query = "SELECT id, view_href, title, short_title, node_type FROM nodes WHERE depth=1 AND hidden=false ORDER BY position ASC" />
   <#assign tlc = executeLiQLQuery(liql_query) />
 
   <nav id="header-horizontal-nav" class="horizontal-nav">
       <div class="slide-out-menu">
           <#if communityLink == "true">
               <ul class="custom-sub-nav">
                   <li role="presentation" class="community-link"><a class="top-level-link" role="menuitem" href="/" aria-label="${text.format("general.Community")}"><span>${text.format("general.Community")}</span></a></li>
               </ul>
           </#if>
       </div>
                  <#--
       <ul class="custom-sub-nav visible-lg-block" role="menubar">
           <#if communityLink == "true">
               <li role="presentation" class="community-link"><a class="top-level-link" role="menuitem" href="/" aria-label="${text.format("general.Community")}"><span>${text.format("general.Community")}</span></a></li>
           </#if>

           <#list tlc as nav>
               <#assign hasChildren = false>
               <#if depth?number gt 1>
               <#assign query = "SELECT count(*) FROM nodes WHERE parent.id = '${nav.id}' AND hidden=false" />
               <#assign nodeCount = executeLiQLQuery(query, true) />
               <#if nodeCount gt 0>
                       <#assign hasChildren = true>
                   </#if>
               </#if>
               <li role="presentation" <#if hasChildren>class="has-children"</#if>>
                   <a role="menuitem" class="top-level-link menuitem" aria-haspopup="true" href="${nav.view_href}" aria-label="${(nav.title)!""}" tabindex="0"><#if (nav.short_title)??>${nav.short_title}<#else>${nav.title}</#if></a>
                   <#if depth?number gt 1 && hasChildren>
                       <ul class="header-sub-nav">
                           <#assign liql_query1 = "SELECT short_title, title, view_href, id FROM nodes WHERE depth=2 AND parent.id='${nav.id}' AND hidden=false ORDER BY position ASC" />
                           <#assign subCats = executeLiQLQuery(liql_query1) />
 
                           <#list subCats as subcat>
                               <li class="depth2">
                                   <a href="${subcat.view_href}" role="menuitem" class="nav-category selectable-link" aria-label="${(subcat.title)!""}" tabindex="0"><#if (subcat.short_title)??>${subcat.short_title}<#else>${subcat.title}</#if></a>
                                   <#if depth?number gt 2>
                                       <#assign liql_query3 = "SELECT short_title, title, view_href, id FROM nodes WHERE depth=3 AND parent.id='${subcat.id}' AND hidden=false ORDER BY position ASC" />
                                       <#assign depth3SubCats = executeLiQLQuery(liql_query3) />
                                       <#if depth3SubCats?size gt 0>
                                           <#list depth3SubCats as catItem>
                                               <li role="presentation" class="depth3">
                                                   <a href="${catItem.view_href}" role="menuitem" class="nav-category selectable-link" aria-label="(catItem.short_title)!""}" tabindex="0"><#if (catItem.short_title)??>${catItem.short_title}<#else>${catItem.title}</#if></a>
                                               </li>
                                           </#list>
                                       </#if>
                                   </#if>
                               </li>
                           </#list>
                       </ul>
                   </#if>
               </li>
           </#list>
  -->
       </ul>
   </nav>
</@compress>

