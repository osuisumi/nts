<#macro tabFtl items>
	<input type="hidden" name="items" value='${items}'>
	<#assign items_obj = items?eval >
	<#if (items_obj?size > 1)>
		<div id="tag_div" class="mis-mod-tt">
			<div class="mis-crm">
				<div class="crm">
		            <span>当前位置：</span>
		            <a href="###" title="首页"><i class="mis-home-ico"></i></a>
		            <#list items_obj as obj>
		            	<span class="trg">&gt;</span>
		            	<#if (obj_index != (items_obj?size - 1))>
		            		<a onclick="return_prev_content(this)" href="###" class="tag_name">${obj }</a>
		            	<#else>
		            		<em>${obj }</em>
		            	</#if>
			        </#list>
		        </div>
		    </div>
	    </div>
	<#else>
		<div class="mis-mod-tt">
		    <h2 class="tt t1"><span>
		    	${items_obj[0] }
		    </span></h2>
		</div>
	</#if>
</#macro>