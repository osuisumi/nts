<form id="listPermissionForm" method="get" action="${ctx!}/auth_permissions">
	<input type="hidden" name="resource.id" value="${(permission.resource.id)!}">
	<div class="mis-table-layout">
		<div class="mis-opt-row">
			<div class="mis-opt-mod fl">
				<button onclick="addPermission()" type="button" class="mis-btn mis-inverse-btn">
					<i class="mis-add-ico"></i>新建
				</button>
				<button onclick="editPermission()" type="button" class="mis-btn mis-inverse-btn">
					<i class="mis-alter-ico"></i>修改
				</button>
				<button onclick="deletePermission()"  type="button" class="mis-btn mis-inverse-btn" >
					<i class="mis-delete-ico"></i>删除
				</button>
			</div>
		</div>
		<div class="mis-table-mod">
			<table id="listPermissionTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
				<thead>
					<tr>
						<th data-options="field:'id',checkbox:true">选项</th>
						<th data-options="field:'title'">权限名称</th>
						<th data-options="field:'type'">action</th>
						<th data-options="field:'realName'">actionURI</th>
					</tr>
				</thead>
				<tbody>
					<@permissionsData permission=permission pageBounds=pageBounds>
						<#list permissions as permission>
							<tr>
								<td>${(permission.id)!}</td>
								<td>${(permission.name)!}</td>
								<td>${(permission.action)!}</td>
								<td>${(permission.actionURI)!}</td>
							</tr>
						</#list>
					</@permissionsData>
				</tbody>
	            <tfoot>
	                <tr>
	                    <td colspan="10">
	                    	 <#if paginator??>
						    	<#import "/nts/include/pagination.ftl" as p/>
						    	<@p.pagination paginator=paginator formId="listPermissionForm" refrechDivId="loadPermissionPage"/>
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
		$('#listPermissionTable').datagrid();
	});

	function addPermission(){
		var url = '${ctx!}/nts/auth_permissions/create';
		easyui_modal_open('editPermissionDiv', '新增权限', 800, 300, url, true);
	}
	
	function deletePermission(){
		var row = $('#listPermissionTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else {
			$.messager.confirm('确认','确认要删除选中的组吗？',function(r){    
			    if (r){
			    	$.ajaxDelete('${ctx!}/nts/auth_permissions/batch/delete', $('#listPermissionForm').serialize(), function(){
						removeDeleteCheckBox('listPermissionForm');
			    		//easyui_panel_update('listPermissionForm','permissionList');
			    		$.ajaxQuery('listPermissionForm', 'loadPermissionPage');
					});
			    }    
			}); 
		}
	}
	
	function editPermission(){
		var row = $('#listPermissionTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时编辑多条数据', 'warning');
			return false;
		}else {
			var id = row[0].id;
			var type = row[0].type;
			easyui_modal_open('editPermissionDiv', '修改权限', 800, 300, '${ctx!}/nts/auth_permissions/'+id+'/edit?type='+type, true);
		}
	}
	
	function removeDeleteCheckBox(formId){
		$('#'+formId+' input[type="checkbox"]:checked').remove();
	} 
</script>