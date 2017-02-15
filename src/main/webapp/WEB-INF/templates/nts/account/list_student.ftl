<#global app_path=PropertiesLoader.get('app.nts.path') >
<form id="listAccountForm" action="${ctx!}/manage/accounts" method="get">
	<input type="hidden" name="roleCode" value="${account.roleCode }">
	
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
							<input type="text" name="user.realName" value="${(account.user.realName)!}" placeholder="请输入姓名..." class="mis-ipt ">
						</div>
					</div>
				</div>
			</li>
			<li class="item">
				<div class="mis-ipt-row">
					<div class="tl">
						<span>用户名：</span>
					</div>
					<div class="tc">
						<div class="mis-ipt-mod">
							<input type="text" name="userName" value="${(account.userName)!}" placeholder="请输入用户名..." class="mis-ipt">
						</div>
					</div>
				</div>
			</li>
			<li class="item">
				<div class="mis-ipt-row">
					<div class="tl">
						<span>所在单位：</span>
					</div>
					<div class="tc">
						<div class="mis-ipt-mod">
							<input type="text" name="user.department.deptName" value="${(account.user.department.deptName)!}" placeholder="请输入所在单位..." class="mis-ipt">
						</div>
					</div>
				</div>
			</li>
		</ul>
		<div class="mis-btn-row indent1">
			<button onclick="searchAccount();" type="button" class="mis-btn mis-main-btn">
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
				<button onclick="addStudent();" type="button" class="mis-btn mis-inverse-btn">
					<i class="mis-add-ico"></i>新建
				</button>
				<button onclick="editStudent();" type="button" class="mis-btn mis-inverse-btn">
					<i class="mis-alter-ico"></i>修改
				</button>
				<button type="button" class="mis-btn mis-inverse-btn" onclick="goImportStudentAccount()">
					<i class="mis-import-ico"></i>导入
				</button>
				<button onclick="resetPassword();" type="button" class="mis-btn mis-inverse-btn">
					<i class="mis-key-ico"></i> 密码重置
				</button>
			</div>
		</div>
		<div class="mis-table-mod">
			<table id="listAccountTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
				<thead>
					<tr>
						<th data-options="field:'id',checkbox:true"></th>
						<th data-options="field:'accountName'">用户名</th>
						<th data-options="field:'realName'">姓名</th>
						<th data-options="field:'paperworkNo'">
							<#if app_path = '/nts/lego'>
								手机号
							<#else>
								身份证号
							</#if>
						</th>
						<th data-options="field:'deptName'">所在单位</th>
						<th data-options="field:'subject'">学科</th>
						<th data-options="field:'stage'">学段</th>
					</tr>
				</thead>
				<tbody>
					<@accountsData account=account pageBounds=pageBounds>
						<#list accounts as account>
							<tr>
								<td>${(account.id)!}</td>
								<td>${(account.userName)!}</td>
								<td>${(account.user.realName)!}</td>
								<td>${(account.user.paperworkNo)!}</td>
								<td>${(account.user.department.deptName)!}</td>
								<td>${(account.user.subject)!}</td>
								<td>${(account.user.stage)!}</td>  
							</tr>
						</#list>
					</@accountsData>
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
		$('#listAccountTable').datagrid();
	});
	
	function searchAccount() {
		$('#page').val('1');
		easyui_tabs_update('listAccountForm','layout_center_tabs');
	}
	
	function resetForAccount() {
		$('#listAccountForm').form('clear');
	}
	
	function resetPassword() {
		var row = $('#listAccountForm').find('#listAccountTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时编辑多条数据', 'warning');
			return false;
		}else {
			var id = row[0].id;
			easyui_modal_open('editAccountPasswordDiv', '修改用户密码', 800, 800, '${ctx!}/manage/accounts/'+id+'/editPassword', true);
		}
	}
	
	 function addStudent() {
		var url = '${ctx!}/manage/accounts/create_student';
		easyui_modal_open('editStudentDiv', '新增学员账户', 800, 800, url, true);
	}
	
	function editStudent() {
		var row = $('#listAccountForm').find('#listAccountTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时编辑多条数据', 'warning');
			return false;
		}else {
			var id = row[0].id;
			easyui_modal_open('editAccountDiv', '修改学员', 800, 800, '${ctx!}/manage/accounts/'+id+'/edit_student', true);
		}
	}
	
	function deleteAccount(){
		var row = $('#listAccountForm').find('#listAccountTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else {
			$.messager.confirm('确认','确认要删除选中的教师吗？',function(r){    
			    if(r){
			    	$.ajaxDelete('${ctx!}/manage/accounts/batch/delete', $('#listAccountForm').serialize(), function(){
			    		removeDeleteCheckBox('listAccountForm');
			    		easyui_tabs_update('listAccountForm', 'layout_center_tabs');
					});
			    }
			}); 
		}
	}
	
	function grantRole() {
		var row = $('#listAccountForm').find('#listAccountTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时角色授权多条数据', 'warning');
			return false;
		}else {
			var id = row[0].id;
			easyui_modal_open('editAuthAccountRoleAuthorizeDiv', '角色授权', 800, 300, '${ctx!}/manage/accounts/editAuthAccountRoleAuthorize/?id='+id, true);
		}
	}
	function removeDeleteCheckBox(formId){
		$('#'+formId+' input[type="checkbox"]:checked').remove();
	} 
	
	function groupManage(){
		easyui_modal_open('listUserGroupDiv', '分组管理', 900, 600, '${ctx!}/dict/nts?dictTypeCode=USER_GROUP', true);
	};
	
	function goImportStudentAccount(){
		load_next_content('${ctx}/manage/accounts/student/goImport', 'listAccountForm', "导入学员");
	}
</script>