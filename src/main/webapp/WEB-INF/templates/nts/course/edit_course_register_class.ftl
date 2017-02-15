<form id="updateCourseRegisterClassForm" action="${ctx }/manage/courseRegister/updateCourseRegisterClass" method="put">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<input type="hidden" name="id" value="${(courseRegister.id)! }">
	
	<div class="mis-srh-layout">
    	<ul class="mis-ipt-lst">
    		<li class="item w1">
                <div class="mis-ipt-row">
                    <div class="tl">
                        <span>选择班级：</span>
                    </div>
                    <div class="tc">
                        <div class="mis-select">
                            <select id="classSelect" name="clazz.id" value="${(course.type)!}" style="width: 200px;" class="required">
                            	<@classesDirective courseId=(courseRegister.course.id)! relationId=(courseRegister.relation.id)! pageBounds=pageBounds> 
                            		<option value="" >请选择班级...</option>  
									<#list classes as class>
										<option value="${(class.id)!}" >${(class.name)!}</option>  
									</#list>
								</@classesDirective>
                            </select>    
                        </div>
                    </div>
                </div>
            </li>
        </ul>
        <div class="mis-btn-row indent1">
            <button onclick="updateCourseRegisterClass()" type="button" class="mis-btn mis-main-btn"><i class="mis-save-ico"></i>保存</button>
        </div>
    </div>
</form>
<script type="text/javascript">
	function updateCourseRegisterClass() {
		if(!$('#updateCourseRegisterClassForm').validate().form()){
			return false;
		}
		var data = $.ajaxSubmit('updateCourseRegisterClassForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			alert("设置成功！", function() {
				easyui_tabs_update('listCourseRegisterForm','layout_center_tabs')
				easyui_modal_close('editCourseRegisterClassDiv');
			});
		}
	}
	
</script>