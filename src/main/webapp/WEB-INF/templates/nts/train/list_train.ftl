<form id="listTrainForm" action="${ctx}/train"  method ="get">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<div class="mis-srh-layout">
		<ul class="mis-ipt-lst">
			<li class="item">
				<div class="mis-ipt-row">
					<div class="tl">
						<span>名称：</span>
					</div>
					<div class="tc">
						<div class="mis-ipt-mod">
							<input type="text" name="name" value="${(trainParam.name)!}" placeholder="请输入名称..." class="mis-ipt">
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
						<div class="mis-ipt-mod">
							<input type="text" name="state" value="${(trainParam.state)!}" placeholder="状态" class="mis-ipt">
						</div>
					</div>
				</div>
			</li>
	        <li class="item item-twoIpu">
                <div class="mis-ipt-row">
                    <div class="tl">
                        <span>研修时间：</span>
                    </div>
                    <div class="center">
                        <div class="tc">
                            <div class="mis-ipt-mod">
                                <input name="minTrainingStartTime" required type="text" value="${(trainParam.minTrainingStartTime?string("yyyy-MM-dd"))!}" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="mis-ipt">
                            </div>
                        </div>
                        <span class="to">至</span>
                        <div class="tc">
                            <div class="mis-ipt-mod">
                                <input name="maxTrainingStartTime" required type="text" value="${(trainParam.maxTrainingStartTime?string("yyyy-MM-dd"))!}" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="mis-ipt" >
                            </div>
                        </div>                                            
                    </div>
                </div>
            </li>
		</ul>
		<div class="mis-btn-row indent1">
			<button onclick="easyui_tabs_update('listTrainForm','layout_center_tabs');" type="button" class="mis-btn mis-main-btn"><i class="mis-srh-ico"></i>查询</button>
			<a onclick="resetForm(this)"  class="mis-btn mis-default-btn">
				<i class="mis-refresh-ico"></i>重置
			</a>
		</div>
	</div>

	<div class="mis-table-layout">
		<div class="mis-opt-row">
			<div class="mis-opt-mod fl">
				<a href="###" onclick="addTrain()" class="mis-btn mis-inverse-btn"><i class="mis-add-ico"></i>新建</a>
				<button onclick="deleteTrain()" type="button" class="mis-btn mis-inverse-btn" >
					<i class="mis-delete-ico"></i>删除
				</button>
				<button type="button" class="mis-btn mis-inverse-btn" onclick="editTrain()">
					<i class="mis-alter-ico"></i>修改
				</button>
				<button onclick="editTrainConfig()"  type="button" class="mis-btn mis-inverse-btn" ><i class="mis-setting-ico"></i>培训配置</button>
				<button onclick="listTrainRegister()" type="button" class="mis-btn mis-inverse-btn" id="layerBtn3"><i class="mis-list-ico"></i>学员名单</button>
				<button onclick="listTrainAuthorize()"  type="button" class="mis-btn mis-inverse-btn" ><i class="mis-list-ico"></i>助学名单</button>
			</div>
		</div>
		<div class="mis-table-mod">
			<table id="listTrainTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
				<thead>
					<tr>
						<th width="50px" data-options="field:'id',checkbox:true"></th>
						<th  data-options="field:'name'">名称</th>
						<th  data-options="field:'project.name'">项目</th>
						<th  data-options="field:'description'">描述</th>
						<!-- <th width="10" data-options="field:'state'">状态</th>
						<th width="10" data-options="field:'type'">类型</th> -->
						<th  data-options="field:'trainingTime'">培训时间</th>
						<th  data-options="field:'registerTime'">报名时间</th>
						<th  data-options="field:'electivesTime'">选课时间</th>
						<th  data-options="field:'electivesTime'">培训学时</th>
						<th  data-options="field:'electivesTime'">培训费用</th>
						<th  data-options="field:'electivesTime'">收费方式</th>
						<th data-options="field:'hasBegun',hidden:true"></th>
					</tr>
				</thead>
				<tbody>
					<@trains trainParam=trainParam page = (pageBounds.page)!1 limit = (pageBounds.limit)!10 orders=orders!'CREATE_TIME.DESC'>
						<#if trains??>
							<#list trains as train>
								<tr>
									<td>${train.id}</td>
									<td>${train.name}</td>
									<td>${(train.project.name)!}</td>
									<td>${(train.description)!}</td>
									<!-- <td>${(train.state)!}</td>
									<td>${(train.type)!}</td> -->
									<td>${(train.trainingTime.startTime?string("yyyy-MM-dd"))!}--${(train.trainingTime.endTime?string("yyyy-MM-dd"))!}</td>
									<td>${(train.registerTime.startTime?string("yyyy-MM-dd"))!}--${(train.registerTime.endTime?string("yyyy-MM-dd"))!}</td>
									<td>${(train.electivesTime.startTime?string("yyyy-MM-dd"))!}--${(train.electivesTime.endTime?string("yyyy-MM-dd"))!}</td>
									<td>${(train.studyHours)!}</td>
									<td>${(train.price)!}</td>
									<td>${(train.chargeType)!}</td>
									<td><#if (train.trainingTime.startTime)??>${(TimeUtils.hasBegun(train.trainingTime.startTime))?c}<#else>true</#if></td>
								</tr>
							</#list>					
						</#if>
					</@trains>
				</tbody>
	            <tfoot>
	                <tr>
	                    <td colspan="9">
	                    	 <#if paginator??>
						    	<#import "/nts/include/pagination.ftl" as p/>
						    	<@p.pagination paginator=paginator formId="listTrainForm" divId="content"/>
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
		$('#listTrainTable').datagrid();
	});
	
	function addTrain(relationId) {
		var url = '${ctx}/train/create';
		easyui_modal_open('editTrainDiv', '创建培训', 700, 600, url, true);
	}

	function editTrain() {
		var row = $('#listTrainForm').find('#listTrainTable').datagrid('getSelections');	
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时编辑多条数据', 'warning');
			return false;
		}else {
			var id = row[0].id;
			easyui_modal_open('editTrainDiv', '编辑培训', 700, 600, '${ctx}/train/'+id+'/edit', true);
		}
	}
	
	function deleteTrain(){
		var row = $('#listTrainForm').find('#listTrainTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else {
			$.messager.confirm('确认','确认要删除选中记录吗？',function(r){
				if(r){
					var canDel = true;
					$.each(row,function(i,n){
						var hasBegun = row[i].hasBegun;
						if(hasBegun == 'true'){
							canDel = false;
							return;
						}
					});
					if(canDel == true){
					   $.ajaxDelete("${ctx}/train/deleteByLogic",$('#listTrainForm').serialize(),function(response){
					   		if(response.responseCode == '00'){
					   			easyui_tabs_update('listTrainForm','layout_center_tabs');
					   		}
					   });
					}else{
						$.messager.alert('提示', '选中的培训中包含已经开始的培训，请重新选择！', 'warning');
					}
				}    
			}); 
		} 
	}
	
	function editTrainCourse(){
		var row = $('#listTrainForm').find('#listTrainTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时操作多条数据', 'warning');
			return false;
		}else{
			var id = row[0].id;
			easyui_modal_open('editCourseRelationDiv', '配置课程', 700, 600, '${ctx}/manage/courseRelation/create?relationId='+id, true);
		}	
	}
	
	function listTrainRegister(){
		var row = $('#listTrainForm').find('#listTrainTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时查看多个培训', 'warning');
			return false;
		}
		var id = row[0].id;
		easyui_modal_open('listTrainRegisterDiv', '报名管理', 900, 600, '${ctx}/trainRegister?train.id='+id, true);
	}
	
	function editCommunityRelation(){
		var row = $('#listTrainForm').find('#listTrainTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时操作多条数据', 'warning');
			return false;
		}else{
			var id = row[0].id;
			easyui_modal_open('editCommunityRelationDiv', '配置社区', 700, 600, '${ctx}/manage/nts/cmts/community/relation/update?relation.id='+id, true);
		}	
	}
	
	function editWorkshopRelation(){
		var row = $('#listTrainForm').find('#listTrainTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时操作多条数据', 'warning');
			return false;
		}else{
			var id = row[0].id;
			easyui_modal_open('editWorkshopRelationDiv', '配置工作坊', 700, 600, '${ctx}/manage/train/editTrainWorkshop?id='+id, true);
		}	
	}

	function editTrainConfig(){
		var row = $('#listTrainForm').find('#listTrainTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时操作多条数据', 'warning');
			return false;
		}else{
			var id = row[0].id;
			easyui_modal_open('editTrainConfigDiv', '培训配置', 700, 600, '${ctx}/manage/train/editTrainConfig?id='+id, true);
		}	
	}
	
	function listTrainAuthorize(){
		var row = $('#listTrainForm').find('#listTrainTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时操作多条数据', 'warning');
			return false;
		}else{
			var id = row[0].id;
			//easyui_modal_open_list('listTrainAuthorize', '助学名单', 700, 600, , true);
			load_next_content('${ctx}/manage/train/authorize/'+id,null,'助学名单');
		}	
	}
	
</script>

