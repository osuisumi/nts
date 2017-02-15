<form id="listTrainAuthorizeForm" action="${ctx}/manage/train/authorize/${trainId}"  method ="get">
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
							<input type="text" name="user.realName" value="${(trainAuthorize.user.realName)!}" placeholder="" class="mis-ipt">
						</div>
					</div>
				</div>
			</li>
		</ul>
		<div class="mis-btn-row indent1">
			<button onclick="easyui_tabs_update('listTrainAuthorizeForm','layout_center_tabs');" type="button" class="mis-btn mis-main-btn"><i class="mis-srh-ico"></i>查询</button>
			<a onclick="resetForm(this)"  class="mis-btn mis-default-btn">
				<i class="mis-refresh-ico"></i>重置
			</a>
		</div>
	</div>

	<div class="mis-table-layout">
		<div class="mis-opt-row">
			<div class="mis-opt-mod fl">
				<!--<a href="###" onclick="addTrain()" class="mis-btn mis-inverse-btn"><i class="mis-add-ico"></i>新建</a>-->
				<button onclick="deleteTrainAuthorize()" type="button" class="mis-btn mis-inverse-btn" >
					<i class="mis-delete-ico"></i>删除
				</button>
				<button type="button" class="mis-btn mis-inverse-btn" onclick="goImportTrainAuthorize('${trainId}')">
					<i class="mis-import-ico"></i>导入
				</button>
			</div>
		</div>
		<div class="mis-table-mod">
			<table id="listTrainAuthorizeTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
				<thead>
					<tr>
						<th width="50px" data-options="field:'id',checkbox:true"></th>
						<th  data-options="field:'name'">姓名</th>
						<th  data-options="field:'project.deptName'">单位</th>
					</tr>
				</thead>
				<tbody>
					<@trainAuthorizesDirective trainId=trainId realName=(trainAuthorize.user.realName)! page=(pageBounds.page)!1 orders=orders!'CREATE_TIME.DESC'>
						<#if trainAuthorizes??>
							<#list trainAuthorizes as ta>
								<tr>
									<td>${ta.id}</td>
									<td>${(ta.user.realName)!}</td>
									<td>${(ta.user.deptName)!}</td>
								</tr>
							</#list>					
						</#if>
					</@trainAuthorizesDirective>
				</tbody>
	            <tfoot>
	                <tr>
	                    <td colspan="9">
	                    	 <#if paginator??>
						    	<#import "/nts/include/pagination.ftl" as p/>
						    	<@p.pagination paginator=paginator formId="listTrainAuthorizeForm" divId="list_content"/>
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
		$('#listTrainAuthorizeTable').datagrid();
	});

	function goImportTrainAuthorize(trainId){
		load_next_content('${ctx}/manage/train/authorize/goImport?trainId='+trainId, 'listTrainAuthorizeForm', "导入助学");
	}
	
	function deleteTrainAuthorize(){
		var row = $('#listTrainAuthorizeForm').find('#listTrainAuthorizeTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}  else {
			$.messager.confirm('确认', '确认要删除选中记录吗？', function(r) {
				if (r) {
					$.ajaxDelete("${ctx}/manage/train/authorize/deleteByLogic", $('#listTrainAuthorizeForm').serialize(), function(response) {
						if (response.responseCode == '00') {
							easyui_window_update('listTrainAuthorizeForm', 'layout_center_tabs');
						}
					});
				}
			});
		}
	}
	
</script>