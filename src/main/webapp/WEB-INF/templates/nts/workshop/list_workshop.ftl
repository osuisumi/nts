<form id="listWorkshopForm" action="${ctx}/manage/workshop"  method ="get">
<#import "/nts/include/tab.ftl" as tab/>
<@tab.tabFtl items=items[0] />
<div class="mis-srh-layout">
	<ul class="mis-ipt-lst">
		<li class="item">
			<div class="mis-ipt-row">
				<div class="tl">
					<span>工作坊名称：</span>
				</div>
				<div class="tc">
					<div class="mis-ipt-mod">
						<input type="text" name="title" value="${(workshop.title)!}" placeholder="请输入工作坊名称..." class="mis-ipt">
					</div>
				</div>
			</div>
		</li>
		<li class="item">
			<div class="mis-ipt-row">
				<div class="tl">
					<span>坊主姓名：</span>
				</div>
				<div class="tc">
					<div class="mis-ipt-mod">
						<input type="text" name="masterName" value="${(masterName[0])!}" placeholder="请输入坊主姓名" class="mis-ipt">
					</div>
				</div>
			</div>
		</li>
		<li class="item">
			<div class="mis-ipt-row">
				<div class="tl">
					<span>工作坊类型：</span>
				</div>
                <div class="tc">
                    <div class="mis-select">
                        <select name="type" id="">
                        	<option <#if ((type[0])!'') = ''>selected = 'selected'</#if> value="">请选择类型</option>
                        	<option <#if ((type[0])!'') = 'personal'>selected = 'selected'</#if> value="personal">个人工作坊</option>
                        	<option <#if ((type[0])!'') = 'train'>selected = 'selected'</#if> value="train">示范性工作坊</option>
                        </select>    
                    </div>
                </div>
			</div>
		</li>
		<li class="item">
            <div class="mis-ipt-row">
                <div class="tl">
                    <span>学段：</span>
                </div>
                <div class="tc">
                    <div class="mis-select">
                        <select name="stage" id="">
                        	<option value="">请选择学段</option>
                           ${TextBookUtils.getEntryOptionsSelected('STAGE',(stage[0])!'')}
                        </select>    
                    </div>
                </div>
            </div>
        </li>
		<li class="item">
            <div class="mis-ipt-row">
                <div class="tl">
                    <span>学科：</span>
                </div>
                <div class="tc">
                    <div class="mis-select">
                        <select name="subject" id="">
                        	<option value="">请选择学科</option>
                        	${TextBookUtils.getEntryOptionsSelected('SUBJECT',(subject[0])!'')}
                        </select>    
                    </div>
                </div>
            </div>
        </li>
		<li class="item">
            <div class="mis-ipt-row">
                <div class="tl">
                    <span>方案状态：</span>
                </div>
                <div class="tc">
                    <div class="mis-select">
                        <select name="solutionNum" id="">
                        	<option <#if ((solutionNum[0])!'') = ''>selected='selected'</#if> value="">请选择</option>
							<option <#if ((solutionNum[0])!'') = '0'>selected='selected'</#if> value="0">未提交</option>
							<option <#if ((solutionNum[0])!'') = '1'>selected='selected'</#if> value="1">已提交</option>
                        </select>    
                    </div>
                </div>
            </div>
        </li>
		<li class="item">
            <div class="mis-ipt-row">
                <div class="tl">
                    <span>审核状态：</span>
                </div>
                <div class="tc">
                    <div class="mis-select">
                        <select name="state" id="">
                        	<option <#if ((state[0])!'') = ''>selected='selected'</#if> value="">请选择</option>
                            <option <#if ((state[0])!'') = 'published'>selected='selected'</#if> value="published">已通过</option>
                            <option <#if ((state[0])!'') = 'reject'>selected='selected'</#if> value="reject">未通过</option>
                            <option <#if ((state[0])!'') = 'editing'>selected='selected'</#if> value="editing">待审核</option>
                        </select>    
                    </div>
                </div>
            </div>
        </li>
	</ul>
	<div class="mis-btn-row indent1">
		<button onclick="easyui_tabs_update('listWorkshopForm','content');" type="button" class="mis-btn mis-main-btn" >
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
			<a href="###" onclick="addWorkshop()" class="mis-btn mis-inverse-btn"><i class="mis-add-ico"></i>新建</a>
			<button onclick="deleteWorkshop()"  type="button" class="mis-btn mis-inverse-btn" >
				<i class="mis-delete-ico"></i>删除
			</button>
			<button onclick="editWorkshop()" type="button" class="mis-btn mis-inverse-btn">
				<i class="mis-alter-ico"></i>修改
			</button>
			<button onclick="auditWorkshop()" type="button" class="mis-btn mis-inverse-btn">
				<i class="mis-pass-ico"></i>工作坊审核
			</button>
			<button onclick="editWorkshopUser('master')" type="button" class="mis-btn mis-inverse-btn">
				<i class="mis-authorization-ico"></i>授权坊主
			</button>
			<button onclick="downloadSolution()" type="button" class="mis-btn mis-inverse-btn">
				<i class="mis-look-ico"></i>下载研修方案
			</button>
			<button onclick="changeToTemplate()" type="button" class="mis-btn mis-inverse-btn">
				<i class="mis-look-ico"></i>评为示范
			</button>
			<button onclick="changeToPersonal()" type="button" class="mis-btn mis-inverse-btn">
				<i class="mis-look-ico"></i>取消示范
			</button>
		</div>
	</div>
	<div class="mis-table-mod">
		<table id="listWorkshopTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
			<thead>
				<tr>
					<th width="50px" data-options="field:'id',checkbox:true"></th>
					<th  data-options="field:'title'">工作坊名称</th>
					<th  data-options="field:'state'">工作坊类型</th>
					<th  data-options="field:'stage'">学段</th>
					<th  data-options="field:'subject'">学科</th>
					<th  data-options="field:'master'">坊主</th>
					<th  data-options="field:'type'">研修方案</th>
					<th  data-options="field:'state'">审核状态</th>
					<th  data-options="field:'isTemplate'">成立时间</th>
					<th data-options="field:'solutionNum',hidden:true"></th>
					<th data-options="field:'masterIds',hidden:true"></th>
				</tr>
			</thead>
			<tbody>
				<@workshopsDirective masterName=(masterName[0])! type=(type[0])! stage=(stage[0])! subject=(subject[0])! state=(state[0])! solutionNum=(solutionNum[0])! withStat='Y' getSolutionNum='Y' limit=(pageBounds.limit)!10 orders=orders!'CREATE_TIME.DESC' page=(pageBounds.page)!1 title=(workshop.title)! relationIdNotInTrain='Y'>
					<#assign workshopIds = []>
					<#if workshops??>
						<#list workshops as workshop>
							<#assign workshopIds = workshopIds + [workshop.id]/>
						</#list>
					</#if>
					<#if (workshopIds?size>0)>
						<@workshopUsersMapDirective workshopIds=workshopIds! role='master'>
							<#assign workshopUserMap=workshopUserMap>
						</@workshopUsersMapDirective>
					</#if>
				
					<#if workshops??>
						<#list workshops as workshop>
							<tr>
								<td>${(workshop.id)!}</td>
								<td>${(workshop.title)!}</td>
								<td>
									<#if ((workshop.type)!'') == 'train' && ((workshop.isTemplate)!'') == 'Y'>
										示范性工作坊
									<#elseif ((workshop.type)!'') == 'personal'>
										个人工作坊
									</#if>
								</td>
								<td>${TextBookUtils.getEntryName('STAGE',workshop.stage)}</td>
								<td>${TextBookUtils.getEntryName('SUBJECT',workshop.subject)}</td>
								<td>
									<#if (workshopUserMap[workshop.id])??>
										<#list workshopUserMap[workshop.id] as master>
											${(master.userInfo.realName)!}
										</#list>
									</#if>
								</td>
								<td>
									<#if (workshop.workshopRelation.solutionNum)?? && (workshop.workshopRelation.solutionNum>0)>
										已提交
									<#else>
										未提交
									</#if>
								</td>
								<td>
									<#if (workshop.state)??>
										<#if workshop.state = 'published'>
											已通过
										<#elseif workshop.state = 'reject'>
											未通过
										<#else>
											待审核
										</#if>
									<#else>
										待审核
									</#if>									
								</td>
								<td>${TimeUtils.formatDate(workshop.createTime,'yyyy-MM-dd')}</td>
								<td>${(workshop.workshopRelation.solutionNum)!0}</td>
								<td><#if (workshopUserMap[workshop.id])??><#list workshopUserMap[workshop.id] as master>${(master.userInfo.id)!},</#list></#if></td>
							</tr>
						</#list>					
					</#if>
				</@workshopsDirective>
			</tbody>
            <tfoot>
                <tr>
                    <td colspan="10">
                    	 <#if paginator??>
					    	<#import "/nts/include/pagination.ftl" as p/>
					    	<@p.pagination paginator=paginator formId="listWorkshopForm" divId="content"/>
						</#if>
                    </td>
                </tr>
            </tfoot>
		</table>
	</div>
</div>
</form>

<form id="auditForm">
	
	
</form>

<script>
	$(function(){
		$('#listWorkshopTable').datagrid();
	});

	function addWorkshop(relationId) {
		var url = '${ctx}/manage/workshop/create';
		easyui_modal_open('editWorkshopDiv', '创建工作坊', 700, 600, url, true);
	}

	function editWorkshop() {
		var row = $('#listWorkshopForm').find('#listWorkshopTable').datagrid('getSelections');	
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时编辑多条数据', 'warning');
			return false;
		}else {
			var id = row[0].id;
			easyui_modal_open('editWorkshopDiv', '编辑课程', 700, 600, '${ctx}/manage/workshop/'+id+'/edit', true);
		}
	}
	
	function deleteWorkshop(){
		var row = $('#listWorkshopForm').find('#listWorkshopTable').datagrid('getSelections');
		if (row.length < 1) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else {
			$.messager.confirm('确认','确认要删除选中记录吗？',function(r){
			   if(r){
			   	   var id = row[0].id;
				   $.ajaxDelete("${ctx}/manage/workshop/deleteByLogic", $('#listWorkshopForm').serialize(), function(response){
				   		if(response.responseCode == '00'){
				   			easyui_tabs_update('listWorkshopForm','layout_center_tabs')
				   		}
				   });
			   }    
			}); 
		} 
	};
	
	function editWorkshopUser(role){
		var row = $('#listWorkshopForm').find('#listWorkshopTable').datagrid('getSelections');	
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时操作多条数据', 'warning');
			return false;
		}else{
			var id = row[0].id;
			var trainId = row[0].trainId;
			var url = "${ctx}/manage/train/workshop/editWorkshopUser/"+id +"/"+trainId + '?role='+role;
			var menu = '';
			if(role == 'student'){
				menu = '分配学员';
			}else if(role == 'master'){
				menu = '授权坊主';
			}else if(role == 'member'){
				menu = '授权助理坊主';
			}
			easyui_modal_open_list('editWorkshopUser', menu, 700, 600, url, true);	
		}
	}
	
	function updateState(type){
		var row = $('#listWorkshopForm').find('#listWorkshopTable').datagrid('getSelections');
		if (row.length < 1) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else {
			var msg = '';
			var hasAllSubmitSolution = true;
			if(type == 'published'){
				$.each(row,function(i,n){
					if(n.solutionNum<=0){
						hasAllSubmitSolution = false;
						return;
					}
				});
			}
			if(!hasAllSubmitSolution){
				$.messager.alert('提示', '选中工作坊中包含有未提交研修方案的，请重新选择！', 'warning');
				return;
			}
			msg = (type == 'published'?'确定审核通过?':'确定审核不通过?');
			$.messager.confirm('确认',msg,function(r){
			   if(r){
				   $.put("${ctx}/manage/workshop/batchUpdate", 'id='+getSelecedId()+'&state='+type, function(response){
				   		if(response.responseCode == '00'){
				   			easyui_tabs_update('listWorkshopForm','layout_center_tabs');
				   		}
				   });
			   }    
			}); 
		} 	
	}
	
	function auditWorkshop(){
		var row = $('#listWorkshopForm').find('#listWorkshopTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}
		
		var hasAllSubmitSolution = true;
		$.each(row,function(i,n){
			if(n.solutionNum<=0){
				hasAllSubmitSolution = false;
				return;
			}
		});
		if(!hasAllSubmitSolution){
			$.messager.alert('提示', '选中工作坊中包含有未提交研修方案的，请重新选择！', 'warning');
			return;
		}
		
		$('#auditForm').empty();
		$.each(row,function(i,n){
			$('#auditForm').append('<input type="hidden" name="workshops['+i+'].id" value="'+n.id+'" />');
			$('#auditForm').append('<input type="hidden" name="workshops['+i+'].title" value="'+n.title+'" />');
			var masterIds = n.masterIds;
			if(masterIds){
				$.each(masterIds.split(','),function(j,m){
					$('#auditForm').append('<input type="hidden" name="workshops['+i+'].masters['+j+'].id" value="'+m.trim()+'" />');
				});
			}
		});
		mylayerFn.open({
			id : 'auditWorkshop',
			type : 2,
			title : '工作坊审核',
			content : '${ctx}/manage/workshop/audit?' + $('#auditForm').serialize(),
			area : [700, 500],
			offset : ['auto', 'auto'],
			fix : false,
		});
	}
	
	function downloadSolution(){
		var row = $('#listWorkshopForm').find('#listWorkshopTable').datagrid('getSelections');	
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时操作多条数据', 'warning');
			return false;
		}else{
			var id = row[0].id;
			var solutionStat = row[0].solutionNum;
			if(solutionStat<=0){
				$.messager.alert('提示', '该工作坊尚未提交研修方案', 'warning');
				return false;
			}else{
				var fileName = (row[0].title||'').trim() + '-' + (row[0].master||'').trim();
				$.get('/file','relationId='+id+'&relationType=workshop_solution',function(data) {
					if (data != null && data.length>0) {
						downloadFile(data[0].id,fileName + data[0].fileName.substr(data[0].fileName.lastIndexOf('.')) );
					}else{
						$.messager.alert('提示', '研修方案文件丢失，请联系坊主重新上传', 'warning');
					}
				});
			}
		}
	}
	
	function changeToTemplate(){
		var row = $('#listWorkshopForm').find('#listWorkshopTable').datagrid('getSelections');
		if (row.length < 1) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else {
			msg = '确定评为示范性工作坊?';
			$.messager.confirm('确认',msg,function(r){
			   if(r){
				   $.put("${ctx}/manage/workshop/batchUpdate", 'id='+getSelecedId()+'&type=train&isTemplate=Y', function(response){
				   		if(response.responseCode == '00'){
				   			easyui_tabs_update('listWorkshopForm','layout_center_tabs');
				   		}
				   });
			   }    
			}); 
		} 	
	}
	
	function changeToPersonal(){
		var row = $('#listWorkshopForm').find('#listWorkshopTable').datagrid('getSelections');
		if (row.length < 1) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else {
			msg = '确定评为示范性工作坊?';
			$.messager.confirm('确认',msg,function(r){
			   if(r){
				   $.put("${ctx}/manage/workshop/batchUpdate", 'id='+getSelecedId()+'&type=personal&isTemplate=N', function(response){
				   		if(response.responseCode == '00'){
				   			easyui_tabs_update('listWorkshopForm','layout_center_tabs');
				   		}
				   });
			   }    
			}); 
		} 		
	}
	
	function getSelecedId(){
		var id = '';
		$.each($('#listWorkshopForm').serializeArray(),function(i,n){
			if(n.name == 'id'){
				if(id == ''){
					id = n.value;
				}else{
					id = id + ',' + n.value;
				}
			}
		});
		return id;
	}
	
	
</script>

