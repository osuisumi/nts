<#macro content activity>
	<@discussion id="${activity.entityId! }">
		<div class="splitLine"><span>基本信息</span></div>
		<div><span class="key">研讨主题:</span><span class="value">${discussion.title!}</span></div>
		<div>
			<span class="key">主题描述:</span>
			<div class="ueContent">${(discussion.content)!}</div>
		</div>
		<div>
			<div class="splitLine"><span>完成指标</span></div>
			<ul id="reply">
				<li><span class="key">回复数:</span><span class="value">${(activity.attributeMap.main_post_num.attrValue)!}</span></li>
				<li><span class="key">子回复数:</span><span class="value">${(activity.attributeMap.sub_post_num.attrValue)!}</span></li>
			</ul>
		</div>
		
	</@discussion>
	<script>
		$(function(){
			$('.ueContent').css('line-height','26px').css('margin','0 30px 0px 30px').css('color','#a4a4a4').css('font-size','16px');
			
			$('.value').css('padding-left','10px');
		});
	</script>
</#macro>

