<#macro content activity>
	<@video id=activity.entityId!>
		<div class="splitLine"><span>基本信息</span></div>
		<ul id="videoUl">
			<li><span class="key">视频标题:</span><span class="value">${video.title!}</span></li>
			<li><span class="key">视频文件:</span>
				<span class="value">
					<#if ('file' == (video.type)!'')>
						<a onclick="previewFile('${video.videoFiles[0].id}')" href="###">${video.videoFiles[0].fileName}</a>
					<#else>
						<a onclick="window.open('${PropertiesLoader.get('video.record.play.domain')}${(video.urlsMap.NR)!}')" href="###">${video.urlsMap.name}</a>
					</#if>
				</span>
			</li>
			<li>
				<span class="key">视频讲义:</span>
				<span class="value">
					<ul style="display: inline-table;">
						<#list video.fileInfos as fileInfo>
							<li><a onclick="downloadFile('${fileInfo.id}', '${fileInfo.fileName }')" href="###">${fileInfo.fileName }</a></li>
						</#list>
					</ul>
				</span>
			</li>
			<li>
				<span class="key">是否允许下载:</span><span class="value">
					${('Y' == (video.allowDownload)!'')?string('是', '否')}
				</span>
			</li>
			<li>
				<span class="key">视频开始时间:</span>
				<span class="value">
				<#if video.startTime??>
					<#list video.startTime?split(",") as stime>
						<#if stime_index == 0 && ('' != (stime)!'')>
							${stime}时,
						<#elseif stime_index == 1 && ('' != (stime)!'')>
							${stime}分,
						<#elseif stime_index == 2 && ('' != (stime)!'')>
							${stime}秒
						</#if>
					</#list>
				</#if>
				</span>
			</li>
			<li>
				<span class="key">视频结束时间:</span>
				<span class="value">
				<#if video.endTime??>
					<#list video.endTime?split(",") as etime>
						<#if etime_index == 0 && ('' != (stime)!'')>
							${etime}时,
						<#elseif etime_index == 1 && ('' != (stime)!'')>
							${etime}分,
						<#elseif etime_index == 2 && ('' != (stime)!'')>
							${etime}秒
						</#if>
					</#list>
				</#if>
				</span>
			</li>
		</ul>
		<div class="splitLine"><span>完成指标</span></div>
		<div><span class="key">观看时间:</span><span class="value">${(activity.attributeMap.view_time.attrValue)!}</span></div>
	</@video>
	<script>
		$(function(){
			$('#videoUl li').css('line-height','30px');
			$('.key').css('');
			$('.value').css('padding-left','10px');
		})
	</script>
</#macro>
