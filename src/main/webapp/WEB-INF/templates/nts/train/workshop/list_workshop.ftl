<form id="listWorkshopForm" action="${ctx}/manage/train/workshop"  method ="get">
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
			<button onclick="editTrainConfig()"  type="button" class="mis-btn mis-inverse-btn" >
				<i class="mis-setting-ico"></i>培训设置
			</button>
			<button onclick="editWorkshopUser('student')"  type="button" class="mis-btn mis-inverse-btn" >
				<i class="mis-setting-ico"></i>分配学员
			</button>
			<button type="button" class="mis-btn mis-inverse-btn" onclick="goImportStudent()">
				<i class="mis-import-ico"></i>导入学员
			</button>
			<button onclick="editWorkshopUser('master')" type="button" class="mis-btn mis-inverse-btn">
				<i class="mis-authorization-ico"></i>授权坊主
			</button>
			<button onclick="editWorkshopUser('member')" type="button" class="mis-btn mis-inverse-btn">
				<i class="mis-authorization-ico"></i>授权助理坊主
			</button>
			<button onclick="createExtendWorkshop()" type="button" class="mis-btn mis-inverse-btn">
				<i class="mis-add-ico"></i>分坊管理
			</button>			
		</div>
	</div>
	<div class="mis-table-mod">
		<table id="listWorkshopTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
			<thead>
				<tr>
					<th width="50px" data-options="field:'id',checkbox:true"></th>
					<th  data-options="field:'train'">培训</th>
					<th  data-options="field:'title'">工作坊名称</th>
					<th  data-options="field:'stage'">学段</th>
					<th  data-options="field:'subject'">学科</th>
					<th  data-options="field:'master'">坊主</th>
					<th  data-options="field:'master'">助理坊主</th>
					<th  data-options="field:'master'">学员人数</th>
					<th  data-options="field:'master'">有效学时</th>
					<th data-options="field:'qualifiedPoint'">达标积分</th>
					<th  data-options="field:'trainTime'">研修时间</th>
					<th data-options="field:'trainId',hidden:true">培训id</th>
				</tr>
			</thead>
			<tbody>
				<@workshopsDirective withStat='Y' getMemberNum="Y" getStudentNum="Y" limit=(pageBounds.limit)!10 orders=orders!'CREATE_TIME.DESC' page=(pageBounds.page)!1 title=(workshop.title)! isTemplate=(workshop.isTemplate)! relationIdInTrain="Y" type="train" getTrainName='Y'>
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
								<td>${workshop.id}</td>
								<td>${(workshop.trainName)!}</td>
								<td>${workshop.title}</td>
								<td>${TextBookUtils.getEntryName('STAGE',(workshop.stage)!'')}</td>
								<td>${TextBookUtils.getEntryName('SUBJECT',(workshop.subject)!'')}</td>
								<td>
									<#if (workshopUserMap[workshop.id])??>
										<#list workshopUserMap[workshop.id] as master>
											${(master.userInfo.realName)!}
										</#list>
									</#if>
								</td>
								<td>${(workshop.workshopRelation.memberNum)!}</td>
								<td>${(workshop.workshopRelation.studentNum)!}</td>
								<td>${(workshop.studyHours)!}</td>
								<td>${(workshop.qualifiedPoint)!}</td>
								<td>${(workshop.timePeriod.startTime?string("yyyy-MM-dd"))!}-${(workshop.timePeriod.endTime?string("yyyy-MM-dd"))!}</td>
								<td>${(workshop.workshopRelation.relation.id)}</td>
							</tr>
						</#list>					
					</#if>
				</@workshopsDirective>
			</tbody>
            <tfoot>
                <tr>
                    <td colspan="999">
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
<script>
	$(function(){
		$('#listWorkshopTable').datagrid();
	});
	
	function editTrainConfig(){
		var row = $('#listWorkshopForm').find('#listWorkshopTable').datagrid('getSelections');	
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时操作多条数据', 'warning');
			return false;
		}else{
			var id = row[0].id;
			var url = "${ctx}/manage/train/workshop/editTrainConfig/"+id;
			easyui_modal_open('editTrainConfig', '培训设置', 700, 600, url, true);	
		}
	}
	
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
	
	
	
	function createExtendWorkshop(){
		var row = $('#listWorkshopForm').find('#listWorkshopTable').datagrid('getSelections');	
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时操作多条数据', 'warning');
			return false;
		}else{
			var id = row[0].id;
			var url = "${ctx}/manage/train/workshop/createExtendWorkshop/"+id;
			easyui_modal_open_list('editExtendWorkshop', '分坊管理', 700, 600, url, true);	
		}
	}
	
	function goImportStudent(){
		var row = $('#listWorkshopForm').find('#listWorkshopTable').datagrid('getSelections');	
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时操作多条数据', 'warning');
			return false;
		}else{
			var id = row[0].id;
			var url = "${ctx}/manage/train/workshop/workshopStudent/goImport?workshopId="+id;
			easyui_modal_open_list('importWorkshopStudent', '导入工作坊学员', 700, 600, url, true);	
		}
	}

	
</script>

