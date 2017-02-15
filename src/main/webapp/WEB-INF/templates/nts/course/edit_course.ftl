<form id="saveCourseForm" action="${ctx}/manage/course" method="post">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	
	<#if (course.id)??>
		<script>
			$('#saveCourseForm').attr('method','put').attr('action', '${ctx }/manage/course/${(course.id)!}');
		</script>
		<#else>
		<input type="hidden" name="isTemplate" value="Y">
		<input type="hidden" name="state" value="editing">
	</#if>
	
	<div class="mis-srh-layout">
    	<ul class="mis-ipt-lst">
			<li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>课程名称：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="text" name="title" value="${(course.title)!}" placeholder="请输入课程名称..." class="mis-ipt required">
	                    </div>
	                </div>
	            </div>
	        </li>
	        <li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>课程机构：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="text" name="organization" value="${(course.organization)!}" placeholder="请输入课程机构..." class="mis-ipt required">
	                    </div>
	                </div>
	            </div>
	        </li>
	        <li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>学时：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="text" name="studyHours" value="${(course.studyHours)!}" placeholder="请输入学时..." class="mis-ipt {required:true, number:true}">
	                    </div>
	                </div>
	            </div>
	        </li>
	        <li class="item w1">
                <div class="mis-ipt-row">
                    <div class="tl">
                        <span>计划开课学期：</span>
                    </div>
                    <div class="tc">
                        <div class="mis-select">
                            <select id="yearSelect" name="year" style="width: 200px;">
                                <option value="" selected="selected">请选择年份...</option>
                            </select>
                            <script>
								$(function(){
									var d = new Date();
									var year = d.getFullYear();
									for(var i = year; i < year + 2; i++){
										$('#yearSelect').append('<option value="'+i+'">'+i+'</option>');
									}
									$('#yearSelect').find('option[value="${(course.year)!}"]').prop('selected',true);
								});
							</script>    
							<select id="termSelect" name="term" style="width: 200px;">
								<option value="" selected="selected">请选择期次...</option>
	                        </select>
	                        <script>
								$(function(){
									var max = "${DictionaryUtils.getEntryValue('COURSE_EXTEND_ATTRIBUTE', '最大期次')}";
									for(var i=1; i<=parseInt(max); i++){
										$('#termSelect').append('<option value="T'+i+'">T'+i+'</option>');
									}
									$('#termSelect').find('option[value="${(course.term)!}"]').prop('selected',true);
								});
							</script>
                        </div>
                    </div>
                </div>
            </li>
	        <#if !(course.id)??>
	        	<li class="item w1">
	                <div class="mis-ipt-row">
	                    <div class="tl">
	                        <span>课程类型：</span>
	                    </div>
	                    <div class="tc">
	                        <div class="mis-select">
	                            <select name="type" value="${(course.type)!}" style="width: 200px;" onchange="
	                            	var value = $(this).val();
									if(value == 'lead'){
										$('#courseTimeTr').show();
									}else{
										$('#courseTimeTr').hide();
									}
	                            ">
	                                ${DictionaryUtils.getEntryOptionsSelected('COURSE_TYPE', (course.type)!) }
	                            </select>    
	                        </div>
	                    </div>
	                </div>
	            </li>
	        </#if>
	        <#if 'N' == (course.isTemplate)!''>
	        	<li class="item item-twoIpu" id="courseTimeTr" <#if (course.id)?? && ('lead' != (course.type)!'')>style="display:none;"</#if>>
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
	    	</#if>
		</ul>
		<div class="mis-btn-row indent1">
            <button onclick="saveCourse()" type="button" class="mis-btn mis-main-btn"><i class="mis-save-ico"></i>保存</button>
        </div>
	</div>
</form>
<script type="text/javascript">
	function saveCourse() {
		if(!$('#saveCourseForm').validate().form()){
			return false;
		}
		var data = $.ajaxSubmit('saveCourseForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			alert("操作成功！", function() {
				easyui_tabs_update('listCourseForm','layout_center_tabs')
				easyui_modal_close('editCourseDiv');
			});
		}
	}
</script>