<form id="listWorkshopMemberForm" action="${ctx}/manage/workshop/worker_stat"  method ="get">
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
							<input type="text" name="realName" value="${(realName[0])!}" placeholder="" class="mis-ipt">
						</div>
					</div>
				</div>
			</li>
			<li class="item">
				<div class="mis-ipt-row">
					<div class="tl">
						<span>工作坊名称：</span>
					</div>
					<div class="tc">
						<div class="mis-ipt-mod">
							<input type="text" name="title" value="${(title[0])!}" placeholder="" class="mis-ipt">
						</div>
					</div>
				</div>
			</li>
			<li class="item">
				<div class="mis-ipt-row">
					<div class="tl">
						<span>工作坊类型：</span>
					</div>
					<div class="tc">
	                    <div class="mis-select">
	                        <select name="type">
	                        	<@rolesData>
	                        		<option value="">请选择...</option>
									<option <#if ((type[0])!'') == 'personal'>selected="selected"</#if>  value="personal">个人工作坊</option>
									<option <#if ((type[0])!'') == 'train'>selected="selected"</#if> value="train">项目工作坊</option>
								</@rolesData>
	                        </select>    
	                    </div>
	                </div>
				</div>
			</li>
		</ul>
		<div class="mis-btn-row indent1">
			<button onclick="easyui_window_update('listWorkshopMemberForm','layout_center_tabs');" type="button" class="mis-btn mis-main-btn"><i class="mis-srh-ico"></i>查询</button>
			<a onclick="resetForm(this)"  class="mis-btn mis-default-btn">
				<i class="mis-refresh-ico"></i>重置
			</a>
			<a href="javascript:;" onclick="exportExcel()" class="mis-btn mis-inverse-btn" >
				<i class="mis-look-ico"></i>导出
			</a>
		</div>
	</div>

	<div class="mis-table-layout">
		<div class="mis-table-mod">
			<table id="listWorkshopMemberTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
				<thead>
					<tr>
						<th width="50px" data-options="field:'id',checkbox:true"></th>
						<th  data-options="field:'realName'">姓名</th>
						<th  data-options="field:'role'">角色</th>
						<th  data-options="field:'train'">培训</th>
						<th  data-options="field:'title'">工作坊名称</th>
						<th  data-options="field:'studentNum'">参与学员</th>
						<th  data-options="field:'qualifiedPersent'">通过率</th>
						<th  data-options="field:'actNum'">发起任务</th>
						<th  data-options="field:'faqAnserNum'">回答问题</th>
						<th  data-options="field:'uploadResource'">上传资源</th>
						<th  data-options="field:'command'">评论</th>
					</tr>
				</thead>
				<tbody>
					<@workshopUsersDirective isTemplate='N' realName=(realName[0])! title=(title[0])! type=(type[0])!  withActionInfo='Y' roleNotEqual='student'   limit=10 page=(pageBounds.page)!1 orders=orders!'CREATE_TIME.DESC'>
						<#assign workshopIds = []>
						<#if workshopUsers??>
							<#list workshopUsers as wu>
								<#assign workshopIds = workshopIds + [wu.workshopId]/>
							</#list>
						</#if>
						<#if (workshopIds?size>0)>
							<@workshopMapDirective  workshopIds=workshopIds! getStudentNum='Y' getQualifiedStudentNum='Y' getTrainName='Y'>
								<#assign workshopMap=workshopMap>
							</@workshopMapDirective>
						</#if>
						<#if workshopUsers??>
							<#list workshopUsers as wu>
								<tr>
									<td>${wu.id}</td>
									<td>${(wu.user.realName)!}</td>
									<td>
										<#if ((wu.role)!'') = 'master'>
											坊主
										<#elseif ((wu.role)!'') = 'member'>
											助理坊主
										</#if>
									</td>
									<td>${(workshopMap[wu.workshopId].trainName)!}</td>
									<td>${(wu.workshop.title)!}</td>
									<td>${(workshopMap[wu.workshopId].workshopRelation.studentNum)!}</td>
									<td>
										<#if workshopMap[wu.workshopId].workshopRelation.studentNum = 0>
										0%
										<#else>
										${(workshopMap[wu.workshopId].workshopRelation.qualifiedStudentNum/workshopMap[wu.workshopId].workshopRelation.studentNum*100)!}%
										</#if>
									</td>
									<td>${(wu.actionInfo.activityNum)!}</td>
									<td>${(wu.actionInfo.faqAnswerNum)!}</td>
									<td>${(wu.actionInfo.uploadResourceNum)!}</td>
									<td>${(wu.actionInfo.commentsNum)!}</td>
								</tr>
							</#list>					
						</#if>
					</@workshopUsersDirective>
				</tbody>
	            <tfoot>
	                <tr>
	                    <td colspan="11">
	                    	 <#if paginator??>
						    	<#import "/nts/include/pagination.ftl" as p/>
						    	<@p.pagination paginator=paginator formId="listWorkshopMemberForm" divId="content"/>
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
		$('#listWorkshopMemberTable').datagrid();
	});
	
	function exportExcel(){
		var total = "${(paginator.totalCount)!0}";
		total = parseInt(total);
		if(total<=0){
			alert('没有数据');
			return false;
		}
		mylayerFn.open({
			id : 'exportWorkshopWorkerStat',
			type : 2,
			title : '导出设置',
			content : '${ctx}/manage/workshop/worker_stat/editExport?realName=${(realName[0])!}&title=${(title[0])!}&total='+total,
			area : [500, 300],
			offset : ['auto', 'auto'],
			fix : false,
		});
	}
	
</script>


