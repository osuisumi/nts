<form id="listDepartmentForm" action="${ctx!}/manage/departments" method="get">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<div class="mis-srh-layout">
		<ul class="mis-ipt-lst">
			<li class="item">
				<div class="mis-ipt-row">
					<div class="tl">
						<span>机构名称：</span>
					</div>
					<div class="tc">
						<div class="mis-ipt-mod">
							<input type="text" name="deptName" value="${(department.deptName)!}" placeholder="请输入机构名称..." class="mis-ipt">
						</div>
					</div>
				</div>
			</li>
		</ul>
		<div class="mis-btn-row indent1">
			<button onclick="searchDepartment();" type="button" class="mis-btn mis-main-btn">
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
				<button onclick="addDepartment();" type="button" class="mis-btn mis-inverse-btn">
					<i class="mis-add-ico"></i>新建
				</button>
				<button onclick="editDepartment();" type="button" class="mis-btn mis-inverse-btn">
					<i class="mis-alter-ico"></i>修改
				</button>
				<button onclick="deleteDepartment();"  type="button" class="mis-btn mis-inverse-btn" >
					<i class="mis-delete-ico"></i>删除
				</button>
			</div>
		</div>
		<div class="mis-table-mod">
			<table id="listDepartmentTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
				<thead>
					<tr>
						<th data-options="field:'id',checkbox:true"></th>
						<th data-options="field:'deptName'">机构名称</th>
						<th data-options="field:'deptCode'">组织机构代码</th>
						<th data-options="field:'deptType'">机构类型</th>
					</tr>
				</thead>
				<tbody>
					<@departmentsData department=department pageBounds=pageBounds>
						<#list departments as department>
							<tr>
								<td>${(department.id)!}</td>
								<td>${(department.deptName)!}</td>
								<td>${(department.deptCode)!}</td>
								<td>
									<#if (department.deptType)! == '1'>行政机构
									<#elseif (department.deptType)! == '2'>学校机构
									<#else>个人用户
									</#if>
								</td>
							</tr>
						</#list>
					</@departmentsData>
				</tbody>
	            <tfoot>
	                <tr>
	                    <td colspan="10">
	                    	 <#if paginator??>
						    	<#import "/nts/include/pagination.ftl" as p/>
						    	<@p.pagination paginator=paginator formId="listDepartmentForm" divId="content"/>
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
		$('#listDepartmentTable').datagrid();
	});
	
	function searchDepartment() {
		$('#page').val('1');
		removeDeleteCheckBox('listDepartmentForm');
		easyui_tabs_update('listDepartmentForm','layout_center_tabs');
	}
	
	function resetForDepartment() {
		$('#listDepartmentForm').form('clear');
	}
	
	function addDepartment() {
		var url = '${ctx!}/manage/departments/create';
		easyui_modal_open('editDepartmentDiv', '新增机构', 800, 500, url, true);
	}
	
	function editDepartment() {
		var row = $('#listDepartmentForm').find('#listDepartmentTable').datagrid('getSelections');
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
			easyui_modal_open('editDepartmentDiv', '修改机构', 800, 500, '${ctx!}/manage/departments/'+id+'/edit', true);
		}
	}
	
	function deleteDepartment(){
		var row = $('#listDepartmentForm').find('#listDepartmentTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else {
			$.messager.confirm('确认','确认要删除选中的机构吗？',function(r){    
			    if(r){
			    	$.ajaxDelete('${ctx!}/manage/departments/batch/delete', $('#listDepartmentForm').serialize(), function(){
						removeDeleteCheckBox('listDepartmentForm');
			    		easyui_tabs_update('listDepartmentForm', 'layout_center_tabs');
					});
			    }
			}); 
		}
	}
	
	function removeDeleteCheckBox(formId){
		$('#'+formId+' input[type="checkbox"]:checked').remove();
	} 
</script>