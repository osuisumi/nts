<form id="listCourseForm" action="${ctx}/manage/train/course"  method ="get">
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
	        <li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>状态：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-select">
	                        <select name="state" id="">
	                            <option value="">请选择...</option>
								${DictionaryUtils.getEntryOptionsSelected('COURSE_STATE', (course.state)!) }
	                        </select>    
	                    </div>
	                </div>
	            </div>
	        </li>
	    </ul>
	    <div class="mis-btn-row indent1">
	        <button onclick="easyui_tabs_update('listCourseForm','layout_center_tabs');" type="button" class="mis-btn mis-main-btn"><i class="mis-srh-ico"></i>查询</button>
			<a onclick="resetForm(this)"  class="mis-btn mis-default-btn">
				<i class="mis-refresh-ico"></i>重置
			</a>
	    </div>
	</div>
	<div class="mis-table-layout">
	    <div class="mis-opt-row">
	        <div class="mis-opt-mod fl">
	            <button onclick="editCourseConfig()" type="button" class="mis-btn mis-inverse-btn"><i class="mis-setting-ico"></i>设置开课信息</button>
	            <button onclick="editCourseAuthorize('maker')" type="button" class="mis-btn mis-inverse-btn" id="layerBtn2"><i class="mis-authorization-ico"></i>课程制作授权</button>
	            <!--<button onclick="editCourseAuthorize('assistant')" type="button" class="mis-btn mis-inverse-btn" id="layerBtn2"><i class="mis-authorization-ico"></i>授权辅导教师</button>-->
	            <button onclick="editCourseAuthorize('teacher')" type="button" class="mis-btn mis-inverse-btn" id="layerBtn2"><i class="mis-authorization-ico"></i>授权助学教师</button>
	            <button onclick="listCourseRegister()" type="button" class="mis-btn mis-inverse-btn" id="layerBtn2"><i class="mis-list-ico"></i>选课管理</button>
	            <button onclick="listCourseResult()" type="button" class="mis-btn mis-inverse-btn" id="layerBtn2"><i class="mis-list-ico"></i>成绩管理</button>
	        </div>
	    </div>
	    <div class="mis-table-mod">
	        <table id="listCourseTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
	            <thead>
	                <tr>
	                    <th width="50px" data-options="field:'id',checkbox:true">选项</th>
	                    <th data-options="field:'trueType',hidden:true">
	                    <th data-options="field:'trainId',hidden:true">
	                    <th data-options="field:'title'">课程名</th>
	                    <th data-options="field:'trainName'">培训名</th>
	                    <th data-options="field:'type'">类型</th>
	                    <th data-options="field:'studyHours'">学时</th>
	                    <th data-options="field:'state'">状态</th>
	                    <th data-options="field:'startTime'">开放时间</th>
	                </tr>
	            </thead>
	            <tbody>
	                <@coursesDirective isTemplate='N'  title=(course.title)!'' state=(course.state)!'' page=(pageBounds.page)!1 limit=(pageBounds.limit)!10 orders='CREATE_TIME.DESC'>
						<#assign courses=courses>
						<#assign trainIds = []>
						<#list courses as course>
							<#if '' != (course.courseRelation.relation.id)!''>
								<#assign trainIds = trainIds + [course.courseRelation.relation.id]>
							</#if>
						</#list>
					</@coursesDirective>
					<#if (trainIds?size>0)>
						<@trainMapDirective ids=trainIds>
							<#assign trainMap=trainMap>
						</@trainMapDirective>
					</#if>
					
					<#list courses as course>
						<tr>
							<td>${course.id}</td>
							<td>${course.type}</td>
							<td>${(course.courseRelation.relation.id)!}</td>
							<td>${course.title} - ${course.code}</td>
							<td>${(trainMap[course.courseRelation.relation.id].name)!}</td>
							<td>${DictionaryUtils.getEntryName('COURSE_TYPE', (course.type)!) }</td>
							<td>${(course.studyHours)!}</td>
							<td>${DictionaryUtils.getEntryName('COURSE_STATE', (course.state)!) }</td>
							<td>${(course.timePeriod.startTime?string('yyyy-MM-dd'))!}</td>
						</tr>
					</#list>
	            </tbody>
	            <tfoot>
	                <tr>
	                    <td colspan="10">
	                    	 <#if paginator??>
						    	<#import "/nts/include/pagination.ftl" as p/>
						    	<@p.pagination paginator=paginator formId="listCourseForm" divId="content"/>
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
		$('#listCourseTable').datagrid();
	});

	function editCourseConfig() {
		var row = $('#listCourseForm').find('#listCourseTable').datagrid('getSelections');	
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时设置多门课程的开课信息', 'warning');
			return false;
		}else {
			var id = row[0].id;
			var trainId = row[0].trainId;
			easyui_modal_open('editCourseConfigDiv', '设置开课信息', 700, 600, '${ctx}/manage/train/course/editCourseConfig?course.id='+id+'&relation.id='+trainId, true);
		}
	}
	
	function editCourseAuthorize(role){
	var row = $('#listCourseForm').find('#listCourseTable').datagrid('getSelections');	
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时对多门课程进行授权', 'warning');
			return false;
		}else {
			var id = row[0].id;
			var trainId = row[0].trainId;
			var title = '授权课程制作';
			if(role == 'assistant'){
				title = '授权课程辅导'
			}else if(role == 'teacher'){
				title = '授权课程助学'
			}
			easyui_modal_open('editCourseAuthorizeDiv', '授权课程助学', 700, 600, '${ctx}/manage/course/editCourseAuthorize?role='+role+'&course.id='+id+'&trainId='+trainId, true);
		}
	}
	
	function listCourseRegister(){
		var row = $('#listCourseForm').find('#listCourseTable').datagrid('getSelections');
		if(row.length <=0){
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return;
		}else if(row.length >1){
			$.messager.alert('提示', '只能同时对一门课程进行选课管理', 'warning');
			return;
		}
		var courseId = row[0].id;
		var trainId = row[0].trainId;
		load_next_content('/manage/courseRegister', 'listCourseForm', '选课管理', 'course.id='+courseId+'&relation.id='+trainId);
	}
	
	function listCourseResult(){
		var row = $('#listCourseForm').find('#listCourseTable').datagrid('getSelections');
		if(row.length <=0){
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return;
		}else if(row.length >1){
			$.messager.alert('提示', '只能同时对一门课程进行成绩管理', 'warning');
			return;
		}
		var courseId = row[0].id;
		var trainId = row[0].trainId;
		load_next_content('/manage/course/result', 'listCourseForm', '选课管理', 'course.id='+courseId+'&relation.id='+trainId);
	}
</script>

