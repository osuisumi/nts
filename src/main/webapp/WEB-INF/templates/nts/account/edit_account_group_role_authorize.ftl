<@accountRoleAuthorizeData >
	<#assign roles=(roles)!>
</@accountRoleAuthorizeData>
<form id="accountRoleAuthorizeForm" action="${ctx!}/auth_roles/authAccountGroupRoleAuthorize" method="post">
<input type="hidden" name="type" value="${(dictEntry.dictValue)!}">
<input type="hidden" name="relationId" value="nts">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="alter-table-v">
		<tbody>
			<tr>
				<td width="15%">角色授权：</td>
 				<td width="35%" style="text-align: left;">
				<select name="id" class="easyui-combobox"  style="width: 500px;"  data-options="editable:false" >
				<#list roles as role>
					<option value="${(role.id)!}" >${(role.name)!}</option>  
				</#list>
 				</select>
 				</td>
			</tr>					
		</tbody>
	</table>
	<br>
	<div style="text-align: center">
		<button type="button" onclick="saveAccountRole()" class="easyui-linkbutton">
			<i class="fa fa-floppy-o"></i> 确定
		</button>
	</div>
</form>
<script type="text/javascript">
	function saveAccountRole() {
		if(!$('#accountRoleAuthorizeForm').form('validate')){
			return false;
		}
		var data = $.ajaxSubmit('accountRoleAuthorizeForm');
		<#-- 
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			$.messager.alert("提示信息", "操作成功！", 'info', function() {
				easyui_tabs_update('listAccountForm', 'layout_center_tabs');
				easyui_modal_close('editAuthAccountRoleAuthorizeDiv');
			});
		}
		-->
		$.messager.alert("提示信息", "操作成功！", 'info', function() {
			easyui_tabs_update('listAccountForm', 'layout_center_tabs');
			easyui_modal_close('editAuthAccountRoleAuthorizeDiv');
		});	
	}
</script>