<form id="listStatisticsProjectForm" action="${ctx!}/statistics/project" method="get">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<div class="mis-srh-layout">
		<ul class="mis-ipt-lst">
			<li class="item">
				<div class="mis-ipt-row">
					<div class="tl">
						<span>项目名：</span>
					</div>
					<div class="tc">
						<div class="mis-ipt-mod">
							<input type="text" name="name" value="${(projectStatistics.name)!}" placeholder="请输入项目名..." class="mis-ipt">
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
	                        <select name="state" value="${(projectStatistics.state)!}">
	                        	<option value="" <#if (projectStatistics.state)! == ''>selected="selected"</#if>>请选择...</option>
	                        	<option value="ready" <#if (projectStatistics.state)! == 'ready'>selected="selected"</#if>>未开始</option>
								<option value="in_progress" <#if (projectStatistics.state)! == 'in_progress'>selected="selected"</#if>>进行中</option>
								<option value="end" <#if (projectStatistics.state)! == 'end'>selected="selected"</#if>>已结束</option>
	                        </select>    
	                    </div>
	                </div>
	            </div>
			</li>
		</ul>
		<div class="mis-btn-row indent1">
			<button onclick="easyui_tabs_update('listStatisticsProjectForm','layout_center_tabs');" type="button" class="mis-btn mis-main-btn">
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
					<i class="mis-look-ico"></i>查看项目区域统计
				</button>
			</div>
		</div>
		<div class="mis-table-mod">
			<table id="listStatisticsProjectTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
				<thead>
					<tr>
						<th data-options="field:'id',checkbox:true"></th>
						<th data-options="field:'name'">项目名称</th>
						<th data-options="field:'timePeriod'">执行时间</th>
						<th data-options="field:'trainNum'">开展培训</th>
						<th data-options="field:'participateDepartmentNum'">参与单位</th>
						<th data-options="field:'registerHeadcount'">报名人数</th>
						<th data-options="field:'participateHeadcount'">参训人数</th>
						<th data-options="field:'participatePercent'">参训率</th>
						<th data-options="field:'passHeadcount'">合格人数</th>
						<th data-options="field:'passPercent'">合格率</th>
						<th data-options="field:''">状态</th>
					</tr>
				</thead>
				<tbody>
					<@statisticsProjectData name=(projectStatistics.name)!'' state=(projectStatistics.state)! limit=(pageBounds.limit)!10 page=(pageBounds.page)!1>
						<#list projectStatisticsList as ps>
							<tr>
								<td>${(ps.id)!}</td>
								<td>${(ps.name)!}</td>
								<td>
									<#if (ps.timePeriod.startTime)??>
										${TimeUtils.formatDate(ps.timePeriod.startTime, 'yyyy/MM/dd')!}
									</#if>
									~
									<#if (ps.timePeriod.endTime)??>
										${TimeUtils.formatDate(ps.timePeriod.endTime, 'yyyy/MM/dd')!}
									</#if>
								</td>
								<td>${(ps.trainNum)!}</td>
								<td>${(ps.participateDepartmentNum)!}</td>
								<td>${(ps.registerHeadcount)!}</td>
								<td>${(ps.participateHeadcount)!}</td>
								<td>
									<#if ((ps.registerHeadcount)!0) == 0>
										0.00%
									<#else>
										${((((ps.participateHeadcount!0)/(ps.registerHeadcount))!0)*100)?default(0.00)}%
									</#if>
								</td>
								<td>${(ps.passHeadcount)!}</td>
								<td>
									<#if ((ps.registerHeadcount)!0) == 0>
										0.00%
									<#else>
										${((((ps.passHeadcount!0)/(ps.registerHeadcount))!0)*100)?default(0.00)}%
									</#if>
								</td>
								<td>
									<#if (ps.timePeriod.startTime)?? && (ps.timePeriod.endTime)??>
										<#if TimeUtils.hasEnded(ps.timePeriod.endTime)>
				                        	已结束
				                        <#elseif !TimeUtils.hasBegun(ps.timePeriod.startTime)>
				                        	未开始
				                        <#else>
				                        	进行中
				                        </#if>
			                        </#if>
								</td>
							</tr>
						</#list>
					</@statisticsProjectData>
				</tbody>
				<tfoot>
	                <tr>
	                    <td colspan="11">
	                    	 <#if paginator??>
						    	<#import "/nts/include/pagination.ftl" as p/>
						    	<@p.pagination paginator=paginator formId="listStatisticsProjectForm" divId="content"/>
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
		$('#listStatisticsProjectTable').datagrid();
	});
	
	function searchStatisticsProject() {
		$('#listStatisticsProjectForm #page').val('1');
		removeDeleteCheckBox('listStatisticsProjectForm');
		easyui_tabs_update('listStatisticsProjectForm','layout_center_tabs');
	};
	
	function resetStatisticsProject() {
		$('#listStatisticsProjectForm').form('clear');
	};
	
	function removeDeleteCheckBox(formId){
		$('#'+formId+' input[type="checkbox"]:checked').remove();
	}; 
	
	function changeType(a,formId){
		var type = $(a).val();
		if(type == 'table'){
			$('#' + formId + ' #tableType').show();
			$('#' + formId + ' #imageType').hide();
		}		
		if(type == 'image'){
			$('#' + formId + ' #tableType').hide();
			$('#' + formId + ' #imageType').show();
		}
	};
	
	function viewStat(type){
		var row = $('#listStatisticsProjectForm').find('#listStatisticsProjectTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一个项目', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时查看多个项目', 'warning');
			return false;
		}else{
			var id = row[0].id;
			easyui_modal_open_list('statDiv', '查看区域统计', 700, 600, '${ctx}/statistics/project/'+type + '?id=' + id, true);
		}
	};
</script>