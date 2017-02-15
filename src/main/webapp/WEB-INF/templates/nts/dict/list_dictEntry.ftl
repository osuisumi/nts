<@dictEntryData dictEntry=dictEntry pageBounds=pageBounds>
<form id="listDictEntryForm" action="${ctx!}/dict/nts" method="get">
	<input type="hidden" name="dictTypeCode" value="${(dictEntry.dictTypeCode)!}">
	<div>	
		<table cellpadding="0" cellspacing="0" width="100%" style="padding: 10px;">
			<tr>
				<td width="10%">分组名称：</td>
				<td width="10%">
				<input type="text" class="easyui-textbox" name="dictName" value="${(dictEntry.dictName)!}">
				</td>
				<td></td>
			</tr>
			<tr>
				<td colspan="6"><br />
					<button type="button" class="easyui-linkbutton main-btn" onclick="searchDictEntry()">
						<i class="fa fa-search"></i> 查询
					</button> 
					<button type="button" class="easyui-linkbutton" onclick="resetForDictEntry()">
						<i class="fa fa-plus"></i> 重置
					</button> 
					<button type="button" class="easyui-linkbutton" onclick="addDictEntry()">
						<i class="fa fa-plus"></i> 新增
					</button>
					<button type="button" class="easyui-linkbutton" onclick="editDictEntry()">
						<i class="fa fa-pencil"></i> 修改
					</button>
					<button type="button" class="easyui-linkbutton delete-btn" onclick="deleteDictEntry()">
						<i class="fa fa-minus"></i> 删除
					</button>
					<button type="button" class="easyui-linkbutton" onclick="grantRoleForGroup()">
						<i class="fa fa-user"></i> 分组角色授权
					</button>  
				</td>
			</tr>
		</table>
	</div>
	<table id="listDictEntryTable" class="easyui-pagination"  pagination="true" 
	rownumbers="true" fitColumns="true" singleSelect="false" checkOnSelect="true" 
	selectOnCheck="true">
		<thead>
			<tr>
				<th width="10" data-options="field:'id',checkbox:true"></th>
				<th width="20" data-options="field:'dictName'">用户分组名称</th>
				<th width="20" data-options="field:'dictValue'">分组标识值</th>
			</tr>
		</thead>
		<tbody>
			<#list dictEntries as d>
				<tr>
					<td>${(d.id)!}</td>
					<td>${(d.dictName)!}</td>
					<td>${(d.dictValue)!}</td>
				</tr>
			</#list>
		</tbody>
	</table>
	<#if paginator??>
      <#import "../include/pagination_window.ftl" as p/>
      <@p.pagination_window paginator=paginator windowId="listUserGroupDiv" formId="listDictEntryForm" type="easyui" tableId="listDictEntryTable"/>
	</#if>
</form>
</@dictEntryData>
<script>
	function searchDictEntry() {
		$('#page').val('1');
		easyui_window_update('listDictEntryForm','listUserGroupDiv');	
	}
	
	function resetForDictEntry() {
		$('#listDictEntryForm').form('clear');
	}
	
	function addDictEntry() {
		var url = '${ctx!}/dict/nts/create?dictTypeCode=${(dictEntry.dictTypeCode)!}';
		easyui_modal_open('editDictEntryDiv', '新增用户分组', 800, 500, url, true);
	}
	
	function editDictEntry() {
		var row = $('#listDictEntryForm').find('#listDictEntryTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时编辑多条数据', 'warning');
			return false;
		}else {
			var id = row[0].id;
			easyui_modal_open('editDictEntryDiv', '修改用户分组', 800, 500, '${ctx!}/dict/nts/edit?id='+id, true);
		}
	}
	
	function deleteDictEntry(){
		var row = $('#listDictEntryForm').find('#listDictEntryTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时操作多条数据', 'warning');
			return false;
		}else {
			$.messager.confirm('确认','确认要删除选中的用户分组吗？',function(r){    
			    if(r){
			    	$.ajaxDelete('${ctx!}/dict/nts/delete', $('#listDictEntryForm').serialize(), function(){
			    		removeDeleteCheckBox('listDictEntryForm');
						easyui_window_update('listDictEntryForm','listUserGroupDiv');	
					});
			    }
			}); 
		}
	}
	
	function grantRoleForGroup() {
		var row = $('#listDictEntryForm').find('#listDictEntryTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时角色授权多条数据', 'warning');
			return false;
		}else {
			var id = row[0].id;
			var dictValue = row[0].dictValue;
			easyui_modal_open('editAuthAccountRoleAuthorizeDiv', '角色授权', 800, 300, '${ctx!}/manage/accounts/editAccountGroupRoleAuthorize/?id='+id+'&dictValue='+dictValue, true);
		}
	}
	function removeDeleteCheckBox(formId){
		$('#'+formId+' input[type="checkbox"]:checked').remove();
	} 
</script>