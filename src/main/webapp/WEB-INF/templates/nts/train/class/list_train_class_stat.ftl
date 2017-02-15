<form id="listTrainClassStatForm" action="${ctx}/train/class/stat"  method ="get">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<div class="mis-srh-layout">
		<ul class="mis-ipt-lst">
			<li class="item">
				<div class="mis-ipt-row">
					<div class="tl">
						<span>培训名称：</span>
					</div>
					<div class="tc">
						<div class="mis-ipt-mod">
							<input type="text" name="train.name" value="${(trainClassStat.train.name)!}" placeholder="请输入名称..." class="mis-ipt">
						</div>
					</div>
				</div>
			</li>
		</ul>
		<div class="mis-btn-row indent1">
			<button onclick="easyui_tabs_update('listTrainClassStatForm','layout_center_tabs');" type="button" class="mis-btn mis-main-btn"><i class="mis-srh-ico"></i>查询</button>
			<a onclick="resetForm(this)"  class="mis-btn mis-default-btn">
				<i class="mis-refresh-ico"></i>重置
			</a>
		</div>
	</div>

	<div class="mis-table-layout">
		<div class="mis-opt-row">
			<div class="mis-opt-mod fl">
				<a href="###" onclick="listTrainClass()" class="mis-btn mis-inverse-btn"><i class="mis-add-ico"></i>分班管理</a>
			</div>
		</div>
		<div class="mis-table-mod">
			<table id="listTrainClassStatTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
				<thead>
					<tr>
						<th width="50px" data-options="field:'id',checkbox:true"></th>
						<th  data-options="field:'name'">项目</th>
						<th  data-options="field:'project.name'">培训</th>
						<th  data-options="field:'description'">学员人数</th>
						<th  data-options="field:'trainingTime'">班级个数</th>
						<th  data-options="field:'registerTime'">已分班</th>
						<th  data-options="field:'electivesTime'">未分班</th>
					</tr>
				</thead>
				<tbody>
					<@trainClassStatsDirective page=(pageBounds.page)!1 orders=orders!'CREATE_TIME.DESC' limit=(pageBounds.limit)!10 name=(trainClassStat.train.name)!''>
						<#if trainClassStats??>
							<#list trainClassStats as tcs>
								<tr>
									<td>${tcs.train.id}</td>
									<td>${(tcs.train.project.name)!}</td>
									<td>${(tcs.train.name)!}</td>
									<td>${(tcs.registerNum)!}</td>
									<td>${(tcs.classNum)!}</td>
									<td>${(tcs.classRegisterNum)!}</td>
									<td>${(tcs.registerNum - tcs.classRegisterNum)!}</td>
								</tr>
							</#list>					
						</#if>
					</@trainClassStatsDirective>
				</tbody>
	            <tfoot>
	                <tr>
	                    <td colspan="9">
	                    	 <#if paginator??>
						    	<#import "/nts/include/pagination.ftl" as p/>
						    	<@p.pagination paginator=paginator formId="listTrainClassStatForm" divId="content"/>
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
		$('#listTrainClassStatTable').datagrid();
	});
	
	function listTrainClass(){
		var row = $('#listTrainClassStatForm').find('#listTrainClassStatTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时操作多条数据', 'warning');
			return false;
		}else{
			var id = row[0].id;
			load_next_content('${ctx}/manage/train/class?relation.id='+id, null, '分班管理');
		}
	}
	
</script>