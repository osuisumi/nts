<form id="listSchoolCourseStatForm" action="${ctx}/manage/course_stat/school"  method ="get">
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
	        <button onclick="easyui_tabs_update('listSchoolCourseStatForm','layout_center_tabs');" type="button" class="mis-btn mis-main-btn"><i class="mis-srh-ico"></i>查询</button>
			<a onclick="resetForm(this)"  class="mis-btn mis-default-btn">
				<i class="mis-refresh-ico"></i>重置
			</a>
	    </div>
	</div>
	<div class="mis-table-layout">
	    <div class="mis-opt-row">
	        <div class="mis-opt-mod fl">
	        </div>
	    </div>
	    <div class="mis-table-mod">
	        <table id="listCourseStatTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
	            <thead>
	                <tr>
	                    <th data-options="field:'title'">学校</th>
	                    <th data-options="field:'code'">选课人数</th>
	                    <th data-options="field:'termNo'">通过率</th>
	                    <th data-options="field:'organization'">视频学习</th>
	                    <th data-options="field:'type'">主题研讨</th>
	                    <th data-options="field:'studyHours'">参与测试</th>
	                    <th data-options="field:'state'">提交作业</th>
	                    <th data-options="field:'isTemplate'">提问数</th>
	                    <th data-options="field:'isTemplate'">回答数</th>
	                    <th data-options="field:'isTemplate'">笔记数</th>
	                    <th data-options="field:'isTemplate'">研讨数</th>
	                    <th data-options="field:'isTemplate'">资源数</th>
	                </tr>
	            </thead>
	            <tbody>
	                <@courseStatExtendsDirective orders=(orders)!'REGISTER_NUM.DESC' deptName=(deptName[0])! courseId=(courseId[0])! type="school" page=(pageBounds.page)!1 limit=(pageBounds.limit)!10 >
					<#list courseStatExtends as cse>
						<tr>
							<td>${(cse.department.deptName)!}</td>
							<td>${(cse.registerNum)!}</td>
							<td>
								<#if (cse.registerNum)?? && (cse.qualifiedNum)?? && (cse.registerNum>0)>
								${(cse.qualifiedNum/cse.registerNum)*100}%
								<#else>
								0%
								</#if>
							</td>
							<td>${(cse.completeVideoNum)!}</td>
							<td>${(cse.completeDiscussionNum)!}</td>
							<td>${(cse.completeTestNum)!}</td>
							<td>${(cse.completeAssignmentNum)!}</td>
							<td>${(cse.faqQuestionNum)!}</td>
							<td>${(cse.faqAnswerNum)!}</td>
							<td>${(cse.noteNum)!}</td>
							<td>${(cse.discussionNum)!}</td>
							<td>${(cse.resourceNum)!}</td>
						</tr>
					</#list>
	            </tbody>
	            <tfoot>
	                <tr>
	                    <td colspan="15">
	                    	 <#if paginator??>
						    	<#import "/nts/include/pagination.ftl" as p/>
						    	<@p.pagination paginator=paginator formId="listSchoolCourseStatForm" divId="content"/>
							</#if>
	                    </td>
	                </tr>
	            </tfoot>
	        </table>
	        </@courseStatExtendsDirective>
	    </div>
	</div>
</form>
<script>
	$(function(){
		//$('#listCourseStatTable').datagrid();
	});
	
	
</script>