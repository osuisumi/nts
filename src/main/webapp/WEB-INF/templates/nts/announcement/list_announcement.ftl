<form id="listAnnouncementForm" action="${ctx}/manage/announcement"  method="get">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<div class="mis-srh-layout">
		<ul class="mis-ipt-lst">
			<li class="item">
				<div class="mis-ipt-row">
					<div class="tl">
						<span>标题：</span>
					</div>
					<div class="tc">
						<div class="mis-ipt-mod">
							<input type="text" name="title" value="${(title[0])!}" placeholder="请输入标题..." class="mis-ipt">
						</div>
					</div>
				</div>
			</li>
		</ul>
		<div class="mis-btn-row indent1">
			<button onclick="easyui_tabs_update('listAnnouncementForm','layout_center_tabs');" type="button" class="mis-btn mis-main-btn">
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
				<button onclick="addAnnouncement();" type="button" class="mis-btn mis-inverse-btn">
					<i class="mis-add-ico"></i>新建
				</button>
				<button onclick="editAnnouncement();" type="button" class="mis-btn mis-inverse-btn">
					<i class="mis-alter-ico"></i>修改
				</button>
				<button onclick="deleteAnnouncement();"  type="button" class="mis-btn mis-inverse-btn" >
					<i class="mis-delete-ico"></i>删除
				</button>
			</div>
		</div>
		<div class="mis-table-mod">
			<table id="listAnnouncementTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
				<thead>
					<tr>
						<th data-options="field:'id',checkbox:true"></th>
						<th data-options="field:'title'">标题</th>
						<th data-options="field:'createTime'">发布时间</th>
						<th data-options="field:'creator'">发布人</th>
						<th data-options="field:'relationType'">发布类型</th>
					</tr>
				</thead>
				<tbody>
					<@announcementsDirective title=(title[0])!'' page=pageBounds.page limit=pageBounds.limit orders='CREATE_TIME.DESC' >
						<#list announcements as announcement>
							<tr>
								<td>${announcement.id}</td>
								<td>${announcement.title}</td>
								<td>${TimeUtils.formatDate(announcement.createTime, 'yyyy-MM-dd') }
								<td>${announcement.creator.realName}</td>
								<td>
									<#if (announcement.announcementRelations[0].relation.type)! == 'workshop'>
										工作坊通知
									<#elseif (announcement.announcementRelations[0].relation.type)! == 'userCenter'>
										培训通知
									<#else>
										----
									</#if>
								</td>
							</tr>
						</#list>
					</@announcementsDirective>
				</tbody>
	            <tfoot>
	                <tr>
	                    <td colspan="12">
	                    	 <#if paginator??>
						    	<#import "/nts/include/pagination.ftl" as p/>
						    	<@p.pagination paginator=paginator formId="listAnnouncementForm" divId="content"/>
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
		$('#listAnnouncementTable').datagrid();
	});
	
	function addAnnouncement(relationId) {
		var url = '${ctx}/manage/announcement/create?announcementRelations[0].relation.id=system';
		easyui_modal_open('editAnnouncementDiv', '发布通知', 900, 700, url, true);
	}

	function editAnnouncement() {
		var row = $('#listAnnouncementForm').find('#listAnnouncementTable').datagrid('getSelections');	
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时编辑多条数据', 'warning');
			return false;
		}else {
			var id = row[0].id;
			easyui_modal_open('editAnnouncementDiv', '编辑通知', 900, 700, '${ctx}/manage/announcement/'+id+'/edit', true);
		}
	}
	
	function deleteAnnouncement(){
		var row = $('#listAnnouncementForm').find('#listAnnouncementTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else {
			$.messager.confirm('确认','确认要删除选中记录吗？',function(r){
			   if(r){
			   	   var id = row[0].id;
				   $.ajaxDelete("${ctx}/manage/announcement", $('#listAnnouncementForm').serialize(), function(response){
				   		if(response.responseCode == '00'){
				   			easyui_tabs_update('listAnnouncementForm','layout_center_tabs')
				   		}
				   });
			   }    
			}); 
		} 
	}
	
	function updateAnnouncementState(state){
		var row = $('#listAnnouncementForm').find('#listAnnouncementTable').datagrid('getSelections');
		var msg = '确定要通过所选课程的审核吗?';
		if(state == 'reject'){
			msg = '确定驳回所选课程的审核吗?'
		}
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else {
			$.messager.confirm('确认',msg,function(r){    
			    if (r){    
			    	$('#listAnnouncementForm input[name=state]').remove();
					$.put('${ctx}/manage/announcement', 'state='+state+'&'+$('#listAnnouncementForm').serialize(), function(){
						easyui_tabs_update('listAnnouncementForm', 'layout_center_tabs');
					});
			    }    
			}); 
		}
	}
	
	function editAnnouncementAuthorize(){
		easyui_modal_open('editAnnouncementAuthorizeDiv', '课程制作授权', 700, 600, '${ctx}/manage/announcement/editAnnouncementAuthorize', true);		
	}
</script>

