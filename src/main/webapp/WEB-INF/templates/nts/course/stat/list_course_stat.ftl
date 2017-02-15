<form id="listCourseStatForm" action="${ctx}/manage/course_stat"  method ="get">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<div class="mis-srh-layout">
	    <ul class="mis-ipt-lst">
	    	<li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>课&nbsp;程&nbsp;名：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="text" name="title" value="${(course.title)!}" placeholder="请输入课程名..." class="mis-ipt">
	                    </div>
	                </div>
	            </div>
	        </li>
	    </ul>
	    <div class="mis-btn-row indent1">
	        <button onclick="easyui_tabs_update('listCourseStatForm','layout_center_tabs');" type="button" class="mis-btn mis-main-btn"><i class="mis-srh-ico"></i>查询</button>
			<a onclick="resetForm(this)"  class="mis-btn mis-default-btn">
				<i class="mis-refresh-ico"></i>重置
			</a>
	    </div>
	</div>
	<div class="mis-table-layout">
	    <div class="mis-opt-row">
	        <div class="mis-opt-mod fl">
	            <button onclick="listStudentCourseStat()" type="button" class="mis-btn mis-inverse-btn"><i class="mis-look-ico"></i>查看学员学习统计</button>
	            <button onclick="listAreaCourseStat()" type="button" class="mis-btn mis-inverse-btn"><i class="mis-look-ico"></i>查看区域统计</button>
	            <button onclick="listSchoolCourseStat()" type="button" class="mis-btn mis-inverse-btn"><i class="mis-look-ico"></i>查看学校统计</button>
	        </div>
	    </div>
	    <div class="mis-table-mod">
	        <table id="listCourseStatTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
	            <thead>
	                <tr>
	                    <th width="50px" data-options="field:'id',checkbox:true">选项</th>
                    	<th data-options="field:'trainName'">培训</th>
	                    <th data-options="field:'title'">课程名称</th>
	                    <th data-options="field:'title'">课程类型</th>
	                    <!--<th data-options="field:'title'">辅导教师</th>-->
	                    <th data-options="field:'code'">选课人数</th>
	                    <th data-options="field:'termNo'">通过率</th>
	                    <th data-options="field:'organization'">视频学习</th>
	                    <th data-options="field:'type'">主题研讨</th>
	                    <th data-options="field:'studyHours'">参与测试</th>
	                    <th data-options="field:'state'">提交作业</th>
	                    <th data-options="field:'isTemplate'">提问数</th>
	                    <th data-options="field:'isTemplate'">回答数</th>
	                    <th data-options="field:'isTemplate'">笔记数</th>
	                    <th data-options="field:'isTemplate'">研讨数</th>
	                    <th data-options="field:'isTemplate'">资源数</th>
	                    <!--<th data-options="field:'isTemplate'">优秀辅导课程</th>-->
	                </tr>
	            </thead>
	            <tbody>
	                <@courseStatsDirective isTemplate='N'   title=(course.title)!'' state=(course.state)!'' page=(pageBounds.page)!1 limit=(pageBounds.limit)!10 orders='CREATE_TIME.DESC'>
	                	<#assign courseStats=courseStats />
						<#assign trainIds = []>
						<#list courseStats as cs>
							<#if '' != (cs.course.courseRelation.relation.id)!''>
								<#assign trainIds = trainIds + [cs.course.courseRelation.relation.id]>
							</#if>
						</#list>
					</@courseStatsDirective>
					<#if (trainIds?size>0)>
						<@trainMapDirective ids=trainIds>
							<#assign trainMap=trainMap>
						</@trainMapDirective>
					</#if>
					
					<#list courseStats as cs>
						<tr>
							<td>${(cs.course.id)!}</td>
							<td>${(trainMap[cs.course.courseRelation.relation.id].name)!}</td>
							<td>${(cs.course.title)!} - ${(cs.course.code)!}</td>
							<td>${DictionaryUtils.getEntryName('COURSE_TYPE', (cs.course.type)!) }</td>
							<!--<td>辅导教师</td>-->
							<td>${(cs.registerNum)!}</td>
							<td>
								<#if (cs.registerNum)?? && (cs.qualifiedNum)?? && (cs.registerNum>0)>
								${(cs.qualifiedNum/cs.registerNum)*100}%
								<#else>
								0%
								</#if>
							</td>
							<td>${(cs.completeVideoNum)!}</td>
							<td>${(cs.completeDiscussionNum)!}</td>
							<td>${(cs.completeTestNum)!}</td>
							<td>${(cs.completeAssignmentNum)!}</td>
							<td>${(cs.faqQuestionNum)!}</td>
							<td>${(cs.faqAnswerNum)!}</td>
							<td>${(cs.noteNum)!}</td>
							<td>${(cs.discussionNum)!}</td>
							<td>${(cs.resourceNum)!}</td>
							<!--<td>优秀辅导课程</td>-->
						</tr>
					</#list>
	            </tbody>
	            <tfoot>
	                <tr>
	                    <td colspan="17">
	                    	 <#if paginator??>
						    	<#import "/nts/include/pagination.ftl" as p/>
						    	<@p.pagination paginator=paginator formId="listCourseStatForm" divId="content"/>
							</#if>
	                    </td>
	                </tr>
	            </tfoot>
	        </table>
	    </div>
	</div>
</form>

<script>
	$(function(){
		$('#listCourseStatTable').datagrid();
	});
	
	function listStudentCourseStat(){
		var row = $('#listCourseStatForm').find('#listCourseStatTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一个课程查看', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时查看多个课程', 'warning');
			return false;
		}else{
			var id = row[0].id;
			easyui_modal_open('statDiv', '查看学员学习统计', 700, 600, '${ctx}/manage/course_stat/student?courseId='+id, true);
		}
	}
	
	function listAreaCourseStat(){
		var row = $('#listCourseStatForm').find('#listCourseStatTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一个课程查看', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时查看多个课程', 'warning');
			return false;
		}else{
			var id = row[0].id;
			easyui_modal_open('statDiv', '查看区域统计', 700, 600, '${ctx}/manage/course_stat/area?courseId='+id, true);
		}
	}
	
	function listSchoolCourseStat(){
		var row = $('#listCourseStatForm').find('#listCourseStatTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一个课程查看', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时查看多个课程', 'warning');
			return false;
		}else{
			var id = row[0].id;
			easyui_modal_open('statDiv', '查看学校统计', 700, 600, '${ctx}/manage/course_stat/school?courseId='+id, true);
		}
	}
	
</script>