<form id="listStatisticsTrainForm" action="${ctx!}/statistics/train" method="get">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<input type="hidden" name="movement.id" value="${(movementRegister.movement.id)!}">
	<div class="mis-srh-layout">
		<ul class="mis-ipt-lst">
			<li class="item">
				<div class="mis-ipt-row">
					<div class="tl">
						<span>项目名：</span>
					</div>
					<div class="tc">
						<div class="mis-ipt-mod">
							<input type="text" name="name" value="${(trainStatistics.name)!}" placeholder="请输入项目名..." class="mis-ipt">
						</div>
					</div>
				</div>
			</li>
			<li class="item item-twoIpu">
                <div class="mis-ipt-row">
                    <div class="tl">
                        <span>培训时间：</span>
                    </div>
                    <div class="center">
                        <div class="tc">
                            <div class="mis-ipt-mod">
                                <input id="trainStartTime" name="trainingStartTime" type="text" value="${(trainStatistics.trainingTime.startTime?string("yyyy-MM-dd"))! }" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="mis-ipt">
                            </div>
                        </div>
                        <span class="to">至</span>
                        <div class="tc">
                            <div class="mis-ipt-mod">
                                <input name="trainingEndTime" type="text" value="${(trainStatistics.trainingTime.endTime?string("yyyy-MM-dd"))!}" onFocus="WdatePicker({minDate:'#F{$dp.$D(\'trainStartTime\')}',dateFmt:'yyyy-MM-dd'})" class="mis-ipt" >
                            </div>
                        </div>                                            
                    </div>
                </div>
            </li>
            <li class="item">
				<div class="mis-ipt-row">
	                <div class="tl">
	                    <span>项目：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-select">
	                        <select name="project.id" value="${(trainStatistics.project.id)!}">
	                            <option value="">请选择...</option>
								<@projects>
									<#list projects as project>
										<option value="${(project.id)!}" <#if (trainStatistics.project.id)! == (project.id)!>selected="selected"</#if> >${(project.name)!}</option>
									</#list>
								</@projects>
	                        </select>    
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
	                        <select name="state" value="${(trainStatistics.state)!}">
	                        	<option value="" <#if (trainStatistics.state)! == ''>selected="selected"</#if>>请选择...</option>
	                        	<option value="ready" <#if (trainStatistics.state)! == 'ready'>selected="selected"</#if>>未开始</option>
								<option value="in_progress" <#if (trainStatistics.state)! == 'in_progress'>selected="selected"</#if>>进行中</option>
								<option value="end" <#if (trainStatistics.state)! == 'end'>selected="selected"</#if>>已结束</option>
	                        </select>    
	                    </div>
	                </div>
	            </div>
			</li>
		</ul>
		<div class="mis-btn-row indent1">
			<button onclick="easyui_tabs_update('listStatisticsTrainForm','layout_center_tabs');" type="button" class="mis-btn mis-main-btn">
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
				<button onclick="viewStat('studentStat')" type="button" class="mis-btn mis-inverse-btn">
					<i class="mis-look-ico"></i>查看学员统计
				</button>
				<#-- 
				<button onclick="viewStat('areaStat')" type="button" class="mis-btn mis-inverse-btn">
					<i class="mis-look-ico"></i>查看项目区域统计
				</button>
				<button onclick="viewStat('schoolStat')" type="button" class="mis-btn mis-inverse-btn">
					<i class="mis-look-ico"></i>查看学校统计
				</button>
				-->
			</div>
		</div>
		<div class="mis-table-mod">
			<table id="listStatisticsTrainTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
				<thead>
					<tr>
						<th data-options="field:'id',checkbox:true"></th>
						<th data-options="field:'name'">培训</th>
						<th data-options="field:'type'">培训形式</th>
						<th data-options="field:'participateHeadcount'">参训人数</th>
						<th data-options="field:'passHeadcount'">合格人数</th>
						<th data-options="field:'passPercent'">合格率</th>
						<th data-options="field:'activityParticipateNum'">课程活动（参与人次）</th>
						<th data-options="field:'workshopParticipateNum'">工作坊任务（参与人次）</th>
						<th data-options="field:'discussionNum'">发表研说</th>
						<th data-options="field:'lessonNum'">发起创课</th>
						<th data-options="field:'movementNum'">社区活动</th>
						<th data-options="field:''">状态</th>
					</tr>
				</thead>
				<tbody>
					<@statisticsTrainData name=(trainStatistics.name)! projectId=(trainStatistics.projectId)! 
						startTimeLessThanOrEquals=((trainStatistics.trainingTime.startTime)?string('yyyy-MM-dd HH:mm:ss'))!''
						endTimeGreaterThanOrEquals=((trainStatistics.trainingTime.endTime)?string('yyyy-MM-dd HH:mm:ss'))!'' 
						state=(trainStatistics.state)! limit=(pageBounds.limit)!10 page=(pageBounds.page)!1 >
						<#list trainStatisticsList as ts>
							<tr>
								<td>${(ts.id)!}</td>
								<td>${(ts.name)!}</td>
								<td>
									<#if (ts.type)??>
										<#list ts.type?split(",") as t>
											<#if t == 'course' >
												<span class="mis-course-type type1">课</span>
											<#elseif t == 'workshop'>
												<span class="mis-course-type type2">坊</span>
											<#elseif t == 'community'>
												<span class="mis-course-type type3">社</span>
											</#if> 
										</#list>
									</#if>
								</td>
								<td>${(ts.participateHeadcount)!}</td>
								<td>${(ts.passHeadcount)!}</td>
								<td>
									<#if ((ts.participateHeadcount)!0) == 0>
										0%
									<#else>
										${((((ts.passHeadcount!0)/(ts.participateHeadcount))!0)*100)?default(0.00)}%
									</#if>
								</td>
								<td>${(ts.activityParticipateNum)!}</td>
								<td>${(ts.workshopParticipateNum)!}</td>
								<td>${(ts.discussionNum)!}</td>
								<td>${(ts.lessonNum)!}</td>
								<td>${(ts.movementNum)!}</td>
								<td>
									<#if (ts.trainingTime.startTime)?? && (ts.trainingTime.endTime)??>
										<#if TimeUtils.hasEnded(ts.trainingTime.endTime)>
				                        	已结束
				                        <#elseif !TimeUtils.hasBegun(ts.trainingTime.startTime)>
				                        	未开始
				                        <#else>
				                        	进行中
				                        </#if>
			                        </#if>
								</td>
							</tr>
						</#list>
					</@statisticsTrainData>
				</tbody>
				<tfoot>
	                <tr>
	                    <td colspan="12">
	                    	 <#if paginator??>
						    	<#import "/nts/include/pagination.ftl" as p/>
						    	<@p.pagination paginator=paginator formId="listStatisticsTrainForm" divId="content"/>
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
		$('#listStatisticsTrainTable').datagrid();
	});
	
	function exportStatisticsTrainResult(){
		
	};
	
	function listStatisticsTrainResult(tId,tName){
		easyui_modal_open('listStatisticsTrainResultDiv', tName, 800, 600, '${ctx!}/statistics/train/result?train.id=' + tId, true);
	};
	
	function viewStat(type){
		var row = $('#listStatisticsTrainForm').find('#listStatisticsTrainTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一个培训查看', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时查看多个培训', 'warning');
			return false;
		}else{
			var id = row[0].id;
			var title = '查看统计';
			if(type == 'studentStat'){
				title = '查看学员统计'
			}
			if(type == 'areaStat'){
				title = '查看区域统计'
			}
			if(title == 'schoolStat'){
				type = '查看学校统计'
			}
			easyui_modal_open_list('statDiv',title , 700, 600, '${ctx}/statistics/train/'+type + '?id=' + id, true);
		}
	};

</script>