<#assign relationId='cmts'>
<#assign relationType='movement'>
<form id="listCmtsMovementForm" action="${ctx}/manage/nts/cmts/movement"  method ="get">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<div class="mis-srh-layout">
		<ul class="mis-ipt-lst">
			<li class="item">
				<div class="mis-ipt-row">
					<div class="tl">
						<span>发起人：</span>
					</div>
					<div class="tc">
						<div class="mis-ipt-mod">
							<input type="text" name="creator.realName" value="${(movement.creator.realName)!}" placeholder="请输入发起人..." class="mis-ipt">
						</div>
					</div>
				</div>
			</li>
			<li class="item">
				<div class="mis-ipt-row">
					<div class="tl">
						<span>单位：</span>
					</div>
					<div class="tc">
						<div class="mis-ipt-mod">
							<input type="text" name="sponsor" value="${(movement.sponsor)!}" placeholder="请输入单位..." class="mis-ipt">
						</div>
					</div>
				</div>
			</li>
			<li class="item item-twoIpu">
                <div class="mis-ipt-row">
                    <div class="tl">
                        <span>活动时间：</span>
                    </div>
                    <div class="center">
                        <div class="tc">
                            <div class="mis-ipt-mod">
                                <input name="movementRelations[0].startTime" required type="text" value="${(movement.movementRelations[0].timePeriod.startTime?string("yyyy-MM-dd HH:mm:ss"))!}" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="mis-ipt">
                            </div>
                        </div>
                        <span class="to">至</span>
                        <div class="tc">
                            <div class="mis-ipt-mod">
                                <input name="movementRelations[0].endTime" required type="text" value="${(movement.movementRelations[0].timePeriod.endTime?string("yyyy-MM-dd HH:mm:ss"))!}" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="mis-ipt" >
                            </div>
                        </div>                                            
                    </div>
                </div>
            </li>
			<li class="item">
				<div class="mis-ipt-row">
					<div class="tl">
						<span>关键字：</span>
					</div>
					<div class="tc">
						<div class="mis-ipt-mod">
							<input type="text" name="title" value="${(movement.title)!}" placeholder="请输入关键字..." class="mis-ipt">
						</div>
					</div>
				</div>
			</li>
			<li class="item">
				<div class="mis-ipt-row">
	                <div class="tl">
	                    <span>状态：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-select">
	                        <select name="status" id="">
	                            <option value="">请选择...</option>
								<option value="verifying" <#if (movement.status)! == 'verifying'>selected="selected"</#if>>未审核</option>
								<option value="pass" <#if (movement.status)! == 'pass'>selected="selected"</#if>>已通过</option>
								<option value="no_pass" <#if (movement.status)! == 'no_pass'>selected="selected"</#if>>不通过</option>
	                        </select>    
	                    </div>
	                </div>
	            </div>
			</li>
		</ul>
		<div class="mis-btn-row indent1">
			<button onclick="easyui_tabs_update('listCmtsMovementForm','layout_center_tabs');" type="button" class="mis-btn mis-main-btn">
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
				<button onclick="addCmtsMovement()" type="button" class="mis-btn mis-inverse-btn">
					<i class="mis-add-ico"></i>新建
				</button>
				<button onclick="editCmtsMovement()" type="button" class="mis-btn mis-inverse-btn">
					<i class="mis-alter-ico"></i>修改
				</button>
				<button onclick="deleteCmtsMovement()"  type="button" class="mis-btn mis-inverse-btn" >
					<i class="mis-delete-ico"></i>删除
				</button>
				<button onclick="updateCmtsMovementStatus('pass')" type="button" class="mis-btn mis-inverse-btn">
					<i class="mis-audit-ico"></i> 审核通过
				</button>
				<button onclick="updateCmtsMovementStatus('no_pass')" type="button" class="mis-btn mis-inverse-btn">
					<i class="mis-audit-ico"></i> 审核不通过
				</button>
				<button onclick="goUpdateCmtsMovement_Status('top')" type="button" class="mis-btn mis-inverse-btn">
					<i class="mis-top-ico"></i> 置顶
				</button>
				<button onclick="updateCmtsMovement_Status('top', 0)" type="button" class="mis-btn mis-inverse-btn">
					<i class="mis-untop-ico"></i> 取消置顶
				</button>
				<button onclick="listMovementRegister()" type="button" class="mis-btn mis-inverse-btn">
					<i class="mis-look-ico"></i> 查看报名名单
				</button>
			</div>
		</div>
		<div class="mis-table-mod">
			<table id="listCmtsMovementTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
				<thead>
					<tr>
						<th data-options="field:'id',checkbox:true">选项</th>
						<th data-options="field:'title'">标题</th>
						<th data-options="field:'type'">栏目分类</th>
						<th data-options="field:'realName'">发起人</th>
						<th data-options="field:'role'">身份</th>
						<th data-options="field:'sponsor'">所在单位</th>
						<th data-options="field:'movementTime'">活动时间</th>
						<th data-options="field:'registerTime'">报名截止</th>
						<th data-options="field:'inviteNo'">邀请号</th>
						<th data-options="field:'participateNum'">报名人数</th>
						<th data-options="field:'status'">状态</th>
						<th data-options="field:'topDays'">顶置天数</th>
					</tr>
				</thead>
				<tbody>
					<@movementData getStatus=true realName=(movement.creator.realName)!'' sponsor=(movement.sponsor)!'' title=(movement.title)!'' status=(movement.status)!''
						startTimeGreaterThan=((movement.movementRelations[0].timePeriod.startTime)?string('yyyy-MM-dd HH:mm:ss'))!'' endTimeLessThan=((movement.movementRelations[0].timePeriod.endTime)?string('yyyy-MM-dd HH:mm:ss'))!''
						relationId=relationId relationType=relationType page=(pageBounds.page)!1 limit=(pageBounds.limit)!10 orders='CREATE_TIME.DESC' 
						getHadTicketNum=true>
						<#if movements??>
							<#list movements as movement>
								<tr>
									<td>${(movement.id)!}</td>
									<td>${(movement.title)!}</td>
									<td>
										<#if (movement.type)??>
											<#if (movement.type)! == 'communicationMeeting'>
												跨校交流会
											<#elseif (movement.type)! == 'expertInteraction'>
												专家互动
											<#else>
												创课观摩
											</#if>
										</#if>
									</td>
									<td>${(movement.creator.realName)!}</td>
									<td></td>
									<td>${(movement.sponsor)!}</td>
									<td>
										<#if (movement.movementRelations[0].timePeriod.startTime)??>
											${TimeUtils.formatDate(movement.movementRelations[0].timePeriod.startTime, 'yyyy年MM月dd日 HH:mm ')}
										</#if>
										~
										<#if (movement.movementRelations[0].timePeriod.endTime)??>
											${TimeUtils.formatDate(movement.movementRelations[0].timePeriod.endTime, 'yyyy年MM月dd日 HH:mm ')}
										</#if>
									</td>
									<td>
										<#if (movement.movementRelations[0].registerTimePeriod.endTime)??>
											${TimeUtils.formatDate((movement.movementRelations[0].registerTimePeriod.endTime), 'yyyy年MM月dd日 HH:mm ')}
										<#else>
											--
										</#if>
									</td>
									<td>
										<#if (movement.movementRelations[0].ticketNum)?? && (movement.movementRelations[0].ticketNum) gt 0 >
											<#if (hadTicketNumMap)??>
												${(hadTicketNumMap[movement.id])!0}
											<#else>
												0
											</#if>
											/${(movement.movementRelations[0].ticketNum)!0}
										<#else>
											--
										</#if>
									</td>
									<td>
										${(movement.movementRegisters)?size}
									</td>
									<td>
										<#if (movement.status)! == 'pass'>
											已通过
										<#elseif (movement.status)! == 'no_pass'>
											不通过
										<#else>
											未审核
										</#if>
									</td>
									<td>
										<#if (statusMap[movement.id].top.days)??>
											${(statusMap[movement.id].top.days)!'' }
										<#else>
											0
										</#if>
									</td>
								</tr>
							</#list>					
						</#if>
					</@movementData>
				</tbody>
	            <tfoot>
	                <tr>
	                    <td colspan="12">
	                    	 <#if paginator??>
						    	<#import "/nts/include/pagination.ftl" as p/>
						    	<@p.pagination paginator=paginator formId="listCmtsMovementForm" divId="content"/>
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
		$('#listCmtsMovementTable').datagrid();
	});

	function addCmtsMovement() {
		var url = '${ctx}/manage/nts/cmts/movement/create?movementRelations[0].relation.id=${relationId}&movementRelations[0].relation.type=${relationType}';
		easyui_modal_open('editCmtsMovementDiv', '创建活动', 800, 600, url, true);
	}

	function editCmtsMovement() {
		var row = $('#listCmtsMovementForm').find('#listCmtsMovementTable').datagrid('getSelections');	
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时编辑多条数据', 'warning');
			return false;
		}else {
			var id = row[0].id;
			easyui_modal_open('editCmtsMovementDiv', '编辑活动', 800, 600, '${ctx}/manage/nts/cmts/movement/'+id+'/edit', true);
		}
	}
	
	function deleteCmtsMovement(){
		var row = $('#listCmtsMovementForm').find('#listCmtsMovementTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时编辑多条数据', 'warning');
			return false;
		}else {
			$.messager.confirm('确认','确认要删除选中记录吗？',function(r){
			   if(r){
			       var id = row[0].id;
				   $.ajaxDelete("${ctx}/manage/nts/cmts/movement/"+id,'&movementRelations[0].relation.type=movement', function(response){
				   		if(response.responseCode == '00'){
				   			easyui_tabs_update('listCmtsMovementForm','layout_center_tabs')
				   		}
				   });
			   }    
			}); 
		} 
	}
	
	function updateCmtsMovementStatus(status){
		var row = $('#listCmtsMovementForm').find('#listCmtsMovementTable').datagrid('getSelections');
		var msg = '确定要通过所选活动的审核吗?';
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else {
			var id = row[0].id;
			$.messager.confirm('确认',msg,function(r){    
			    if (r){    
					$.put('${ctx!}/manage/nts/cmts/movement/'+id, 'status='+status, function(){
						easyui_tabs_update('listCmtsMovementForm', 'layout_center_tabs');
					});
			    }    
			}); 
		}
	}
	
	function goUpdateCmtsMovement_Status(state){
		var row = $('#listCmtsMovementForm').find('#listCmtsMovementTable').datagrid('getSelections');	
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else {
			$('#listCmtsMovementForm input[name=state]').remove();
			var id = row[0].id;
			easyui_modal_open('updateStatusDiv', '置顶活动', 600, 350, '${ctx}/manage/nts/status/goUpdateStatus?state='+state+'&relation.type=movement&formId=listCmtsMovementForm&id='+id, true);
		}
	}
	
	function updateCmtsMovement_Status(state, days){
		var row = $('#listCmtsMovementForm').find('#listCmtsMovementTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时编辑多条数据', 'warning');
			return false;
		}else {
			$.messager.confirm('确认','确认要修改选中记录吗？',function(r){
			   if(r){
				   var relaitonId = $('#listCmtsMovementForm input[name="id"]').val();
				   $.put("${ctx}/manage/status", 'relation.id='+relaitonId+'&relation.type=movement&state='+state+'&days='+days, function(response){
				   		if(response.responseCode == '00'){
				   			easyui_tabs_update('listCmtsMovementForm','layout_center_tabs')
				   		}
				   });
			   }    
			}); 
		} 
	};
	
	function listMovementRegister(){
		var row = $('#listCmtsMovementForm').find('#listCmtsMovementTable').datagrid('getSelections');	
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时编辑多条数据', 'warning');
			return false;
		}else {
			var id = row[0].id;
			easyui_modal_open('listMovementRegisterDiv', '编辑活动', 800, 600, '${ctx!}/manage/nts/cmts/movement/register?movement.id='+id, true);
		}
	};
	
	function sendMovement(){
	
	};
</script>

