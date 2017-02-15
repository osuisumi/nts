<form id="listCourseResultForm" action="${ctx}/manage/course/result"  method ="get">
	<input type="hidden" name="course.id" value="${(courseResult.course.id)!}">
	<input type="hidden" name="relation.id" value="${(courseResult.relation.id)!}">
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
	                        <input type="text" name="realName" value="${(realName[0])!''}" placeholder="请输入姓名..." class="mis-ipt">
	                    </div>
	                </div>
	            </div>
	        </li>
	    </ul>
	    <div class="mis-btn-row indent1">
	        <button onclick="easyui_tabs_update('listCourseResultForm','layout_center_tabs');" type="button" class="mis-btn mis-main-btn"><i class="mis-srh-ico"></i>查询</button>
			<a onclick="resetForm(this)"  class="mis-btn mis-default-btn">
				<i class="mis-refresh-ico"></i>重置
			</a>
	    </div>
	</div>
	
	<div class="mis-table-layout">
	    <div class="mis-opt-row">
	        <div class="mis-opt-mod fl">
	            <button onclick="updateCourseResult()" type="button" class="mis-btn mis-inverse-btn"><i class="mis-result-ico"></i>登记成绩</button>
	            <button onclick="updateCourseResultAndNotMarkAss()" type="button" class="mis-btn mis-inverse-btn"><i class="mis-result-ico"></i>临时登记成绩</button>
	        </div>
	    </div>
		<div class="mis-table-mod">
        	<table id="listCourseResultTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
        		<thead>
					<tr>
						<th width="50px" data-options="field:'id',checkbox:true"></th>
						<th data-options="field:'userInfoId',hidden:true"></th>
						<th data-options="field:'title'">姓名</th>
						<th data-options="field:'courseName'">课程名</th>
						<th data-options="field:'termNo'">单位</th>
						<th data-options="field:'state'">成绩</th>
						<th data-options="field:'score'">获得分数</th>
						<th data-options="field:'input_state'">登记状态</th>
					</tr>
				</thead>
				<tbody>
					<@courseRegistersDirective getResult=true state='pass' realName=(realName[0])!'' relationId=(courseResult.relation.id)! courseId=(courseResult.course.id)! page=(pageBounds.page)!1 limit=(pageBounds.limit)!10 orders='CREATE_TIME.DESC'>
						<#list courseRegisters as cr>
							<tr>
								<td>${cr.id}</td>
								<td>${(cr.user.id)!}</td>
								<td>${(cr.user.realName)!}</td>
								<td>${(cr.course.title)!}</td>
								<td>${(cr.user.deptName)!}</td>
								<td>
									<#if ('pass' == (courseResultMap[cr.user.id].state)!)>
										合格
									<#elseif ('nopass' == (courseResultMap[cr.user.id].state)!)>
										不合格
									</#if>
								</td>
								<td>${(courseResultMap[cr.user.id].score)!}</td>
								<td>
									<#if (courseResultMap[cr.user.id].score)??>
										已登记
									<#else>
										未登记
									</#if>
								</td>
							</tr>
						</#list>
					</@courseRegistersDirective>
				</tbody>
				<tfoot>
	                <tr>
	                    <td colspan="10">
	                    	 <#if paginator??>
						    	<#import "/nts/include/pagination.ftl" as p/>
						    	<@p.pagination paginator=paginator formId="listCourseResultForm" divId="content"/>
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
		$('#listCourseResultTable').datagrid();
	});

	function updateCourseResult(){
		confirm('确定要登记这门课程的成绩吗?', function(){
			$.put('${ctx}/manage/course/result', 'course.id=${(courseResult.course.id)!}&relation.id=${(courseResult.relation.id)!}', function(data){
				if(data.responseCode == '00'){
					alert('成绩登记成功');
					easyui_tabs_update('listCourseResultForm', 'layout_center_tabs');
				}else{
					if(data.responseMsg == 'course result settings is not be set'){
						alert('该课程还未设置分值构成');
					}else if(data.responseMsg == 'course is not over'){
						alert('课程还未结束, 无法登记成绩');
					}else if(data.responseMsg == 'course is not set endTime'){
						alert('课程没有设置结束时间');
					}
				}
			});
		});
	}
	
	function updateCourseResultAndNotMarkAss(){
		confirm('确定要登记这门课程的成绩吗?', function(){
			$.put('${ctx}/manage/course/result/updateAndNotMarkAss', 'course.id=${(courseResult.course.id)!}&relation.id=${(courseResult.relation.id)!}', function(data){
				if(data.responseCode == '00'){
					alert('成绩登记成功');
					easyui_tabs_update('listCourseResultForm', 'layout_center_tabs');
				}else{
					if(data.responseMsg == 'course result settings is not be set'){
						alert('该课程还未设置分值构成');
					}else if(data.responseMsg == 'course is not over'){
						alert('课程还未结束, 无法登记成绩');
					}
				}
			});
		});
	}
</script>

