<form id="listSchoolStatForm" action="${ctx}/manage/workshop/schoolStat?workshopId=${(workshopId)!}"  method ="get">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<div class="mis-srh-layout">
	    <ul class="mis-ipt-lst">
	    	<li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>学&nbsp;校&nbsp;名：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="text" name="deptName" value="${(deptName[0])!}" placeholder="请输入学校名" class="mis-ipt">
	                    </div>
	                </div>
	            </div>
	        </li>
	    </ul>
		<div class="mis-btn-row indent1">
			<button onclick="easyui_window_update('listSchoolStatForm','layout_center_tabs');" type="button" class="mis-btn mis-main-btn"><i class="mis-srh-ico"></i>查询</button>
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
						<th  data-options="field:'deptName'">学校</th>
						<th  data-options="field:'memberNum'">管理成员</th>
						<th  data-options="field:'studentNum'">学员</th>
						<th  data-options="field:'studentNum'">通过率</th>
						<!--<th  data-options="field:'activityNum'">任务数</th>
						<th  data-options="field:'activityNum'">完成率</th>-->
						<th  data-options="field:'activityNum'">教学观摩</th>
						<th  data-options="field:'activityNum'">教学研讨</th>
						<th  data-options="field:'activityNum'">集体备课</th>
						<th  data-options="field:'activityNum'">听课评课</th>
						<th  data-options="field:'activityNum'">在线测试</th>
						<th  data-options="field:'questionNum'">提问量</th>
						<th  data-options="field:'questionNum'">回答量</th>
						<th  data-options="field:'resourceNum'">资源数</th>
						<th  data-options="field:'commentNum'">评论</th>
						<th  data-options="field:'birefNum'">通知简报</th>
					</tr>
				</thead>
				<tbody>
					<@departmentWorkshopStatDirective deptName=(deptName[0])! type='school' workshopId=workshopId! orders=(orders)!'STUDENT_NUM.DESC' limit=(pageBounds.limit)!10 page=(pageBounds.page)!1>
						<#if departmentWorkshopStats??>
							<#list departmentWorkshopStats as dws>
								<tr>
									<td>${(dws.department.deptName)!}</td>
									<td>${(dws.memberNum)!}</td>
									<td>${(dws.studentNum)!}</td>
									<td>
										<#if (dws.studentNum)?? && (dws.studentNum>0)>
											${(dws.qualifiedStudentNum/dws.studentNum)*100}%
										<#else>
										0%
										</#if>
									</td>
									<!--<td>${(dws.activityNum)!}</td>
									<td>
										<#if (dws.activityNum)?? && (dws.activityNum>0)>
											${(dws.completeActivityNum/dws.activityNum)*100}%
										<#else>
										0%
										</#if>									
									</td>-->
									<td>${(dws.completeVideoNum)!}</td>
									<td>${(dws.completeDiscussionNum)!}</td>
									<td>${(dws.completeLessonPlanNum)!}</td>
									<td>${(dws.completeLcecNum)!}</td>
									<td>${(dws.completeTestNum)!}</td>
									<td>${(dws.questionNum)!}</td>
									<td>${(dws.answerNum)!}</td>
									<td>${(dws.resourceNum)!}</td>
									<td>${(dws.commentsNum)!}</td>
									<td>${(dws.announcementNum)!}</td>
								</tr>
							</#list>					
						</#if>
				</tbody>
	            <tfoot>
	                <tr>
	                    <td colspan="17">
	                    	 <#if paginator??>
						    	<#import "/nts/include/pagination.ftl" as p/>
						    	<@p.pagination paginator=paginator formId="listSchoolStatForm" divId="list_content"/>
							</#if>
	                    </td>
	                </tr>
	            </tfoot>
			</table>
			</@departmentWorkshopStatDirective>
		</div>
	</div>
</form>

