<form id="listTeacherForm" action="${ctx}/teacher"  method ="get">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<div class="mis-srh-layout">
		<ul class="mis-ipt-lst">
			<li class="item">
				<div class="mis-ipt-row">
					<div class="tl">
						<span>姓名：</span>
					</div>
					<div class="tc">
						<div class="mis-ipt-mod">
							<input type="text" name="realName" value="${(realName[0])!}" placeholder="" class="mis-ipt">
						</div>
					</div>
				</div>
			</li>
		</ul>
		<div class="mis-btn-row indent1">
			<button onclick="easyui_tabs_update('listTeacherForm','layout_center_tabs');" type="button" class="mis-btn mis-main-btn"><i class="mis-srh-ico"></i>查询</button>
			<a onclick="resetForm(this)"  class="mis-btn mis-default-btn">
				<i class="mis-refresh-ico"></i>重置
			</a>
		</div>
	</div>

	<div class="mis-table-layout">
		<div class="mis-opt-row">
			<div class="mis-opt-mod fl">
				<!--<a href="###" onclick="addTrain()" class="mis-btn mis-inverse-btn"><i class="mis-add-ico"></i>新建</a>-->
				<button onclick="deleteTeacher()" type="button" class="mis-btn mis-inverse-btn" >
					<i class="mis-delete-ico"></i>删除
				</button>
				<button type="button" class="mis-btn mis-inverse-btn" onclick="goImportTeacher()">
					<i class="mis-import-ico"></i>导入
				</button>
				<button onclick="grantRole();" type="button" class="mis-btn mis-inverse-btn">
					<i class="mis-authorization-ico"></i> 角色授权
				</button>
			</div>
		</div>
		<div class="mis-table-mod">
			<table id="listTeacherTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
				<thead>
					<tr>
						<th width="50px" data-options="field:'id',checkbox:true"></th>
						<th  data-options="field:'name'">姓名</th>
						<th  data-options="field:'project.deptName'">单位</th>
						<th data-options="field:'role'">角色</th>
						<th data-options="field:'accountId',hidden:true"></th>
					</tr>
				</thead>
				<tbody>
					<@userTeachersDirective realName=(realName[0])!  page=(pageBounds.page)!1 limit=(pageBounds.limit)!10 orders=orders!'CREATE_TIME.DESC'>
						<#assign userIds = []>
						<#if teachers??>
							<#list teachers as teacher>
								<#assign userIds = userIds + [teacher.user.id]/>
							</#list>
						</#if>
						<#if (userIds?size>0)>
							<@userIdKeyAccountMapDirective userIds=userIds! getRole='Y'>
								<#assign accountMap=accountMap>
							</@userIdKeyAccountMapDirective>
						</#if>
					
						<#if teachers??>
							<#list teachers as teacher>
								<tr>
									<td>${teacher.id}</td>
									<td>${(teacher.user.realName)!}</td>
									<td>${(teacher.user.deptName)!}</td>
									<td><#if (accountMap[teacher.user.id].roles)??>
										<#list accountMap[teacher.user.id].roles as role>
											${(role.name)!}
										</#list>
									</#if></td>
									<td>${(accountMap[teacher.user.id].id)!}</td>
								</tr>
							</#list>					
						</#if>
					</@userTeachersDirective>
				</tbody>
	            <tfoot>
	                <tr>
	                    <td colspan="9">
	                    	 <#if paginator??>
						    	<#import "/nts/include/pagination.ftl" as p/>
						    	<@p.pagination paginator=paginator formId="listTeacherForm" divId="list_content"/>
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
		$('#listTeacherTable').datagrid();
	});
	
	function goImportTeacher(){
		load_next_content('${ctx}/teacher/goImport', 'listTeacherForm', "导入师资团队");
	}
	
	function deleteTeacher(){
		var row = $('#listTeacherForm').find('#listTeacherTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}  else {
			$.messager.confirm('确认', '确认要删除选中记录吗？', function(r) {
				if (r) {
					$.ajaxDelete("${ctx}/teacher", $('#listTeacherForm').serialize(), function(response) {
						if (response.responseCode == '00') {
							easyui_window_update('listTeacherForm', 'layout_center_tabs');
						}
					});
				}
			});
		}
	}
	
	function grantRole() {
		var row = $('#listTeacherForm').find('#listTeacherTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时角色授权多条数据', 'warning');
			return false;
		}else {
			var id = row[0].accountId;
			easyui_modal_open('editAuthAccountRoleAuthorizeDiv', '角色授权', 800, 300, '${ctx!}/manage/accounts/editAuthAccountRoleAuthorize/?id='+id, true);
		}
	}
	
</script>