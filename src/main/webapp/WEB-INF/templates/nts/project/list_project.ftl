<form id="listProjectForm" action="${ctx}/project"  method ="get">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<div class="mis-srh-layout">
		<ul class="mis-ipt-lst">
			<li class="item">
				<div class="mis-ipt-row">
					<div class="tl">
						<span>名称：</span>
					</div>
					<div class="tc">
						<div class="mis-ipt-mod">
							<input type="text" name="name" value="${(project.name)!}" placeholder="请输入名称..." class="mis-ipt">
						</div>
					</div>
				</div>
			</li>
		</ul>
		<div class="mis-btn-row indent1">
			<button onclick="easyui_tabs_update('listProjectForm','layout_center_tabs');" type="button" class="mis-btn mis-main-btn"><i class="mis-srh-ico"></i>查询</button>
			<a onclick="resetForm(this)"  class="mis-btn mis-default-btn">
				<i class="mis-refresh-ico"></i>重置
			</a>
		</div>
	</div>

	<div class="mis-table-layout">
		<div class="mis-opt-row">
			<div class="mis-opt-mod fl">
				<a href="###" onclick="addProject()" class="mis-btn mis-inverse-btn"><i class="mis-add-ico"></i>新建</a>
				<button onclick="deleteProject()"  type="button" class="mis-btn mis-inverse-btn" >
					<i class="mis-delete-ico"></i>删除
				</button>
				<button type="button" class="mis-btn mis-inverse-btn" onclick="editProject()">
					<i class="mis-alter-ico"></i>修改
				</button>
			</div>
		</div>
		<div class="mis-table-mod">
			<table id="listProjectTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
				<thead>
					<tr>
						<th data-options="field:'id',checkbox:true" width="50px" >选项</th>
						<th data-options="field:'name'" >名称</th>
						<th data-options="field:'name'" >项目类型</th>
						<th data-options="field:'name'" >项目级别</th>
						<th data-options="field:'name'" >执行时间</th>
						<th data-options="field:'description'" >描述</th>
						<th data-options="field:'introVideo'" >介绍视频</th>
					</tr>
				</thead>
				<tbody>
					<@projects project=project pageBounds=pageBounds>
						<#if projects??>
							<#list projects as project>
								<tr>
									<td>${project.id}</td>
									<td>${project.name}</td>
									<td>${DictionaryUtils.getEntryName('PROJECT_TYPE',(project.type)!'')}</td>
									<td>${DictionaryUtils.getEntryName('AREA_LEVEL',(project.projectLevel)!'')}</td>
									<td><#if (project.timePeriod.startTime)?? && (project.timePeriod.endTime)??>${project.timePeriod.startTime?string('yyyy/MM/dd')}-${project.timePeriod.endTime?string('yyyy/MM/dd')}</#if></td>
									<td>${(project.description)!}</td>
									<td>${(project.introVideo)!}</td>
								</tr>
							</#list>					
						</#if>
					</@projects>
				</tbody>
	            <tfoot>
	                <tr>
	                    <td colspan="9">
	                    	 <#if paginator??>
						    	<#import "/nts/include/pagination.ftl" as p/>
						    	<@p.pagination paginator=paginator formId="listProjectForm" divId="content"/>
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
		$('#listProjectTable').datagrid();
	});

	function addProject(relationId) {
		var url = '${ctx}/project/create';
		easyui_modal_open('editProjectDiv', '创建项目', 700, 600, url, true);
	}

	function editProject() {
		var row = $('#listProjectForm').find('#listProjectTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		} else if (row.length > 1) {
			$.messager.alert('提示', '不能同时编辑多条数据', 'warning');
			return false;
		} else {
			var id = row[0].id;
			easyui_modal_open('editProjectDiv', '编辑文章', 700, 600, '${ctx}/project/' + id + '/edit', true);
		}
	}
	

	function deleteProject() {
		var row = $('#listProjectForm').find('#listProjectTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}  else {
			$.messager.confirm('确认', '确认要删除选中记录吗？', function(r) {
				if (r) {
					//var id = row[0].id;
					$.ajaxDelete("${ctx}/project/deleteByLogic", $('#listProjectForm').serialize(), function(response) {
						if (response.responseCode == '00') {
							easyui_tabs_update('listProjectForm', 'layout_center_tabs')
						}
					});
				}
			});
		}
	}
</script>
