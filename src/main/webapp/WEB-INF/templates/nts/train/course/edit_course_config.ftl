<form id="saveCourseConfigForm" action="${ctx}/manage/course/${courseRelation.course.id }" method="put">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	
	<@courseDirective id=courseRelation.course.id>
		<#assign course=courseModel>
	</@courseDirective>
	<@trainDirective id=courseRelation.relation.id>
		<#assign train=trainModel>
	</@trainDirective>
	
	<div class="mis-srh-layout">
    	<ul class="mis-ipt-lst">
			<li class="item w1">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>课程名称：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        ${course.title }
	                    </div>
	                </div>
	            </div>
	        </li>
	        <li class="item w1">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>所属培训：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        ${train.name }
	                    </div>
	                </div>
	            </div>
	        </li>
	        <li class="item w1">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>课程类型：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        ${DictionaryUtils.getEntryName('COURSE_TYPE',course.type) }
	                    </div>
	                </div>
	            </div>
	        </li>
	        <li class="item w1">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>学时：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input style="width: 100px" type="text" name="studyHours" value="${(course.studyHours)!}" placeholder="请输入学时..." class="mis-ipt {required:true, number:true}">
	                    </div>
	                </div>
	            </div>
	        </li>
        	<li class="item item-twoIpu" id="courseTimeTr">
                <div class="mis-ipt-row">
                    <div class="tl">
                        <span>课程开放时间：</span>
                    </div>
                    <div class="center">
                        <div class="tc">
                            <div class="mis-ipt-mod">
                                <input name="startTime" type="text" value="${(course.timePeriod.startTime?string("yyyy-MM-dd"))!}" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="mis-ipt required">
                            </div>
                        </div>
                        <span class="to">至</span>
                        <div class="tc">
                            <div class="mis-ipt-mod">
                                <input name="endTime" type="text" value="${(course.timePeriod.endTime?string("yyyy-MM-dd"))!}" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="mis-ipt required" >
                            </div>
                        </div>                                            
                    </div>
                </div>
            </li>
		</ul>
		<div class="mis-btn-row indent1">
            <button onclick="saveCourse()" type="button" class="mis-btn mis-main-btn"><i class="mis-save-ico"></i>保存</button>
        </div>
	</div>
</form>
<script type="text/javascript">
	function saveCourse() {
		if(!$('#saveCourseConfigForm').validate().form()){
			return false;
		}
		var data = $.ajaxSubmit('saveCourseConfigForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			alert("操作成功！", function() {
				easyui_tabs_update('listCourseForm','layout_center_tabs')
				easyui_modal_close('editCourseConfigDiv');
			});
		}
	}
</script>