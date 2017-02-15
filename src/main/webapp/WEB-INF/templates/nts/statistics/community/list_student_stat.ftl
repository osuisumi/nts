<form id="listSchoolStatForm" action="${ctx}/statistics/community/studentStat?train.id=${(communityStatistics.train.id)!}"  method ="get">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<div class="mis-srh-layout">
		<ul class="mis-ipt-lst">
			<li class="item">
				<div class="mis-ipt-row">
					<div class="tl">
						<span>学校单位名称：</span>
					</div>
					<div class="tc">
						<div class="mis-ipt-mod">
							<input type="text" name="userInfo.department.deptName" value="${(trainStatistics.userInfo.department.deptName)!}" placeholder="请输入学校单位名称..." class="mis-ipt">
						</div>
					</div>
				</div>
			</li>
		</ul>
		<div class="mis-btn-row indent1">
			<button onclick="easyui_window_update('listSchoolStatForm','layout_center_tabs');" type="button" class="mis-btn mis-main-btn">
				<i class="mis-srh-ico"></i>查询
			</button>
			<a onclick="resetForm(this)"  class="mis-btn mis-default-btn">
				<i class="mis-refresh-ico"></i>重置
			</a>
		</div>
	</div>
	<div class="mis-table-layout">
		<div class="mis-table-mod">
			<table id="listSchoolStatTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
				<thead>
					<tr>
						<th data-options="field:'userId',checkbox:true"></th>
						<th data-options="field:'userInfoName'">姓名</th>
						<th data-options="field:'paperworkNo'">用户名（身份证）</th>
						<th data-options="field:'departmentName'">学校单位</th>
						<th data-options="field:'signNum'">签到天数</th>
						<th data-options="field:'discussionNum'">发表研说</th>
						<th data-options="field:'lessonNum'">创课想法</th>
						<th data-options="field:'movementNum'">参与活动</th>
						<th data-options="field:'score'">获得积分</th>
						<th data-options="field:'state'">社区成绩</th>
					</tr>
				</thead>
				<tbody>
					<@statisticsCommunityData queryType='studentStat' deptName=(communityStatistics.userInfo.department.deptName)!'' trainId=(communityStatistics.train.id)!''
						limit=(pageBounds.limit)!10 page=(pageBounds.page)!1 >
						<#list communityStatisticsList as cs>
								<tr>
									<td>${(cs.userInfo.id)!}</td>
									<td>${(cs.userInfo.realName)!}</td>
									<td>${(cs.userInfo.paperworkNo)!}</td>
									<td>${(cs.userInfo.department.deptName)!}</td>
									<td>${(cs.signStat.signNum)!}</td>
									<td>${(cs.discussionNum)!}</td>
									<td>${(cs.lessonNum)!}</td>
									<td>${(cs.movementNum)!}</td>
									<td>${(cs.userScore)!}/${(cs.score)!}</td>
									<td>
										<#if ((cs.state)!'') == 'passed'>
											合格
										<#elseif ((cs.state)!'') == 'excellent'>
											优秀
										<#else>
											不合格
										</#if>
									</td>
								</tr>
						</#list>					
					</@statisticsCommunityData>
				</tbody>
	            <tfoot>
	                <tr>
	                    <td colspan="13">
	                    	 <#if paginator??>
						    	<#import "/nts/include/pagination.ftl" as p/>
						    	<@p.pagination paginator=paginator formId="listSchoolStatForm" divId="content"/>
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
		$('#listSchoolStatTable').datagrid();
	});

	function resetForm(){
		$('#listSchoolStatForm').form('clear');
		$('#timeParam').combobox('select','');
		easyui_tabs_update('listSchoolStatForm','layout_center_tabs');
	}
	
</script>

