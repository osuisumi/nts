<form id="listAreaStatForm" action="${ctx}/statistics/project/areaStat?id=${(projectStatistics.id)!}"  method ="get">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<input type="hidden" name="provinceRegionsCode" value="${(projectStatistics.provinceRegionsCode)!}">
	<input type="hidden" name="cityRegionsCode" value="${(projectStatistics.cityRegionsCode)!}">
	<input type="hidden" name="countiesRegionsCode" value="${(projectStatistics.countiesRegionsCode)!}">
	<div class="mis-srh-layout">
		<ul class="mis-ipt-lst">
	    	<li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>区&nbsp;域&nbsp;名：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="text" name="deptName" value="${(deptName[0])!}" placeholder="请输入区域名" class="mis-ipt">
	                    </div>
	                </div>
	            </div>
	        </li>
	    </ul>
	    <div class="mis-btn-row indent1">
	        <button onclick="easyui_tabs_update('listAreaStatForm','layout_center_tabs');" type="button" class="mis-btn mis-main-btn"><i class="mis-srh-ico"></i>查询</button>
			<a onclick="resetForm(this)"  class="mis-btn mis-default-btn">
				<i class="mis-refresh-ico"></i>重置
			</a>
	    </div>
	</div>

	<div class="mis-table-layout">
		<div class="mis-table-mod">
			<table id="listAreaStatTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
				<thead>
					<tr>
						<th data-options="field:'countiesId',checkbox:true"></th>
						<th data-options="field:'province'">省</th>
						<th data-options="field:'city'">市</th>
						<th data-options="field:'counties'">区县</th>
						<th data-options="field:'participateDepartmentNum'">参与单位</th>
						<th data-options="field:'registerHeadcount'">报名人数</th>
						<th data-options="field:'participateHeadcount'">参训人数</th>
						<th data-options="field:'participatePercent'">参训率</th>
						<th data-options="field:'passHeadcount'">合格人数</th>
						<th data-options="field:'passPercent'">合格率</th>
					</tr>
				</thead>
				<tbody>
					<@statisticsProjectData queryType='areaStat' orders=(orders)!'PARTICIPATE_DEPARTMENT_NUM.DESC' limit=(pageBounds.limit)!10 page=(pageBounds.page)!1  projectId=(projectStatistics.id)! deptName=(deptName[0])!
					provinceRegionsCode=(projectStatistics.provinceRegionsCode)! cityRegionsCode=(projectStatistics.cityRegionsCode)! countiesRegionsCode=(projectStatistics.countiesRegionsCode)!>
						<#list projectStatisticsList as ps>
							<tr>
								<td>${(ps.countiesId)!}</td>
								<td>${(ps.province)!}</td>
								<td>${(ps.city)!}</td>
								<td>${(ps.counties)!}</td>
								<td>${(ps.participateDepartmentNum)!}</td>
								<td>${(ps.registerHeadcount)!}</td>
								<td>${(ps.participateHeadcount)!}</td>
								<td>
									<#if ((ps.registerHeadcount)!0) == 0>
										0%
									<#else>
										${((((ps.participateHeadcount!0)/(ps.registerHeadcount))!0)*100)?default(0.00)}%
									</#if>
								</td>
								<td>${(ps.passHeadcount)!}</td>
								<td>
									<#if ((ps.registerHeadcount)!0) == 0>
										0%
									<#else>
										${((((ps.passHeadcount!0)/(ps.registerHeadcount))!0)*100)?default(0.00)}%
									</#if>
								</td>
							</tr>
						</#list>
					</@statisticsProjectData>
				</tbody>
	            <tfoot>
	                <tr>
	                    <td colspan="10">
	                    	 <#if paginator??>
						    	<#import "/nts/include/pagination.ftl" as p/>
						    	<@p.pagination paginator=paginator formId="listAreaStatForm" divId="content"/>
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
		$('#listAreaStatTable').datagrid();
	});
	
</script>

