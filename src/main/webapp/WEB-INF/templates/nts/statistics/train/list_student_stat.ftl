<form id="listStudentStatForm" action="${ctx}/statistics/train/studentStat?id=${(trainStatistics.id)!}"  method ="get">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<div class="mis-srh-layout">
		<ul class="mis-ipt-lst">
	    	<li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>姓&nbsp;名：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="text" name="realName" value="${(realName[0])!}" placeholder="请输入姓名..." class="mis-ipt">
	                    </div>
	                </div>
	            </div>
	        </li>
	    </ul>
	    <div class="mis-btn-row indent1">
	        <button onclick="easyui_tabs_update('listStudentStatForm','layout_center_tabs');" type="button" class="mis-btn mis-main-btn"><i class="mis-srh-ico"></i>查询</button>
			<a onclick="resetForm(this)"  class="mis-btn mis-default-btn">
				<i class="mis-refresh-ico"></i>重置
			</a>
	    </div>
	</div>

	<div class="mis-table-layout">
		<div class="mis-table-mod">
			<table id="listStudentStatTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
				<thead>
					<tr>
						<th data-options="field:'userId',checkbox:true"></th>
						<th data-options="field:'userInfoName'">姓名</th>
						<th data-options="field:'paperworkNo'">身份证</th>
						<th data-options="field:'departmentName'">学校单位</th>
						<th data-options="field:'activityParticipateNum'">课程活动（参与人次）</th>
						<th data-options="field:'workshopParticipateNum'">工作坊任务（参与人次）</th>
						<th data-options="field:'discussionNum'">发表研说</th>
						<th data-options="field:'lessonNum'">发起创课</th>
						<th data-options="field:'movementNum'">社区活动</th>
					</tr>
				</thead>
				<tbody>
					<@statisticsTrainData queryType='studentStat' limit=(pageBounds.limit)!10 page=(pageBounds.page)!1  trainId=(trainStatistics.id)!
						realName=(realName[0])!>
						<#list trainStatisticsList as ts>
							<tr>
								<td>${(ts.userInfo.id)!}</td>
								<td>${(ts.userInfo.realName)!}</td>
								<td>身份证</td>
								<td>${(ts.userInfo.department.deptName)!}</td>
								<td>${(ts.activityParticipateNum)!}</td>
								<td>${(ts.workshopParticipateNum)!}</td>
								<td>${(ts.discussionNum)!}</td>
								<td>${(ts.lessonNum)!}</td>
								<td>${(ts.movementNum)!}</td>
							</tr>
						</#list>
					</@statisticsTrainData>
				</tbody>
	            <tfoot>
	                <tr>
	                    <td colspan="12">
	                    	 <#if paginator??>
						    	<#import "/nts/include/pagination.ftl" as p/>
						    	<@p.pagination paginator=paginator formId="listStudentStatForm" divId="content"/>
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
		$('#listStudentStatTable').datagrid();
	});
	
</script>
