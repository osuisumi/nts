<form id="listTrainRegisterStatForm" action="/manage/train_register_stat"  method ="get">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<div class="mis-srh-layout">
		<ul class="mis-ipt-lst">
			<li class="item">
				<div class="mis-ipt-row">
					<div class="tl">
						<span>培训：</span>
					</div>
	                <div class="tc">
	                    <div class="mis-select">
	                        <select name="trainId" id="">
	                        	<option <#if ((trainId[0])!'') = ''>selected = 'selected'</#if> value="">请选择培训</option>	
	                        	<@trains>
	                        		<#if trains??>
	                        			<#list trains as train>
	                        				<option <#if ((trainId[0])!'') = ((train.id)!'')>selected = 'selected'</#if> value="${(train.id)!}">${(train.name)!}</option>
	                        			</#list>
	                        		</#if>
	                        	</@trains>
	                        </select>    
	                    </div>
	                </div>
				</div>
			</li>
			<li class="item">
				<div class="mis-ipt-row">
					<div class="tl">
						<span>姓名：</span>
					</div>
					<div class="tc">
						<div class="mis-ipt-mod">
							<input type="text" name="realName" value="${(realName[0])!}" placeholder="请输入姓名..." class="mis-ipt">
						</div>
					</div>
				</div>
			</li>
			<li class="item">
				<div class="mis-ipt-row">
					<div class="tl">
						<span>机构名：</span>
					</div>
					<div class="tc">
						<div class="mis-ipt-mod">
							<input type="text" name="deptName" value="${(deptName[0])!}" placeholder="请输入机构名" class="mis-ipt">
						</div>
					</div>
				</div>
			</li>
			<#--
			<li class="item">
				<div class="mis-ipt-row">
					<div class="tl">
						<span>作业提交情况：</span>
					</div>
	                <div class="tc">
	                    <div class="mis-select">
	                        <select name="assignmentSubmitType" id="">
	                        	<option <#if ((assignmentSubmitType[0])!'') = ''>selected = 'selected'</#if> value="">请选择</option>	
	                        	<option <#if ((assignmentSubmitType[0])!'') = 'submited'>selected = 'selected'</#if> value="submited">已提交</option>
	                        	<option <#if ((assignmentSubmitType[0])!'') = 'unSubmit'>selected = 'selected'</#if> value="unSubmit">未提交</option>
	                        </select>    
	                    </div>
	                </div>
				</div>
			</li>
			-->
		</ul>
		<div class="mis-btn-row indent1">
			<button onclick="easyui_tabs_update('listTrainRegisterStatForm','layout_center_tabs');" type="button" class="mis-btn mis-main-btn"><i class="mis-srh-ico"></i>查询</button>
			<a onclick="resetForm(this)"  class="mis-btn mis-default-btn">
				<i class="mis-refresh-ico"></i>重置
			</a>
		</div>
	</div>
	
	<#if '' != (trainId[0])!''>
		<div class="mis-table-layout">
			<div class="mis-opt-row">
				<div class="mis-opt-mod fl">
					<button onclick="trainRegisterStatDetail()" type="button" class="mis-btn mis-inverse-btn" >
						<i class="mis-look-ico"></i>学情详情
					</button>
					<a href="javascript:;" onclick="exportExcel()" class="mis-btn mis-inverse-btn" >
						<i class="mis-look-ico"></i>导出
					</a>
					<a href="javascript:;" onclick="exportCourseResult('pass')" class="mis-btn mis-inverse-btn" >
						<i class="mis-look-ico"></i>按省平台格式导出课程成绩(合格)
					</a>
					<a href="javascript:;" onclick="exportCourseResult()" class="mis-btn mis-inverse-btn" >
						<i class="mis-look-ico"></i>按省平台格式导出课程成绩(全部)
					</a>
				</div>
			</div>
			<div class="mis-table-mod">
			<table id="listTrainRegisterStatTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
				<thead>
					<tr>
						<th width="50px" data-options="field:'id',checkbox:true"></th>
						<th  data-options="field:'name'">培训</th>
						<th  data-options="field:'project.name'">工作单位</th>
						<th  data-options="field:'description'">姓名</th>
						<th data-options="field:'paperworkNo'">身份证号(手机号)</th>
						<th  data-options="field:'trainingTime'">总学时</th>
						<th  data-options="field:'courseState'">课程情况</th>
						<th  data-options="field:'assignmentSubmitState'">作业提交情况</th>
						<th data-options="field:'courseResult'">课程考核</th>
						<th  data-options="field:'electivesTime'">工作坊情况</th>
						<th  data-options="field:'electivesTime'">社区积分</th>
						<th  data-options="field:'electivesTime'">社区考核</th>
						<th data-options="field:'studyHours'">获得学时</th>
						<th data-options="field:'result'">培训情况</th>
						<th data-options="field:'mainCourseScore'">核心课分数</th>
					</tr>
				</thead>
				<tbody>
					<@trainRegisterStatsDirective assignmentSubmitType=(assignmentSubmitType[0])! deptName=(deptName[0])! trainId=(trainId[0])! realName=(realName[0])! limit=(pageBounds.limit)!10 page=(pageBounds.page)!1 >
						<#if trainRegisterStats??>
							<#list trainRegisterStats as trs>
								<tr>
									<td>${(trs.trainRegister.id)!}</td>
									<td>${(trs.train.name)!}</td>
									<td>${(trs.trainRegister.user.deptName)!}</td>
									<td>${(trs.trainRegister.user.realName)!}</td>
									<td>${(trs.paperworkNo)!}</td>
									<td>${(trs.trainTotalStudyHours)!}</td>
									<td>${(trs.qualifiedCourseNum)!0}/${(trs.registedCourseNum)!0}</td>
									<td>${(trs.assignmentSubmitState)!}</td>
									<td>${(trs.courseEvaluate)!}</td>
									<td>${(trs.qualifiedWorkshopNum)!0}/${(trs.joinWorkshopNum)!}</td>
									<td>
										<#if (trs.communityResult)?? && (trs.communityRelation)??>
											${(trs.communityResult.score)!0}/${(trs.communityRelation.score)!}
										<#else>
											-
										</#if>
									</td>
									<td>${(trs.communityEvaluate)!}</td>
									<td>${(trs.totalStudyHours)!}</td>
									<td>${(trs.trainResult)!}</td>
									<td>${(trs.mainCourseScore)!0}</td>
								</tr>
							</#list>					
						</#if>
					</@trainRegisterStatsDirective>
				</tbody>
	            <tfoot>
	                <tr>
	                    <td colspan="99">
	                    	 <#if paginator??>
						    	<#import "/nts/include/pagination.ftl" as p/>
						    	<@p.pagination paginator=paginator formId="listTrainRegisterStatForm" divId="content"/>
							</#if>
	                    </td>
	                </tr>
	            </tfoot>
			</table>
		</div>
		</div>
	</#if>
</form>
<script>

	$(function(){
		$('#listTrainRegisterStatTable').datagrid();
	});
	
	function trainRegisterStatDetail(){
		var row = $('#listTrainRegisterStatForm').find('#listTrainRegisterStatTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时操作多条数据', 'warning');
			return false;
		}else{
			var id = row[0].id;
			easyui_modal_open('trainRegisterStatDetail', '学员学情详细信息', 700, 600, '${ctx}/manage/train_register_stat/detail/'+id+"?trainId=${(trainId[0])!}", true);
		}
	}
	
	function exportExcel(){
		var total = "${(paginator.totalCount)!0}";
		total = parseInt(total);
		if(total<=0){
			alert('没有数据');
			return false;
		}
		mylayerFn.open({
			id : 'exportTrainRegisterStat',
			type : 2,
			title : '导出设置',
			content : '${ctx}/train_register_stat/editExport?trainId=${(trainId[0])!}&realName=${(realName[0])!}&deptName=${(deptName[0])!}&assignmentSubmitType=${(assignmentSubmitType[0])!}&total='+total,
			area : [500, 300],
			offset : ['auto', 'auto'],
			fix : false,
		});
	}
	
	function exportCourseResult(state){
		var total = "${(paginator.totalCount)!0}";
		total = parseInt(total);
		if(total<=0){
			alert('没有数据');
			return false;
		}
		var data = '?trainId=${(trainId[0])!}&realName=${(realName[0])!}&deptName=${(deptName[0])!}&total='+total;
		if(state != null && state != ''){
			data += '&state='+state;
		}
		mylayerFn.open({
			id : 'exportCourseResult',
			type : 2,
			title : '导出设置',
			content : '${ctx}/manage/course/result/editExport'+data,
			area : [500, 300],
			offset : ['auto', 'auto'],
			fix : false,
		});
	}
	
</script>

