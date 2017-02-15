<form id="listCmtsStatForm" action="${ctx}/manage/nts/cmts/stat">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	
	<div class="mis-srh-layout">
	    <ul class="mis-ipt-lst">
	    	<li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>作者：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="text" name="realName" value="${(realName[0])!}" placeholder="作者..." class="mis-ipt">
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
	                        <input type="text" name="deptName" value="${(deptName[0])!}" placeholder="单位..." class="mis-ipt">
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
	                        <select id="stateSelect" name="state">
								<option value="">请选择...</option>
								<option value="excellent">优秀学员</option>
	                        </select>    
	                        <script>
	                        	$(function(){
	    				        	$('#listCmtsStatForm #stateSelect option[value="${(state[0])!""}"]').prop('selected', true);
	                        	});
	                        </script>
	                    </div>
	                </div>
	            </div>
	        </li>
	        <li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>排序方式：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-select">
	                        <select id="orderSelect" name="orders" >
								<option value="START_TIME.DESC">按培训开展时间排序</option>
								<option value="SCORE.DESC">按培训期积分排序</option>
								<option value="DISCUSSION_NUM.DESC">按发表研说次数排序</option>
								<option value="LESSON_NUM.DESC">按发表创课次数排序</option>
	                        </select>    
	                        <script>
	                        	$(function(){
	    				        	$('#listCmtsStatForm #orderSelect option[value="${(orders[0])!""}"]').prop('selected', true);
	                        	});
	                        </script>
	                    </div>
	                </div>
	            </div>
	        </li>
	    </ul>
	    <div class="mis-btn-row indent1">
	        <button onclick="easyui_tabs_update('listCmtsStatForm','layout_center_tabs');" type="button" class="mis-btn mis-main-btn"><i class="mis-srh-ico"></i>查询</button>
			<a onclick="resetForm(this)"  class="mis-btn mis-default-btn">
				<i class="mis-refresh-ico"></i>重置
			</a>
	    </div>
	</div>
	<div class="mis-table-layout">
	    <div class="mis-opt-row">
	        <div class="mis-opt-mod fl">
	            <button onclick="editCommunityResultState()" type="button" class="mis-btn mis-inverse-btn"><i class="mis-result-ico"></i>社区评优</button>
	        </div>
	    </div>
		<div class="mis-table-mod">
	        <table id="listCmtsStatTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
	            <thead>
					<tr>
						<th data-options="field:'id',checkbox:true"></th>
						<th data-options="field:'realName'">姓名</th>
						<th data-options="field:'trainName'">培训名</th>
						<th data-options="field:'deptName'">所在单位</th>
						<th data-options="field:'discussion_num'">发表研说</th>
						<th data-options="field:'lesson_num'">发表创课</th>
						<th data-options="field:'signNum'">签到天数</th>
						<th data-options="field:'score'">培训期积分</th>
						<th data-options="field:'state'">评优</th>
					</tr>
				</thead>
				<tbody>
					<@communityResultsDirective state=(state[0])!'' realName=(realName[0])!'' deptName=(deptName[0])!'' page=(pageBounds.page)!1 limit=(pageBounds.limit)!10 orders=(orders[0])!'START_TIME.DESC'>
						<#assign communityResults=communityResults>
					</@communityResultsDirective>
					
					<#assign trainIds = []>
					<#list communityResults as result>
						<#if '' != (result.relation.id)!''>
							<#assign trainIds = trainIds + [result.relation.id]>
						</#if>
					</#list>
						
					<#if (trainIds?size>0)>
						<@trainMapDirective ids=trainIds>
							<#assign trainMap=trainMap>
						</@trainMapDirective>
					</#if>
						
					<#list communityResults as result>
						<tr>
							<td>${(result.id)!}</td>
							<td>${(result.user.realName)!}</td>
							<td>${(trainMap[result.relation.id].name)!}</td>
							<td>${(result.user.deptName)!}</td>
							<td>${(result.discussionNum)!0}</td>
							<td>${(result.lessonNum)!0}</td>
							<td>${(result.signStat.signNum)!0}</td>
							<td>${(result.score)!0}</td>
							<td>
								<#if 'excellent' == (result.state)!''>
									优秀学员
								<#elseif 'passed' == (result.state)!''>
									合格
								<#else>
									--
								</#if>
							</td>
						</tr>
					</#list>
				</tbody>
	            <tfoot>
	                <tr>
	                    <td colspan="10">
	                    	 <#if paginator??>
						    	<#import "/nts/include/pagination.ftl" as p/>
						    	<@p.pagination paginator=paginator formId="listCmtsStatForm" divId="content"/>
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
	$('#listCmtsStatTable').datagrid();
});

function editCommunityResultState(){
	var row = $('#listCmtsStatForm').find('#listCmtsStatTable').datagrid('getSelections');	
	if (row.length == 0) {
		$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
		return false;
	}else {
		var row = $('#listCmtsStatForm').find('#listCmtsStatTable').datagrid('getSelections');
		var realName = '';
		var isReturn = false;
		$(row).each(function(){
			if(this.state.trim() == '--'){
				isReturn = true;
				return false;
			}
			realName = realName + this.realName.trim() + '、';
		});
		if(isReturn){
			alert('未合格的学员不能评选优秀, 请重新勾选');
			return false;
		}
		realName = realName.substring(0, realName.length - 1);
		easyui_modal_open('editCommunityResultStateDiv', '社区评优', 600, 350, '${ctx}/manage/nts/cmts/stat/editCommunityResultState?user.realName='+realName+'&'+$('#listCmtsStatForm').serialize(), true);
	}
}
</script>

