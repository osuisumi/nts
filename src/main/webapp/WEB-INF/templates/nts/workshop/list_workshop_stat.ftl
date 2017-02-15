<form id="listWorkshopStatForm" action="${ctx}/manage/workshop/stat"  method ="get">
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
		<button onclick="easyui_tabs_update('listWorkshopStatForm','content');" type="button" class="mis-btn mis-main-btn" >
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
			<button onclick="viewStat('areaStat')" type="button" class="mis-btn mis-inverse-btn">
				<i class="mis-look-ico"></i>查看区域统计
			</button>
			<button onclick="viewStat('schoolStat')" type="button" class="mis-btn mis-inverse-btn">
				<i class="mis-look-ico"></i>查看学校统计
			</button>
			<button onclick="viewStat('studentStat')" type="button" class="mis-btn mis-inverse-btn">
				<i class="mis-look-ico"></i>查看工作坊学员统计
			</button>
		</div>
	</div>
	<div class="mis-table-mod">
		<table id="listWorkshopStatTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
			<thead>
				<tr>
					<th width="50px" data-options="field:'id',checkbox:true"></th>
					<th  data-options="field:'title'">工作坊名称</th>
					<th  data-options="field:'type'">类型</th>
					<th  data-options="field:'title'">所属培训</th>
					<th  data-options="field:'master'">坊主</th>
					<th  data-options="field:'memberNum'">管理成员</th>
					<th  data-options="field:'studentNum'">学员</th>
					<th  data-options="field:'studentNum'">通过率</th>
					<th  data-options="field:'activityNum'">任务数</th>
					<th  data-options="field:'activityNum'">完成率</th>
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
					<!--<th  data-options="field:'questionNum'">优秀工作坊</th>-->
				</tr>
			</thead>
			<tbody>
				<@workshopsDirective getAnswerNum='Y' getCompleteTestNum='Y' getCompleteLcecNum='Y' getCompleteLessonPlanNum='Y' getCompleteDiscussionNum='Y' getCompleteVideoNum='Y' getQualifiedStudentNum='Y' getCompleteActivityNum='Y' getAnnouncementNum='Y' getCommentsNum='Y' getActivityNum='Y' getMemberNum='Y' getStudentNum='Y' getQuestionNum='Y' getResourceNum='Y' relationIdInTrain='Y'  withStat='Y' limit=(pageBounds.limit)!10 orders=orders!'CREATE_TIME.DESC' page=(pageBounds.page)!1 title=(workshop.title)!  getTrainName='Y'>
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
								<td>${workshop.title}</td>
								<td>
									<#if (workshop.type)?? && workshop.type = 'train'>
										项目工作坊
									<#else>
										个人工作坊
									</#if>
								</td>
								<td>${(workshop.trainName)!}</td>
								<td>
									<#if (workshopUserMap[workshop.id])??>
										<#list workshopUserMap[workshop.id] as master>
											${(master.userInfo.realName)!}
										</#list>
									</#if>
								</td>
								<td>${(workshop.workshopRelation.memberNum)!}</td>
								<td>${(workshop.workshopRelation.studentNum)!}</td>
								<td>
									<#if (workshop.workshopRelation.studentNum)?? && (workshop.workshopRelation.studentNum>0)>
										${(workshop.workshopRelation.qualifiedStudentNum/workshop.workshopRelation.studentNum)*100}%
									<#else>
									0%
									</#if>
								</td>
								<td>${(workshop.workshopRelation.activityNum)!}</td>
								<td>
									<#if (workshop.workshopRelation.activityNum)?? && (workshop.workshopRelation.activityNum>0) && (workshop.workshopRelation.studentNum)?? && (workshop.workshopRelation.studentNum>0)>
										${(workshop.workshopRelation.completeActivityNum/(workshop.workshopRelation.activityNum*workshop.workshopRelation.studentNum))*100}%
									<#else>
									0%
									</#if>									
								</td>
								<td>${(workshop.workshopRelation.completeVideoNum)!}</td>
								<td>${(workshop.workshopRelation.completeDiscussionNum)!}</td>
								<td>${(workshop.workshopRelation.completeLessonPlanNum)!}</td>
								<td>${(workshop.workshopRelation.completeLcecNum)!}</td>
								<td>${(workshop.workshopRelation.completeTestNum)!}</td>
								<td>${(workshop.workshopRelation.questionNum)!}</td>
								<td>${(workshop.workshopRelation.answerNum)!}</td>
								<td>${(workshop.workshopRelation.resourceNum)!}</td>
								<td>${(workshop.workshopRelation.commentsNum)!}</td>
								<td>${(workshop.workshopRelation.announcementNum)!}</td>
								<!--<td>优秀工作坊</td>-->
							</tr>
						</#list>					
					</#if>
				</@workshopsDirective>
			</tbody>
            <tfoot>
                <tr>
                    <td colspan="21">
                    	 <#if paginator??>
					    	<#import "/nts/include/pagination.ftl" as p/>
					    	<@p.pagination paginator=paginator formId="listWorkshopStatForm" divId="content"/>
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
		$('#listWorkshopStatTable').datagrid();
	});
	
	function viewStat(type){
		var row = $('#listWorkshopStatForm').find('#listWorkshopStatTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一个工作坊查看', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时查看多个工作坊', 'warning');
			return false;
		}else{
			var id = row[0].id;
			easyui_modal_open_list('statDiv', '查看统计', 700, 600, '${ctx}/manage/workshop/'+type + '?workshopId=' + id, true);
		}
	}
	
</script>

