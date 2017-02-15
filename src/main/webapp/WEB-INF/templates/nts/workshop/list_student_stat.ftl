<form id="listWorkshopUserResultForm" action="${ctx}/manage/workshop/studentStat?workshopId=${(workshopId)!}"  method ="get">
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
							<input type="text" name="realName" value="${(realName)!}" placeholder="" class="mis-ipt">
						</div>
					</div>
				</div>
			</li>
		</ul>
		<div class="mis-btn-row indent1">
			<button onclick="easyui_window_update('listWorkshopUserResultForm','layout_center_tabs');" type="button" class="mis-btn mis-main-btn"><i class="mis-srh-ico"></i>查询</button>
			<a onclick="resetForm(this)"  class="mis-btn mis-default-btn">
				<i class="mis-refresh-ico"></i>重置
			</a>
		</div>
	</div>

	<div class="mis-table-layout">
		<div class="mis-table-mod">
			<table id="listWorkshopUserResultTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
				<thead>
					<tr>
						<th width="50px" data-options="field:'id',checkbox:true"></th>
						<th  data-options="field:'wu.userInfo.realName'">学员姓名</th>
						<th  data-options="field:'wu.userInfo.realName'">身份证</th>
						<th  data-options="field:'deptName'">所在单位</th>
						<th  data-options="field:'deptName'">完成任务</th>
						<th  data-options="field:'deptName'">完成率</th>
						<th  data-options="field:'deptName'">教学观摩</th>
						<th  data-options="field:'deptName'">教学研讨</th>
						<th  data-options="field:'deptName'">集体备课</th>
						<th  data-options="field:'deptName'">听课评课</th>
						<th  data-options="field:'deptName'">在线测试</th>
						<th  data-options="field:'type'">提问</th>
						<th  data-options="field:'type'">上传资源</th>
						<th  data-options="field:'wu.point'">获得积分</th>
						<th  data-options="field:'wu.point'">研修考核</th>
					</tr>
				</thead>
				<tbody>
					<@workshopDirective id=workshopId getActivityNum='Y'>
						<@workshopUsersDirective getCompleteTestNum='Y' getCompleteLcecNum='Y' getCompleteLessonPlanNum='Y' getCompleteDiscussionNum='Y' getCompleteVideoNum='Y' withActionInfo='Y'  workshopId=workshopId! type="train" title=title!'' timeParam=timeParam!''  realName=realName!'' orders=orders!'CREATE_TIME.DESC' role='student'  limit=(pageBounds.limit)!10 page=(pageBounds.page)!1>
							<#if workshopUsers??>
								<#list workshopUsers as wu>
									<tr>
										<td>${wu.id}</td>
										<td>${(wu.userInfo.realName)!}</td>
										<td>${(wu.userInfo.paperworkNo)!}</td>
										<td>${(wu.userInfo.department.deptName)!}</td>
										<td>${(wu.actionInfo.activityCompleteNum)!}</td>
										<td>
											<#if (workshop.workshopRelation.activityNum)?? && (workshop.workshopRelation.activityNum>0)>
												${(wu.actionInfo.activityCompleteNum/workshop.workshopRelation.activityNum)*100}%
											<#else>
												0%
											</#if>
										</td>
										<td>${(wu.actionInfo.completeVideoNum)!}</td>
										<td>${(wu.actionInfo.completeDiscussionNum)!}</td>
										<td>${(wu.actionInfo.completeLessonPlanNum)!}</td>
										<td>${(wu.actionInfo.completeLcecNum)!}</td>
										<td>${(wu.actionInfo.completeTestNum)!}</td>
										<td>${(wu.actionInfo.faqQuestionNum)!}</td>
										<td>${(wu.actionInfo.uploadResourceNum)!}</td>
										<td>${(wu.workshopUserResult.point)!0}</td>
										<td>
											<#if (wu.workshopUserResult.point)?? && (workshop.qualifiedPoint)?? && (wu.workshopUserResult.point >= workshop.qualifiedPoint)>
												${(wu.workshopUserResult.workshopResult)!}
											<#else>
												未达标
											</#if>
										</td>
									</tr>
								</#list>					
							</#if>
						</@workshopUsersDirective>
					</@workshopDirective>
				</tbody>
	            <tfoot>
	                <tr>
	                    <td colspan="15">
	                    	 <#if paginator??>
						    	<#import "/nts/include/pagination.ftl" as p/>
						    	<@p.pagination paginator=paginator formId="listWorkshopUserResultForm" divId="content"/>
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
		$('#listWorkshopUserResultTable').datagrid();
	});

	function resetForm(){
		$('#listWorkshopUserResultForm').form('clear');
		$('#timeParam').combobox('select','');
		easyui_tabs_update('listWorkshopUserResultForm','layout_center_tabs');
	}
	
</script>

