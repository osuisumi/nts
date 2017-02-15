<#global app_path=PropertiesLoader.get('app.nts.path') >
<form id="listStatisticsCommunityForm" action="${ctx!}/statistics/community" method="get">
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
							<input type="text" name="train.name" value="${(communityStatistics.train.name)!}" placeholder="请输入培训名称..." class="mis-ipt">
						</div>
					</div>
				</div>
			</li>
			<li class="item item-twoIpu">
                <div class="mis-ipt-row">
                    <div class="tl">
                        <span>考核时间：</span>
                    </div>
                    <div class="center">
                        <div class="tc">
                            <div class="mis-ipt-mod">
                                <input id="trainStartTime" name="trainingStartTime" type="text" value="${(communityStatistics.trainingTime.startTime?string("yyyy-MM-dd"))! }" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="mis-ipt">
                            </div>
                        </div>
                        <span class="to">至</span>
                        <div class="tc">
                            <div class="mis-ipt-mod">
                                <input name="trainingEndTime" type="text" value="${(communityStatistics.trainingTime.endTime?string("yyyy-MM-dd"))!}" onFocus="WdatePicker({minDate:'#F{$dp.$D(\'trainStartTime\')}',dateFmt:'yyyy-MM-dd'})" class="mis-ipt" >
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
	                        <select name="train.project.id" value="${(communityStatistics.train.project.id)!}">
	                            <option value="">请选择...</option>
								<@projects>
									<#list projects as project>
										<option value="${(project.id)!}" <#if (communityStatistics.train.project.id)! == (project.id)!>selected="selected"</#if> >${(project.name)!}</option>
									</#list>
								</@projects>
	                        </select>    
	                    </div>
	                </div>
	            </div>
			</li>
		</ul>
		<div class="mis-btn-row indent1">
			<button onclick="easyui_tabs_update('listStatisticsCommunityForm','layout_center_tabs');" type="button" class="mis-btn mis-main-btn">
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
					<i class="mis-look-ico"></i>查看学员社区拓展统计
				</button>
			</div>
		</div>
		<div class="mis-table-mod">
			<table id="listStatisticsCommunityTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
				<thead>
					<tr>
						<th data-options="field:'trainId',checkbox:true"></th>
						<th data-options="field:'projectName'">项目</th>
						<th data-options="field:'trainName'">培训</th>
						<th data-options="field:'participateHeadcount'">考核时间</th>
						<th data-options="field:'trainHeadcount'">参与人数</th>
						<th data-options="field:'passPercent'">合格率</th>
						<#if '/nts/lingnan' = app_path>
							<th data-options="field:'discussionNum'">交流数量</th>
							<th data-options="field:'lessonNum'">资源数量</th>
							<th data-options="field:'movementNum'">听课数量</th>
						<#else>
							<th data-options="field:'discussionNum'">研说数量</th>
							<th data-options="field:'lessonNum'">创课数量</th>
							<th data-options="field:'movementNum'">活动数量</th>
						</#if>
						<th data-options="field:'state'">状态</th>
					</tr>
				</thead>
				<tbody>
					<@statisticsCommunityData trainName=(communityStatistics.train.name)!'' projectId=(communityStatistics.train.project.id)!''
						startTimeLessThanOrEquals=((communityStatistics.trainingTime.startTime)?string('yyyy-MM-dd HH:mm:ss'))!''
						endTimeGreaterThanOrEquals=((communityStatistics.trainingTime.endTime)?string('yyyy-MM-dd HH:mm:ss'))!'' 
						limit=(pageBounds.limit)!10 page=(pageBounds.page)!1 >
						<#list communityStatisticsList as cs>
							<tr>
								<td>${(cs.train.id)!}</td>
								<td>${(cs.train.name)!}</td>
								<td>${(cs.train.project.name)!}</td>
								<td>
									<#if (cs.trainingTime.startTime)??>
										${TimeUtils.formatDate(cs.trainingTime.startTime, 'yyyy/MM/dd')!}
									</#if>
									~
									<#if (cs.trainingTime.endTime)??>
										${TimeUtils.formatDate(cs.trainingTime.endTime, 'yyyy/MM/dd')!}
									</#if>
								</td>
								<td>${(cs.trainHeadcount)!}</td>
								<td>
									<#if ((cs.trainHeadcount)!0) == 0>
										0.00%
									<#else>
										${((((cs.passHeadcount!0)/(cs.trainHeadcount))!0)*100)?default(0.00)}%
									</#if>
								</td>
								<td>${(cs.discussionNum)!}</td>
								<td>${(cs.lessonNum)!}</td>
								<td>${(cs.movementNum)!}</td>
								<td>
									<#if (cs.trainingTime.startTime)?? && (cs.trainingTime.endTime)??>
										<#if TimeUtils.hasEnded(cs.trainingTime.endTime)>
				                        	已结束
				                        <#elseif !TimeUtils.hasBegun(cs.trainingTime.startTime)>
				                        	未开始
				                        <#else>
				                        	进行中
				                        </#if>
			                        </#if>
								</td>
							</tr>
						</#list>
					</@statisticsCommunityData>
				</tbody>
				<tfoot>
	                <tr>
	                    <td colspan="12">
	                    	 <#if paginator??>
						    	<#import "/nts/include/pagination.ftl" as p/>
						    	<@p.pagination paginator=paginator formId="listStatisticsCommunityForm" divId="content"/>
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
		$('#listStatisticsCommunityTable').datagrid();
	});
	
	function viewStat(type){
		var row = $('#listStatisticsCommunityForm').find('#listStatisticsCommunityTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一个社区查看', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时查看多个社区', 'warning');
			return false;
		}else{
			var trainId = row[0].trainId;
			easyui_modal_open_list('statDiv', '查看统计', 700, 600, '${ctx}/statistics/community/'+type + '?train.id=' + trainId, true);
		}
	};

</script>