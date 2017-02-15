<#macro content id>
	<style>
		#videoUl li{line-height: 30px;}
		a:visited, a:visited, a:hover, a:active{
		    color: #0059AB;
		}
	</style>
	<@micCourseContent courseId=id>
		<div id="leadContent" class="easyui-layout" style="width:95%;height:95%">
		<@video id=video_activity.entityId>
			<div data-options="region:'west',title:'微视频',split:true,collapsible:false" style="width:20%">
			<#if video??>
				<ul id="videoUl">
					<li><span class="key">视频名称:</span><span class="value">${video.title!}</span></li>
					<li><span class="key">视频文件:</span>
						<span class="value">
							<#if ('file' == (video.type)!'')>
								<a onclick="previewFile('${(video.videoFiles[0].id)!}')" href="###">${(video.videoFiles[0].fileName)!}</a>
							<#else>
								<a onclick="window.open('${PropertiesLoader.get('video.record.play.domain')}${(video.urlsMap.NR)!}')" href="###">${(video.urlsMap.name)!}</a>
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
				</#if>
			</div>
		</@video>
			<div data-options="region:'center',title:'课程测验'" style="padding:5px;">
				<@testDirective id=test_activity.entityId>
					<@testPackageDirective testPackage=test.testPackage>
						<#if questions??>
							<#list questions as question>
								<div>
									<div class="qTitle">${question.title!}</div>
									<ul>
										<#if question.quesType ='SINGLE_CHOICE' || question.quesType ='MULTIPLE_CHOICE' || question.quesType = 'TRUE_FALSE'>
											<#if question.interactionOptions??>
												<#list question.interactionOptions as interactionOption>
													<#if interactionOption??>
														<li class="choice">
															<#if question.quesType == 'SINGLE_CHOICE' || question.quesType == 'TRUE_FALSE'>
																<input disabled="disabled" type="radio" <#if (question.correctOption!'') ==interactionOption.id>checked="checked"</#if> >${interactionOption.text}
															<#else>
																<#assign isCorrect="false"/>
																<#list question.correctOptions as correctOption>
																	<#if correctOption==interactionOption.id>
																		<#assign isCorrect="true"/>
																	</#if>																		
																</#list>
																<input disabled="disabled" type="checkbox" <#if isCorrect =="true">checked="checked"</#if> >${interactionOption.text}
															</#if>	
														</li>
													</#if>
												</#list>
											</#if>
										</#if>				
									</ul>
								</div>
							</#list>
						</#if>
						<script>
							$(function(){
								$('.qTitle').css('background-color','#cccccc').css('margin-top','10px');
							});
						</script>
					</@testPackageDirective>
					</@testDirective>
			</div>
		    <div data-options="region:'south',split:true,collapsible:false" style="width:10%">
		    	<div style="text-align: center">
					<button onclick="updateCourseState('pass')" type="button" class="easyui-linkbutton">
						<i class="fa fa fa-check"></i> 审核通过
					</button>
					<button onclick="updateCourseState('reject')" type="button" class="easyui-linkbutton">
						<i class="fa fa-times"></i> 审核不通过
					</button>
		    	</div>
		    </div>
		</div>
	</@micCourseContent>
	
	<script>
		function updateCourseState(state){
			var msg = '确定要通过所选课程的审核吗?';
			if(state == 'reject'){
				msg = '确定驳回所选课程的审核吗?'
			}
			$.messager.confirm('确认',msg,function(r){    
			    if (r){    
			    	$('#listCourseForm input[name=state]').remove();
					$.put('${ctx}/manage/course', 'state='+state+'&'+'id=${id}', function(){
						easyui_modal_close('reviewCourseDiv');
						easyui_tabs_update('listCourseForm', 'layout_center_tabs');
					});
			    }    
			}); 
		}
	</script>
</#macro>