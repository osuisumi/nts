<form id="listRoleForm" action="${ctx!}/auth_roles" method="get">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<div class="mis-srh-layout">
		<ul class="mis-ipt-lst">
			<li class="item">
				<div class="mis-ipt-row">
					<div class="tl">
						<span>角色名称：</span>
					</div>
					<div class="tc">
						<div class="mis-ipt-mod">
							<input type="text" name="name" value="${(role.name)!}" placeholder="请输入姓名..." class="mis-ipt ">
							<input type="hidden" name="relationId" value="${(role.relationId)!}">
						</div>
					</div>
				</div>
			</li>
		</ul>
		<div class="mis-btn-row indent1">
			<button onclick="easyui_tabs_update('listRoleForm','layout_center_tabs');" type="button" class="mis-btn mis-main-btn">
				<i class="mis-srh-ico"></i>查询
			</button>
			<a onclick="resetForm(this)"  class="mis-btn mis-default-btn">
				<i class="mis-refresh-ico"></i>重置
			</a>
		</div>
	</div>
	<div class="mis-table-layout">
		<div class="mis-opt-row">
			<div class="mis-opt-mod fl">
				<button onclick="addRole();" type="button" class="mis-btn mis-inverse-btn">
					<i class="mis-add-ico"></i>新建
				</button>
				<button onclick="editRole();" type="button" class="mis-btn mis-inverse-btn">
					<i class="mis-alter-ico"></i>修改
				</button>
				<button onclick="deleteRole();"  type="button" class="mis-btn mis-inverse-btn" >
					<i class="mis-delete-ico"></i>删除
				</button>
				<button onclick="editRoleMenu();" type="button" class="mis-btn mis-inverse-btn">
					<i class="mis-setting-ico"></i> 菜单配置
				</button>
				<button onclick="editRolePermission();" type="button" class="mis-btn mis-inverse-btn">
					<i class="mis-lock-ico"></i> 权限配置
				</button>
			</div>
		</div>
		<div class="mis-table-mod">
			<table id="listRoleTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
				<thead>
					<tr>
						<th data-options="field:'id',checkbox:true"></th>
						<th data-options="field:'name'">角色名称</th>
						<th data-options="field:'summary'">描述</th>
						<th data-options="field:'code'">角色标识</th>
					</tr>
				</thead>
				<tbody>
					<@rolesData role=role pageBounds=pageBounds>
						<#list roles as role>
							<tr>
								<td>${(role.id)!}</td>
								<td>${(role.name)!}</td>
								<td>${(role.summary)!}</td>
								<td>${(role.code)!}</td> 
							</tr>
						</#list>
					</@rolesData>
				</tbody>
	            <tfoot>
	                <tr>
	                    <td colspan="10">
	                    	 <#if paginator??>
						    	<#import "/nts/include/pagination.ftl" as p/>
						    	<@p.pagination paginator=paginator formId="listAccountForm" divId="content"/>
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
		$('#listRoleTable').datagrid();	
	});
	
	function addRole() {
		var url = '${ctx!}/nts/auth_roles/create';
		easyui_modal_open('editRoleDiv', '新增角色', 800, 500, url, true);
	}

	function editRole() {
		var row = $('#listRoleForm').find('#listRoleTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时编辑多条数据', 'warning');
			return false;
		}else {
			var id = row[0].id;
			/*
			if(id == '1' || id == '2' || id == '3' || id == '4' || id == '-1'){
				alert('此角色不能编辑');
				return false;
			}*/
			easyui_modal_open('editRoleDiv', '修改角色', 800, 500, '${ctx!}/nts/auth_roles/'+id+'/edit', true);
		}
	}
	
	function deleteRole(){
		var row = $('#listRoleForm').find('#listRoleTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else {
			$.messager.confirm('确认','确认要删除选中的角色吗？',function(r){    
			    if(r){
			    	$.ajaxDelete('${ctx!}/auth_roles/batch/delete', $('#listRoleForm').serialize(), function(){
						removeDeleteCheckBox('listRoleForm');
			    		easyui_tabs_update('listRoleForm', 'layout_center_tabs');
					});
			    }
			}); 
		}
	}
	
	function editRoleMenu(){
		var row = $('#listRoleForm').find('#listRoleTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时对多个角色进行菜单配置', 'warning');
			return false;
		}else {
			var id = row[0].id;
			easyui_modal_open('editRoleMenuDiv', '菜单配置', 800, 500, '${ctx!}/nts/auth_roles/'+id+'/editRoleMenu', true);
		}
	}
	
	function editRolePermission(){
		var row = $('#listRoleForm').find('#listRoleTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时对多个角色进行权限配置', 'warning');
			return false;
		}else {
			var id = row[0].id;
			easyui_modal_open('editRolePermissionDiv', '权限配置', 900, 600, '${ctx!}/nts/auth_roles/'+id+'/editRolePermission', true);
		}
	} 
	
	function removeDeleteCheckBox(formId){
		$('#'+formId+' input[type="checkbox"]:checked').remove();
	} 
</script>