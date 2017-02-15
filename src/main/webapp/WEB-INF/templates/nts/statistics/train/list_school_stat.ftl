<form id="listSchoolStatForm" action="${ctx}/statistics/train/schoolStat?id=${(trainStatistics.id)!}"  method ="get">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<input type="hidden" name="provinceRegionsCode" value="${(trainStatistics.provinceRegionsCode)!}">
	<input type="hidden" name="cityRegionsCode" value="${(trainStatistics.cityRegionsCode)!}">
	<input type="hidden" name="countiesRegionsCode" value="${(trainStatistics.countiesRegionsCode)!}">
	<div class="mis-srh-layout">
		<ul class="mis-ipt-lst">
		<#-- 
			<li class="item">
				<div class="mis-ipt-row">
	                <div class="tl">
	                    <span>省：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-select">
	                        <select name="state" value="">
	                        	<option value="" selected="selected">请选省...</option>
	                        </select>    
	                    </div>
	                </div>
	            </div>
			</li>
			<li class="item">
				<div class="mis-ipt-row">
	                <div class="tl">
	                    <span>市：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-select">
	                        <select name="state" value="">
	                        	<option value="" selected="selected">请选市...</option>
	                        </select>    
	                    </div>
	                </div>
	            </div>
			</li>
			<li class="item">
				<div class="mis-ipt-row">
	                <div class="tl">
	                    <span>区县：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-select">
	                        <select name="state" value="">
	                        	<option value="" selected="selected">请选区县...</option>
	                        </select>    
	                    </div>
	                </div>
	            </div>
			</li>
			-->
			<li class="item">
				<div class="mis-ipt-row">
					<div class="tl">
						<span>学校单位名称：</span>
					</div>
					<div class="tc">
						<div class="mis-ipt-mod">
							<input type="text" name="department.deptName" value="${(trainStatistics.department.deptName)!}" placeholder="请输入学校单位名称..." class="mis-ipt">
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
						<th data-options="field:'departmentId',checkbox:true"></th>
						<th data-options="field:'departmentName'">学校单位</th>
						<th data-options="field:'participateHeadcount'">参训人数</th>
						<th data-options="field:'passHeadcount'">合格人数</th>
						<th data-options="field:'passPercent'">合格率</th>
						<th data-options="field:'activityParticipateNum'">课程活动（参与人次）</th>
						<th data-options="field:'workshopParticipateNum'">工作坊任务（参与人次）</th>
						<th data-options="field:'discussionNum'">发表研说</th>
						<th data-options="field:'lessonNum'">发起创课</th>
						<th data-options="field:'movementNum'">社区活动</th>
					</tr>
				</thead>
				<tbody>
					<@statisticsTrainData queryType='schoolStat' trainId=(trainStatistics.id)! limit=(pageBounds.limit)!10 page=(pageBounds.page)!1  departmentName=(trainStatistics.department.deptName)!
					provinceRegionsCode=(trainStatistics.provinceRegionsCode)! cityRegionsCode=(trainStatistics.cityRegionsCode)! countiesRegionsCode=(trainStatistics.countiesRegionsCode)!>
						<#list trainStatisticsList as ts>
								<tr>
									<td>${(ts.department.id)!}</td>
									<td>${(ts.department.deptName)!}</td>
									<td>${(ts.participateHeadcount)!}</td>
									<td>${(ts.passHeadcount)!}</td>
									<td>
										<#if ((ts.trainHeadcount)!0) == 0>
											0.00%
										<#else>
											${((((ts.passHeadcount!0)/(ts.trainHeadcount))!0)*100)?default(0.00)}%
										</#if>
									</td>
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

