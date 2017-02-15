<form id="saveDictEntryForm" action="${ctx!}/dict/nts" method="post">
	<input type="hidden" name="dictTypeCode" value="${(dictEntry.dictTypeCode)!}">
	<#if (dictEntry.id)??>
		<input id="id" type="hidden" name="id" value="${(dictEntry.id)!}">
		<script>
			$('#saveDictEntryForm').attr('action', '${ctx!}/dict/nts');
			$('#saveDictEntryForm').attr('method', 'put');
		</script>
	</#if>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="alter-table-v">
		<tbody>
			<tr>
				<td width="15%">用户分组名称：</td>
				<td width="35%" style="text-align: left;"><input type="text" name="dictName" class="easyui-textbox" required  value="${(dictEntry.dictName)!}" style="width: 500px;" /></td>
			</tr>
			<tr>
				<td width="15%">分组标识值：</td>
				<td width="35%" style="text-align: left;"><input type="text" name="dictValue" class="easyui-textbox" data-options="required:true" value="${(dictEntry.dictValue)!}" style="width: 500px;" /></td>
			</tr>														
		</tbody>
	</table>
	<br>
	<div style="text-align: center">
		<button type="button" onclick="saveDictEntry()" class="easyui-linkbutton">
			<i class="fa fa-floppy-o"></i> 保 存
		</button>
	</div>
</form>
<script type="text/javascript">
	function saveDictEntry() {
		if(!$('#saveDictEntryForm').form('validate')){
			return false;
		}
		var dictName = $('#saveDictEntryForm input[name=dictName]').val().trim();
		var dictValue = $('#saveDictEntryForm input[name=dictValue]').val().trim();
		if('${(dictEntry.dictName)!}' == dictName && '${(dictEntry.dictValue)!}' ==  dictValue){
			$.messager.alert("提示信息", "操作成功！", 'info');
			easyui_modal_close('editDictEntryDiv');
		}
		var data = $.ajaxSubmit('saveDictEntryForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			$.messager.alert("提示信息", "操作成功！", 'info', function() {
				easyui_window_update('listDictEntryForm','listUserGroupDiv');
				easyui_modal_close('editDictEntryDiv');
			});
		}else{
			$.messager.alert("提示信息", "操作失败（分组名称与标识值组合必须唯一）", 'info');
		}
	}
</script>