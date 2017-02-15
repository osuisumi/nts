<#macro content activity>
	<@textInfo id="${activity.entityId! }">
	<div class="splitLine"><span>基本信息</span></div>
		<ul>
			<li><span class="key">标题:</span><span class="value">${textInfo.title!}</span></li>
			<li><span class="key">内容:</span><span class="value">${textInfo.content!}</span></li>
		</ul>
	<div class="splitLine"><span>完成指标</span></div>
	<div><span class="key">观看次数:</span><span class="value">${(activity.attributeMap.view_num.attrValue)!}</span></div>
	</@textInfo>
	
	<script>
		$('.value').css('padding-left','10px');
	</script>
</#macro>
