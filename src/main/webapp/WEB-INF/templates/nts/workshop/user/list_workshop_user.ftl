<form id="listWorkshopUserForm" action="${ctx}/manage/workshopUser"  method ="get">
	<input type="hidden" name="workshopId" value="${workshopUser.workshopId}">
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
							<input type="text" name="user.realName" value="${(workshopUser.user.realName)!}" placeholder="" class="mis-ipt">
						</div>
					</div>
				</div>
			</li>
		</ul>
		<div class="mis-btn-row indent1">
			<button onclick="easyui_window_update('listWorkshopUserForm','layout_center_tabs');" type="button" class="mis-btn mis-main-btn"><i class="mis-srh-ico"></i>查询</button>
			<a onclick="resetForm(this)"  class="mis-btn mis-default-btn">
				<i class="mis-refresh-ico"></i>重置
			</a>
		</div>
	</div>

	<div class="mis-table-layout">
		<div class="mis-opt-row">
			<div class="mis-opt-mod fl">
				<a href="###" onclick="addWorkshopUser()" class="mis-btn mis-inverse-btn"><i class="mis-add-ico"></i>新建</a>
				<button onclick="deleteWorkshopUser()" type="button" class="mis-btn mis-inverse-btn" >
					<i class="mis-delete-ico"></i>删除
				</button>
				<button type="button" class="mis-btn mis-inverse-btn" onclick="editWorkshopUser()">
					<i class="mis-alter-ico"></i>修改
				</button>
				<button onclick="goImport()"  type="button" class="mis-btn mis-inverse-btn" ><i class="mis-setting-ico"></i>导入</button>
			</div>
		</div>
		<div class="mis-table-mod">
			<table id="listWorkshopUserTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
				<thead>
					<tr>
						<th width="50px" data-options="field:'id',checkbox:true"></th>
						<th data-options="field:'title'">姓名</th>
						<th data-options="field:'summary'">角色</th>
					</tr>
				</thead>
				<tbody>
					<#assign user=(workshopUser.user)!>
					<@workshopUsersDirective limit=(pageBounds.limit)!10 orders=orders!'CREATE_TIME.DESC' page=(pageBounds.page)!1 workshopId = workshopUser.workshopId! realName = (user.realName)!''>
						<#if workshopUsers??>
							<#list workshopUsers as workshopUser>
								<tr>
									<td>${workshopUser.id!}</td>
									<td>${workshopUser.user.realName!}</td>
									<td>
										<#if workshopUser.role = 'master'>
											坊主
										<#elseif workshopUser.role = 'member'>
											管理成员
										<#elseif workshopUser.role = 'student'>
											学员
										<#else>
										</#if>
									</td>
								</tr>
							</#list>					
						</#if>
					</@workshopUsersDirective>
				</tbody>
	            <tfoot>
	                <tr>
	                    <td colspan="9">
	                    	 <#if paginator??>
						    	<#import "/nts/include/pagination.ftl" as p/>
						    	<@p.pagination paginator=paginator formId="listWorkshopUserForm" divId="edit_content"/>
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
		$('#listWorkshopUserTable').datagrid();
	});

	$(function(){
		$('#create').on('click',function(){
			mylayerFn.open({
				id : '999',
				type : 2,
				title : '发布通知',
				content : '${ctx}/manage/workshopUser/create?workshopId=${(workshopUser.workshopId)}&_method=get',
				area : [500, '300'],
				offset : ['auto', 'auto'],
				fix : false,
				shadeClose : true,
			});
		});
	});
	
	function addWorkshopUser(relationId) {
		var url = '${ctx}/manage/workshopUser/create?workshopId=${(workshopUser.workshopId)}';
		easyui_modal_open('editWorkshopDiv', '创建工作坊成员', 700, 600, url, true);
	}

	function editWorkshopUser() {
		var row = $('#listWorkshopUserForm').find('#listWorkshopUserTable').datagrid('getSelections');	
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时编辑多条数据', 'warning');
			return false;
		}else {
			var id = row[0].id;
			easyui_modal_open('editWorkshopDiv', '编辑课程', 700, 600, '${ctx}/manage/workshopUser/'+id+'/edit', true);
		}
	}
	
	function deleteWorkshopUser(){
		var row = $('#listWorkshopUserForm').find('#listWorkshopUserTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时操作多条数据', 'warning');
			return false;
		}else {
			$.messager.confirm('确认','确认要删除选中记录吗？',function(r){
			   if(r){
			   	   var id = row[0].id;
			   	   var data = 'id='+id;
				   $.ajaxDelete("${ctx}/manage/workshopUser", data, function(response){
				   		if(response.responseCode == '00'){
				   			easyui_window_update('listWorkshopUserForm','listWorkshopUserDiv');
				   		}
				   });
			   }    
			}); 
		} 
	}
	
	function goImport(){
		easyui_modal_open('importWorkshopUserDiv','导入工作坊用户',300,200,'${ctx}/manage/workshopUser/goImport?workshopId=${workshopUser.workshopId}',true);
	}
</script>

