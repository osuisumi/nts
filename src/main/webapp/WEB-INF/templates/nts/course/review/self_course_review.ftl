<#macro content id>
<@leadCourseContent courseId=id!>
	<div id="leadContent" class="easyui-layout" style="width:95%;height:95%">
		<div data-options="region:'west',title:'课程大章',split:true,collapsible:false" style="width:20%">
			<#if (sections?size>0)>
				<ul class="m-courseSection-lst" id="sectionUl">
					<#list sections as section>
						<li class="sectionLi" sectionId="${section.id!}" >
							<a style="display:block" onclick="showChild('${section.id!}',this)" href="javascript:void(0);" class="section" title="${section.title!}"> <span>${section.title!}</span> </a>
						</li>
					</#list>
				</ul>
			</#if>
		</div> 
		    
	    <div data-options="region:'center',title:'小节、活动'" style="padding:5px;">
			<#if (sections?size>0)>
				<#list sections as section>
					<div sectionId="${section.id!}" id="sectionId_${section.id!}" class="sectionDiv g-section-box" style="display:none">
						<div class="g-section-tt" style="text-align: center">
							开放时间:${(section.timePeriod.startTime?string("yyyy/MM/dd"))!}
						</div>
						<div class="g-section-dt">
							<ul class="m-section-lst" id="courseSectionList">
								<#list section.childSections as childSection>
								<li sectionId="${childSection.id}" >
									<div class="m-section-block childSection">
										<span href="javascript:void(0);" class="tt">${childSection.title!}</span>
									</div>
									<div id="activityUl_${childSection.id}"  class="g-sectionActive-box">
										<@activitiesDirective relationId=childSection.id>
											<#if activities??>
												<#list activities as activity>
													<a class="activityBtn" onclick="loadActivityDetail('${activity.id!}','${id}',this)">
														${activity.title}
														(<#if activity.type == 'video'>
															视频
														<#elseif activity.type == 'html'>
															html
														<#elseif activity.type == 'discussion'>
															主题研讨
														<#elseif activity.type == 'survey'>
															问卷调查
														<#elseif activity.type == 'test'>
															测验
														<#elseif activity.type == 'assignment'>
															作业
														<#else>
														</#if>)
														</a>
												</#list>
											</#if>
										</@activitiesDirective>
									</div>
								</li>
								<br>
								</#list>
							</ul>
						</div>
					</div>
				</#list>
			</#if>
	    </div> 
	    
	    <div data-options="region:'east',title:'活动详情',split:true,collapsible:false" style="width:50%">
	    	<div id="activityDetail"></div>
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
</@leadCourseContent>

<script>
	$(function(){
		//课程大章的样式
		$('.sectionLi').css('line-height','30px').css('border-bottom','1px dashed #dbdde6').css('background-color','#f0f9fd');
		
		//节样式
		$('.childSection').css('line-height','25px').css('background-color','#cccccc');
		
		//活动按钮样式
		$('.activityBtn').css('display','block').css('line-height','20px').css('border-bottom','1px dashed #dbdde6').css('background-color','#f0f9fd').css('cursor','pointer').css('padding-left','20px');
	});

	function showChild(id,a){
		$('.sectionDiv').hide();
		$('#sectionId_'+id).show();
		$('.sectionLi').css('background-color','#f0f9fd');
		$(a).closest('li').css('background-color','#2480d4');
	}
	
	function loadActivityDetail(id,cid,a){
		$('#activityDetail').load('${ctx}/manage/course/activityDetail/'+id,'cid='+cid);
		
		$('.activityBtn').css('background-color','#f0f9fd');
		$(a).css('background-color','#2480d4');
	}
	
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