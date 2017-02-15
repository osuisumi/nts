<form id="listCourseForm" action="${ctx}/manage/course"  method ="get">
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
	            <button onclick="addCourse()" type="button" class="mis-btn mis-inverse-btn"><i class="mis-add-ico"></i>新建</button>
	            <button onclick="editCourse()" type="button" class="mis-btn mis-inverse-btn"><i class="mis-alter-ico"></i>修改</button>
	            <button onclick="deleteCourse()" type="button" class="mis-btn mis-inverse-btn"><i class="mis-delete-ico"></i>删除</button>
	            <button onclick="goReviewPage()" type="button" class="mis-btn mis-inverse-btn" id="layerBtn2"><i class="mis-audit-ico"></i>课程审核</button>
	            <button onclick="editCourseAuthorize('maker')" type="button" class="mis-btn mis-inverse-btn" id="layerBtn2"><i class="mis-authorization-ico"></i>课程制作授权</button>
	        </div>
	    </div>
	    <div class="mis-table-mod">
	        <table id="listCourseTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
	            <thead>
	                <tr>
	                    <th width="50px" data-options="field:'id',checkbox:true">选项</th>
	                    <th data-options="field:'trueType',hidden:true">
	                    <th data-options="field:'title'">课程名</th>
	                    <th data-options="field:'code'">课程编号</th>
	                    <th data-options="field:'termNo'">计划开课学期</th>
	                    <th data-options="field:'organization'">课程机构</th>
	                    <th data-options="field:'type'">类型</th>
	                    <th data-options="field:'studyHours'">学时</th>
	                    <th data-options="field:'state'">状态</th>
	                </tr>
	            </thead>
	            <tbody>
	                <@coursesDirective isTemplate='Y' title=(course.title)!'' state=(course.state)!'' page=(pageBounds.page)!1 limit=(pageBounds.limit)!10 orders='CREATE_TIME.DESC'>
						<#list courses as course>
							<tr>
								<td>${course.id}</td>
								<td>${course.type}</td>
								<td>${course.title}</td>
								<td>${course.code}</td>
								<td>${(course.termNo)!}</td>
								<td>${(course.organization)!}</td>
								<td>${DictionaryUtils.getEntryName('COURSE_TYPE', (course.type)!) }</td>
								<td>${(course.studyHours)!}</td>
								<td>${DictionaryUtils.getEntryName('COURSE_STATE', (course.state)!) }</td>
							</tr>
						</#list>
					</@coursesDirective>
	            </tbody>
	            <tfoot>
	                <tr>
	                    <td colspan="10">
	                    	 <#if paginator??>
						    	<#import "../include/pagination.ftl" as p/>
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

	function addCourse(relationId) {
		var url = '${ctx}/manage/course/create';
		easyui_modal_open('editCourseDiv', '创建课程', 700, 600, url, true);
	}

	function editCourse() {
		var row = $('#listCourseForm').find('#listCourseTable').datagrid('getSelections');	
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时编辑多条数据', 'warning');
			return false;
		}else {
			var id = row[0].id;
			easyui_modal_open('editCourseDiv', '编辑课程', 700, 600, '${ctx}/manage/course/'+id+'/edit', true);
		}
	}
	
	function deleteCourse(){
		var row = $('#listCourseForm').find('#listCourseTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else {
			$.messager.confirm('确认','确认要删除选中记录吗？',function(r){
			   if(r){
				   $.ajaxDelete("${ctx}/manage/course/deleteByPhycics", $('#listCourseForm').serialize(), function(response){
				   		if(response.responseCode == '00'){
				   			easyui_tabs_update('listCourseForm','layout_center_tabs')
				   		}
				   });
			   }    
			}); 
		} 
	}
	/*
	function updateCourseState(state){
		var row = $('#listCourseForm').find('#listCourseTable').datagrid('getSelections');
		var msg = '确定要通过所选课程的审核吗?';
		if(state == 'reject'){
			msg = '确定驳回所选课程的审核吗?'
		}
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else {
			$.messager.confirm('确认',msg,function(r){    
			    if (r){    
			    	$('#listCourseForm input[name=state]').remove();
					$.put('${ctx}/manage/course', 'state='+state+'&'+$('#listCourseForm').serialize(), function(){
						easyui_tabs_update('listCourseForm', 'layout_center_tabs');
					});
			    }    
			}); 
		}
	}
	*/
	function goReviewPage(){
		var row = $('#listCourseForm').find('#listCourseTable').datagrid('getSelections');
		if(row.length <=0){
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return;
		}else if(row.length >1){
			$.messager.alert('提示', '只能操作一行数据', 'warning');
			return;
		}
		var id = row[0].id;
		var type = row[0].trueType;
		var state = row[0].state;
		if(state.trim() == '编辑中'){
			alert('该课程未发布');
			return false;
		}
		easyui_modal_open('reviewCourseDiv','课程审核: '+row[0].title,0,0,'${ctx}/manage/course/review/'+id+'?type='+type,true);
	}
	
	function editCourseAuthorize(role){
		var row = $('#listCourseForm').find('#listCourseTable').datagrid('getSelections');
		if(row.length <=0){
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return;
		}else if(row.length >1){
			$.messager.alert('提示', '只能同时对一门课程进行授权', 'warning');
			return;
		}
		var id = row[0].id;
		easyui_modal_open('editCourseAuthorizeDiv', '课程制作授权', 700, 600, '${ctx}/manage/course/editCourseAuthorize?role='+role+'&course.id='+id, true);		
	}
</script>

