<!-- <#if type == 'lead'>
	<#import "lead_course_review.ftl" as lead />
	<@lead.content id=id />
<#elseif type == 'mic'>
	<#import "mic_course_review.ftl" as mic />
	<@mic.content id=id />
<#else>
	<#import "self_course_review.ftl" as self />
	<@self.content id=id />
</#if> -->
<#import "/nts/include/tab.ftl" as tab/>
<@tab.tabFtl items=items[0] />
	
<div class="mis-column-intl">
	<h2>请查看课程内容后, 再提交审核, 审核通过后课程将发布到培训平台. 不通过则通知制作教师重新制作内容</h2>
	<div class="mis-opt-mod fr">
		<button onclick="updateCourseState('reject')"  type="button" class="mis-btn mis-Ounpass-btn"><i class="mis-unpass-ico"></i>不通过</button>
        <button onclick="updateCourseState('pass')" type="button" class="mis-btn mis-main-btn"><i class="mis-pass-ico"></i>通过</button>
	</div>
</div>
<div style="padding: 30px;">
	<iframe src="${PropertiesLoader.get('ncts.domain')}course/${id }/preview" width="100%" height="800px">
	
	</iframe>
</div>
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
				alert('提交成功',function(){
					easyui_modal_close('reviewCourseDiv');
					easyui_tabs_update('listCourseForm', 'layout_center_tabs');
				});
			});
	    }    
	}); 
}
</script>