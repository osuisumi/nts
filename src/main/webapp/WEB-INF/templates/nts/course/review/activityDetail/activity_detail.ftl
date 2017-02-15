<#assign cid=cid/>
<@activityDirective id=activityId!>
	<div style="text-align: center">${activity.title!}</div>
<#if activity.type == 'video'>
	<#import "video_detail.ftl" as videoFtl />
	<@videoFtl.content activity=activity />
<#elseif activity.type == 'html'>
	<#import "html_detail.ftl" as htmlFtl />
	<@htmlFtl.content activity=activity />
<#elseif activity.type == 'discussion'>
	<#import "discussion_detail.ftl" as discussionFtl />
	<@discussionFtl.content activity=activity />
<#elseif activity.type == 'survey'>
	<#import "survey_detail.ftl" as surveyFtl />
	<@surveyFtl.content activity=activity />
<#elseif activity.type == 'test'>
	<#import "test_detail.ftl" as testFtl />
	<@testFtl.content activity=activity />
<#elseif activity.type == 'assignment'>
	<#import "assignment_detail.ftl" as assignmentFtl />
	<@assignmentFtl.content activity=activity cid=cid />
<#else>
</#if>
<div class="splitLine"><span>活动设置</span></div>
<ul>
	<li>
		<span class="key">活动时间:</span><span class="value">
			<#if activity.timePeriod??>
				${(activity.timePeriod.startTime?string(" yyyy-MM-dd"))!}至${(activity.timePeriod.endTime?string(" yyyy-MM-dd"))!}
			</#if>
		</span>
	</li>
	<li><span class="key">活动标签:</span><span id="atag" class="value"></span></li>
</ul>

<script>
	$(function(){
		$('.splitLine').css('line-height','25px').css('background-color','#cccccc');
		$.get('/tags','relation.id=${activityId}',
			function(data) {
				if (data != null) {
					var $tag_lst = $("#atag");
					$.each(data, function(i, tag) {
							$tag_lst.append(tag.name + ' ');
					});
				}
		});
	})
</script>
</@activityDirective>