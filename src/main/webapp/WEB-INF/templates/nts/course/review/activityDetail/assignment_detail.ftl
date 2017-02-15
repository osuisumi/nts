<#macro content activity cid>
	<@assignment id=(activity.entityId)!''> 
		<div class="splitLine"><span>基本信息</span></div>
		<div><span class="key">作业标题:</span><span class="value">${(assignment.title)!}</span></div>
		<div>
			<span class="key">作业描述:</span>
			<div class="ueContent">${(assignment.content)!}</div>
		</div>
		<div>
			<span class="key">附件:</span>
			<span class="value">
				<#list assignment.fileInfos as file>
					${file.fileName!}&nbsp;&nbsp;
				</#list>
			</span>
		</div>
		<@assignmentRelation assignmentId=(activity.entityId)!'' relationId=cid>
		<div class="splitLine"><span>作答设置</span></div>
		<ul>
			<li><span class="key">作答时间:</span><span class="value">${(assignmentRelation.responseTime.startTime?string(" yyyy-MM-dd"))!}至${(assignmentRelation.responseTime.endTime?string(" yyyy-MM-dd"))!}</span></li>
			<li>
				<span class="key">作答方式:</span>
				<span class="value">
					<#if assignment.responseType == 'upload'>
						附件上传
					</#if>
				</span>
			</li>
			<li><span class="key">允许的文件格式:</span><span class="value">${(assignment.uploadResponseConfig.fileTypes)!}</span></li>
			<li><span class="key">文件大小限制(MB):</span><span class="value">${(assignment.uploadResponseConfig.fileSize)!}</span></li>
		</ul>
		<div class="splitLine"><span>批改设置</span></div>
		<ul>
			<li><span class="key">批阅时间:</span><span class="value">${(assignmentRelation.markTime.startTime?string(" yyyy-MM-dd"))!}至${(assignmentRelation.markTime.endTime?string(" yyyy-MM-dd"))!}</span></li>
			<li>
				<span class="key">批阅方式:</span>
				<span class="value">
					<#if assignment.markType == 'each_other'>
						学员互评
					<#else>
						教师批阅
					</#if>
				</span>
			</li>
			<#if assignment.markType == 'each_other'>
				<li><span class="key">互评分比重(%):</span><span class="value">${(assignment.eachOtherMarkConfig.markScorePct)!}</span></li>
				<li><span class="key">互评数:</span><span class="value">${(assignment.eachOtherMarkConfig.markNum)!}</span></li>
			</#if>
		</ul>
		</@assignmentRelation>
		<div class="splitLine"><span>评分项设置</span></div>
		<@evaluateRelation relationId=assignment.id type="assignment">
			<#assign evaluate=evaluateRelation.evaluate>
			<ul>
				<#list evaluate.evaluateItems as evaluateItem>
					<li>${evaluateItem.content }</li>
				</#list>
			</ul>
		</@evaluateRelation>
	</@assignment>
	
	<script>
		$('.ueContent').css('line-height','26px').css('margin','0 30px 0px 30px').css('color','#a4a4a4').css('font-size','16px').css('width','90%').css('height','40%').css('overflow','scroll');
		$('.value').css('padding-left','10px');
	</script>
</#macro>

