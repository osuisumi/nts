<form id="listCmtsMovementRegisterForm" action="${ctx!}/manage/nts/cmts/movement/register"  method ="get">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<div class="mis-table-layout">
	    <div class="mis-opt-row">
	        <div class="mis-opt-mod fl">
	            <button onclick="grantTicketNo();" type="button" class="mis-btn mis-inverse-btn"><i class="mis-add-ico"></i>发放邀请号</button>
	        </div>
	    </div>
		<div class="mis-table-mod">
	        <table id="listCmtsMovementRegisterTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
	            <thead>
	                <tr>
						<th data-options="field:'id',checkbox:true"></th>
						<th data-options="field:'title'">姓名</th>
						<th data-options="field:'type'">所在单位</th>
						<th data-options="field:'realName'">联系电话</th>
						<th data-options="field:'role'">报名时间</th>
						<th data-options="field:'sponsor'">邀请号</th>
	                </tr>
	            </thead>
	            <tbody>
	                <@movementRegisterData movementId=(movementRegister.movement.id)!'' page=(pageBounds.page)!1 limit=(pageBounds.limit)!10 orders='CREATE_TIME.DESC' >
						<#if (movementRegisters)??>
							<#list movementRegisters as movementRegister>
								<tr>
									<td>${(movementRegister.id)!}</td>
									<td>${(movementRegister.creator.realName)!}</td>
									<td>${(movementRegister.creator.deptName)!}</td>
									<td>${(movementRegister.phone)!}</td>
									<td>${TimeUtils.formatDate(movementRegister.createTime, 'yyyy-MM-dd HH:mm ')}</td>
									<td>${(movementRegister.ticketNo)!}</td>
								</tr>
							</#list>
						</#if>
					</@movementRegisterData>
	            </tbody>
	            <tfoot>
	                <tr>
	                    <td colspan="10">
	                    	 <#if paginator??>
						    	<#import "/nts/include/pagination.ftl" as p/>
						    	<@p.pagination paginator=paginator formId="listCmtsMovementRegisterForm" divId="content"/>
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
		$('#listCmtsMovementRegisterTable').datagrid();
	});
	
	function grantTicketNo(){
		var rows = $('#listCmtsMovementRegisterForm').find('#listCmtsMovementRegisterTable').datagrid('getSelections');
		if (rows.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else {
			$.messager.confirm('确认','确定要发放邀请号吗?',function(r){    
			    if (r){
			    	var id = "";
			    	for(var i =0;i<rows.length;i++){
					  	id = rows[i].id + ',' +id;
					};
					$.put('${ctx!}/manage/nts/cmts/movement/register/grantTicketNo','id='+id , function(){
						easyui_tabs_update('listCmtsMovementRegisterForm', 'layout_center_tabs');
					});
			    }    
			}); 
		}
	};
</script>

