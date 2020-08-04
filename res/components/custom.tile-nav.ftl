<#import "theme-lib.tile-macros.ftl" as tileMacros />
<#import "theme-lib.common-functions.ftl" as themes />
<#-- parameter for whether the component displays boards or categories, defaults to boards 
    <#assign displayStyle=getComponentParameter("displayStyle","boards","string") />-->
    <#-- determine the context of the component - can either be community page, category page or board page-->
        <#if coreNode.nodeType?lower_case=="community">
            <#assign qry="SELECT id, title, view_href, topics.count(*), views, description, c_node_image_nav, c_node_icon_nav FROM categories WHERE c_exclude_tiled_nav !=true AND depth=1 ORDER BY position ASC" />
            <#else>
                <#assign qry="SELECT id, title, view_href, topics.count(*), views, description, c_node_image_nav, c_node_icon_nav FROM categories WHERE parent_category.id = '${coreNode.id}' AND c_exclude_tiled_nav !=true ORDER BY position ASC" />
        </#if>

        <#assign nodes=themes.executeLiQLQuery(qry) />
       <#if nodes?size gt 0> 
           <#--  <#if displayStyle=="categories"> -->

                <#assign tileLayout=coreNode.settings.name.get("custom.tile_layout", "text" ) />
                <div class="custom-tiled-node-navigation">
                    <section>
                        <h2>${text.format("custom-tiled-node-navigation.title")}</h2>
                        <div>
                            <#list nodes as node>
                                <@tileMacros.displayNodeTile node=node layout=tileLayout />
                            </#list>
<#assign qry="SELECT id, title, view_href, topics.count(*), views, description, c_node_image_nav, c_node_icon_nav FROM boards WHERE parent_category.id = '${coreNode.id}' AND c_exclude_tiled_nav !=true ORDER BY position ASC" />
                        <#assign subnodes=themes.executeLiQLQuery(qry) />
                        <#if subnodes?size gt 0>
                                    <#list subnodes as node>
                                            <@tileMacros.displayNodeTile node=node layout=tileLayout />
                                        </#list>
                        </#if>


                        </div>
                    </section>
                </div>
           <#else> 
                    <#-- if no catoegires found list boards -->
	                        <#assign qry="SELECT id, title, view_href, topics.count(*), views, description, c_node_image_nav, c_node_icon_nav FROM boards WHERE parent_category.id = '${coreNode.id}' AND c_exclude_tiled_nav !=true ORDER BY position ASC" />
	                        <#assign subnodes=themes.executeLiQLQuery(qry) />
	                        <#if subnodes?size gt 0>
                            <#assign tileLayout=coreNode.settings.name.get("custom.tile_layout", "text" ) />
	                            <div class="custom-tiled-node-navigation">
	                                <section>
	                                    <h2>${text.format("custom-tiled-node-navigation.title")}</h2>
	                                    <div>
	                                        <#list subnodes as node>
	                                            <@tileMacros.displayNodeTile node=node layout=tileLayout />
                                        </#list>
	                                    </div>
                                </section>
	                            </div>
                        </#if>  

                        
               </#if> 
