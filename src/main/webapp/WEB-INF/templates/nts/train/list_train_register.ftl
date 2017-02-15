<form id="listTrainRegisterForm" action="${ctx}/trainRegister"  method ="get">
	<input type="hidden" name="train.id" value="${trainRegisterExtend.train.id}">
	<@trainDirective id=trainRegisterExtend.train.id>
		<#assign train=trainModel>
		<#if train.registerTime??>
			<#if !(TimeUtils.hasBegun(train.registerTime.startTime))>
				<#assign registeTimeState = 'notBegin'>
			<#elseif TimeUtils.hasEnded(train.registerTime.endTime)>
				<#assign registeTimeState = 'ended'>
			<#else>
				<#assign registeTimeState = 'ongoing'>
			</#if>
		<#else>
			<#assign registeTimeState = 'ongoing'>
		</#if>
	</@trainDirective>
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<div class="mis-srh-layout">
		<ul class="mis-ipt-lst">
			<li class="item" style="width:400px">
				<div class="mis-ipt-row">
					<div class="tl">
						<span>姓名：</span>
					</div>
					<div class="tc">
						<div class="mis-ipt-mod">
							<input type="text" name="userInfo.realName" value="${(trainRegisterExtend.userInfo.realName)!}" placeholder="请输入姓名..." class="mis-ipt">
						</div>
					</div>
				</div>
			</li>
			<li class="item" style="width:400px">
				<div class="mis-ipt-row">
					<div class="tl">
						<span>单位：</span>
					</div>
					<div class="tc">
						<div class="mis-ipt-mod">
							<input type="text" name="userInfo.department.deptName" value="${(trainRegisterExtend.userInfo.department.deptName)!}" placeholder="请出入单位..." class="mis-ipt">
						</div>
					</div>
				</div>
			</li>
            <li class="item" style="width:400px">
                <div class="mis-ipt-row">
                    <div class="tl">
                        <span>审核状态：</span>
                    </div>
                    <div class="tc">
                        <div class="mis-select">
                            <select name="state" id="">
                            	<#assign state=(trainRegisterExtend.state)! />
                                <option <#if state=''>selected="selected"</#if>  value="">请选择</option>
                                <option <#if state='pass'>selected="selected"</#if> value="pass">审核通过</option>
                                <option <#if state='submit'>selected="selected"</#if> value="submit">待审核</option>
                                <option <#if state='nopass'>selected="selected"</#if> value="nopass">审核不通过</option>
                            </select>    
                        </div>
                    </div>
                </div>
            </li>
	        <li class="item item-twoIpu">
                <div class="mis-ipt-row">
                    <div class="tl">
                        <span>报名时间：</span>
                    </div>
                    <div class="center">
                        <div class="tc">
                            <div class="mis-ipt-mod">
                                <input name="minCreateTime" type="text" value="${(trainRegisterExtend.minCreateTime?string("yyyy-MM-dd"))! }" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="mis-ipt">
                            </div>
                        </div>
                        <span class="to">至</span>
                        <div class="tc">
                            <div class="mis-ipt-mod">
                                <input name="maxCreateTime" type="text" value="${(trainRegisterExtend.maxCreateTime?string("yyyy-MM-dd"))!}" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="mis-ipt" >
                            </div>
                        </div>                                            
                    </div>
                </div>
            </li>

		</ul>
		<div class="mis-btn-row indent1">
			<button onclick="easyui_window_update('listTrainRegisterForm','layout_center_tabs');" type="button" class="mis-btn mis-main-btn"><i class="mis-srh-ico"></i>查询</button>
			<a onclick="resetForm(this)"  class="mis-btn mis-default-btn">
				<i class="mis-refresh-ico"></i>重置
			</a>
		</div>
	</div>

	<div class="mis-table-layout">
		<div class="mis-opt-row">
			<div class="mis-opt-mod fl">
				<!-- <a href="###" onclick="addTrainRegister()" class="mis-btn mis-inverse-btn"><i class="mis-add-ico"></i>新建</a> -->
				<button onclick="deleteTrainRegister()" type="button" class="mis-btn mis-inverse-btn" >
					<i class="mis-delete-ico"></i>删除
				</button>
				<button onclick="updateTrainRegisterState('pass')" type="button" class="mis-btn mis-inverse-btn" id="layerBtn3"><i class="mis-look-ico"></i>审核通过</button>
				<button onclick="updateTrainRegisterState('nopass')"  type="button" class="mis-btn mis-inverse-btn" ><i class="mis-setting-ico"></i>审核不通过</button>
				<button onclick="goimportTrainRegister('${trainRegisterExtend.train.id}')"  type="button" class="mis-btn mis-inverse-btn" ><i class="mis-import-ico"></i>导入</button>
			</div>
		</div>
		<div class="mis-table-mod">
			<table id="listTrainRegisterTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
				<thead>
					<tr>
						<th width="50px" data-options="field:'id',checkbox:true"></th>
						<th  data-options="field:'name'">姓名</th>
						<th  data-options="field:'project.name'">身份证号</th>
						<th  data-options="field:'description'">单位</th>
						<th  data-options="field:'state'">报名时间</th>
						<th  data-options="field:'type'">审核状态</th>
					</tr>
				</thead>
				<tbody>
					<@trainRegisterExtendsDirective pageBounds=pageBounds trainRegisterExtend=trainRegisterExtend>
						<#if trainRegisterExtends??>
							<#list trainRegisterExtends as tre>
								<tr>
									<td>${(tre.id)!}</td>
									<td>${(tre.userInfo.realName)!}</td>
									<td>${(tre.userInfo.paperworkNo)!}</td>
									<td>${(tre.userInfo.department.deptName)!}</td>
									<td>${TimeUtils.formatDate(tre.createTime,'yyyy-MM-dd')}</td>
									<td>
										<#if ((tre.state)!'') = 'pass'>
											通过
										<#elseif ((tre.state)!'') = 'submit'>
											待审核
										<#elseif ((tre.state)!'') = 'nopass'>
											不通过
										</#if>
									</td>
								</tr>
							</#list>					
						</#if>
					</@trainRegisterExtendsDirective>
				</tbody>
	            <tfoot>
	                <tr>
	                    <td colspan="9">
	                    	 <#if paginator??>
						    	<#import "/nts/include/pagination.ftl" as p/>
						    	<@p.pagination paginator=paginator formId="listTrainRegisterForm" divId="edit_content"/>
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
		$('#listTrainRegisterTable').datagrid();
	});

	function addTrainRegister() {
		var registeTimeState = "${registeTimeState}";
		if(registeTimeState == 'notBegin'){
			$.messager.alert('提示', '报名尚未开始！', 'warning');
		}else if(registeTimeState == 'ended'){
			$.messager.alert('提示', '报名已结束！', 'warning');
		}else{
			easyui_modal_open('editTrainRegisterDiv', '新增报名', 700, 600, "${ctx}/trainRegister/create?train.id=${(trainRegisterExtend.train.id)!}", true);
		}
	}

	function deleteTrainRegister(){
		var row = $('#listTrainRegisterForm').find('#listTrainRegisterTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else {
			$.messager.confirm('确认','确认要删除选中记录吗？',function(r){
				if(r){
					   $.ajaxDelete("${ctx}/manage/trainRegister/deleteByLogic",$('#listTrainRegisterForm').serialize(),function(response){
					   		if(response.responseCode == '00'){
					   			easyui_window_update('listTrainRegisterForm','listTrainRegisterDiv');
					   		}
					   });
				}    
			}); 
		} 
	}
	
	function updateTrainRegisterState(state){
		var row = $('#listTrainRegisterForm').find('#listTrainRegisterTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else {
			var msg='';
			if(state == 'pass'){
				msg='确定审核通过？';
			}else{
				msg = '确定审核不通过？';
			}
			$.messager.confirm('确认',msg,function(r){
				if(r){
					var ids = '';
			    	$.each(row,function(i,n){
			    		if(ids == ''){
			    			ids = n.id;
			    		}else{
			    			ids = ids + ',' + n.id;
			    		}
			    	});
					$.put('${ctx}/manage/trainRegister', 'state='+state+'&id='+ids, function(){
						easyui_window_update('listTrainRegisterForm','listTrainRegisterDiv')
					});
				}
			});
	    	
		}
	}
	
	function goimportTrainRegister(trainId){
		var registeTimeState = "${registeTimeState}";
		if(registeTimeState == 'notBegin'){
			$.messager.alert('提示', '报名尚未开始！', 'warning');
		}else if(registeTimeState == 'ended'){
			$.messager.alert('提示', '报名已结束！', 'warning');
		}else{
			//easyui_modal_open('importTrainRegisterDiv','导入报名',300,200,'${ctx}/trainRegister/goImport?trainId='+trainId,true);				
			load_next_content('${ctx}/trainRegister/goImport?trainId='+trainId,'listTrainRegisterForm','导入报名');
		}
	}
</script>

