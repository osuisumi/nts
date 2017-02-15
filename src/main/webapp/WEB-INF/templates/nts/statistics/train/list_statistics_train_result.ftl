<form id="listStatisticsResultTrainForm" action="${ctx!}/statistics/train/result" method="get">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<input type="hidden" value="${(trainResultStatistics.train.id)!}" name="train.id">
	<div class="mis-table-layout">
		<div class="mis-table-mod">
			<table id="listStatisticsResultTrainTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
				<thead>
					<tr>
						<th data-options="field:'userId',checkbox:true">序号</th>
						<th data-options="field:'name'">姓名</th>
						<th data-options="field:'projectName'">单位</th>
						<th data-options="field:'trainTime'">学科</th>
						<th data-options="field:'trainHeadcount'">学段</th>
						<th data-options="field:'passProportion'">课程成绩</th>
						<th data-options="field:'passHeadcount'">工作坊成绩</th>
						<th data-options="field:'courseNum'">研修社区成绩</th>
						<th data-options="field:'workshopNum'">操作</th>
					</tr>
				</thead>
				<tbody>
					<@statisticsTrainResultData trainId=(trainResultStatistics.train.id)! pageBounds=pageBounds!>
						<#if (trainResultStatistics)?size gt 0 >
							<#list trainResultStatistics as t>
								<tr>
									<td>${(t.userInfo.id)!}</td>
									<td>${(t.userInfo.realName)!}</td>
									<td>${(t.userInfo.department.deptName)!}</td>
									<td>${(t.userInfo.subject)!}</td>
									<td>${(t.userInfo.stage)!}</td>
									<td></td>
									<td <#if ((t.workshopScore)?number lt 60) && ((t.workshopScore)?number gt 0)>style="color:red"</#if>>
										${(t.workshopScore)!0}
									</td>
									<td>${(t.communityScore)!0}</td>
									<td><a>推荐为优秀学员</a></td>
								</tr>
							</#list>
						</#if>
					</@statisticsTrainResultData>
				</tbody>
				<tfoot>
	                <tr>
	                    <td colspan="9">
	                    	 <#if paginator??>
						    	<#import "/nts/include/pagination.ftl" as p/>
						    	<@p.pagination paginator=paginator formId="listStatisticsResultTrainForm" divId="content"/>
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
		$('#listStatisticsResultTrainTable').datagrid();
	});
</script>