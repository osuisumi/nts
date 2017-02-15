<form id="listTrainClassForm" action="${ctx}/train/class"  method ="get">
	<input type="hidden" name="relation.id" value="${(clazz.relation.id)!}">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<div class="mis-srh-layout">
		<ul class="mis-ipt-lst">
			<li class="item">
				<div class="mis-ipt-row">
					<div class="tl">
						<span>班级名称：</span>
					</div>
					<div class="tc">
						<div class="mis-ipt-mod">
							<input type="text" name="name" value="${(clazz.name)!}" placeholder="请输入名称..." class="mis-ipt">
						</div>
					</div>
				</div>
			</li>
		</ul>
		<div class="mis-btn-row indent1">
			<button onclick="easyui_tabs_update('listTrainClassForm','layout_center_tabs');" type="button" class="mis-btn mis-main-btn"><i class="mis-srh-ico"></i>查询</button>
			<a onclick="resetForm(this)"  class="mis-btn mis-default-btn">
				<i class="mis-refresh-ico"></i>重置
			</a>
		</div>
	</div>

	<div class="mis-table-layout">
		<div class="mis-opt-row">
			<div class="mis-opt-mod fl">
				<a href="###" onclick="addClass()" class="mis-btn mis-inverse-btn"><i class="mis-add-ico"></i>新建</a>
				<button onclick="deleteClass()" type="button" class="mis-btn mis-inverse-btn" >
					<i class="mis-delete-ico"></i>删除
				</button>
				<button type="button" class="mis-btn mis-inverse-btn" onclick="editClass()">
					<i class="mis-alter-ico"></i>修改
				</button>
				<button type="button" class="mis-btn mis-inverse-btn" onclick="listClassUser()">
					<i class="mis-alter-ico"></i>学员列表
				</button>
			</div>
		</div>
		<div class="mis-table-mod">
			<table id="listTrainClassTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
				<thead>
					<tr>
						<th width="50px" data-options="field:'id',checkbox:true"></th>
						<th  data-options="field:'name'">班级名称</th>
						<th  data-options="field:'project.name'">班级人数</th>
						<th  data-options="field:'description'">创建时间</th>
					</tr>
				</thead>
				<tbody>
					<@classesDirective page=(pageBounds.page)!1 orders=orders!'CREATE_TIME.DESC' limit=(pageBounds.limit)!10 relationId=(clazz.relation.id)!'' name=(clazz.name)!>
						<#if classes??>
							<#list classes as c>
								<tr>
									<td>${c.id}</td>
									<td>${(c.name)!}</td>
									<td>${(c.personNum)!}</td>
									<td>${(c.createTime)!}</td>
								</tr>
							</#list>					
						</#if>
					</@classesDirective>
				</tbody>
	            <tfoot>
	                <tr>
	                    <td colspan="9">
	                    	 <#if paginator??>
						    	<#import "/nts/include/pagination.ftl" as p/>
						    	<@p.pagination paginator=paginator formId="listTrainClassForm" divId="content"/>
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
		$('#listTrainClassTable').datagrid();
	});
	
	function listClassUser(){
		var row = $('#listTrainClassForm').find('#listTrainClassTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时操作多条数据', 'warning');
			return false;
		}else{
			var id = row[0].id;
			load_next_content('${ctx}/manage/train/class/user?trainId=${(clazz.relation.id)!}&classId='+id, 'listTrainClassForm', '学员列表');
		}
	}
	
	function deleteClass(){
		var row = $('#listTrainClassForm').find('#listTrainClassTable').datagrid('getSelections');
		if (row.length <= 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else{
			$.messager.confirm('确认', '确认要删除选中记录吗？', function(r) {
				if (r) {
					$.ajaxDelete("${ctx}/train/class", $('#listTrainClassForm').serialize(), function(response) {
						if (response.responseCode == '00') {
							easyui_tabs_update('listTrainClassForm', 'layout_center_tabs');
						}
					});
				}
			});
		}
	}
	
	function editClass(){
		var row = $('#listTrainClassForm').find('#listTrainClassTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时操作多条数据', 'warning');
			return false;
		}else{
			var id = row[0].id;
			load_next_content('${ctx}/manage/train/class/'+id +'/edit', null, '编辑班级');
		}
	}
	
	function addClass(){
		load_next_content('${ctx}/manage/train/class/create?relationId=${(clazz.relation.id)!}', 'listTrainClassForm', '新增班级');
	}
	
</script>