<form id="listStudentCourseStatForm" action="${ctx}/manage/course_stat/student"  method ="get">
	<input type="hidden" name="courseId" value="${(courseId[0])!}">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<div class="mis-srh-layout">
	    <ul class="mis-ipt-lst">
	    	<li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>姓&nbsp;名：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="text" name="realName" value="${(realName[0])!}" placeholder="请输入姓名..." class="mis-ipt">
	                    </div>
	                </div>
	            </div>
	        </li>
	    </ul>
	    <div class="mis-btn-row indent1">
	        <button onclick="easyui_tabs_update('listStudentCourseStatForm','layout_center_tabs');" type="button" class="mis-btn mis-main-btn"><i class="mis-srh-ico"></i>查询</button>
			<a onclick="resetForm(this)"  class="mis-btn mis-default-btn">
				<i class="mis-refresh-ico"></i>重置
			</a>
	    </div>
	</div>
	<div class="mis-table-layout">
	    <div class="mis-opt-row">
	        <div class="mis-opt-mod fl">
	           <!-- <button onclick="addCourse()" type="button" class="mis-btn mis-inverse-btn"><i class="mis-add-ico"></i>新建</button>-->
	        </div>
	    </div>
	    <div class="mis-table-mod">
	        <table id="listStudentCourseStatTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
	            <thead>
	                <tr>
	                    <th width="50px" data-options="field:'id',checkbox:true">选项</th>
                    	<th data-options="field:'trainName'">姓名</th>
	                    <th data-options="field:'title'">身份证</th>
	                    <th data-options="field:'title'">工作单位</th>
	                    <th data-options="field:'organization'">视频学习</th>
	                    <th data-options="field:'type'">主题研讨</th>
	                    <th data-options="field:'studyHours'">参与测试</th>
	                    <th data-options="field:'state'">提交作业</th>
	                    <th data-options="field:'isTemplate'">提问数</th>
	                    <th data-options="field:'isTemplate'">回答数</th>
	                    <th data-options="field:'isTemplate'">笔记数</th>
	                    <th data-options="field:'isTemplate'">研讨数</th>
	                    <th data-options="field:'isTemplate'">资源数</th>
	                    <th data-options="field:'isTemplate'">获得学分</th>
	                    <th data-options="field:'isTemplate'">学习成绩</th>
	                </tr>
	            </thead>
	            <tbody>
	                <@courseRegisterStatDirective realName=(realName[0])! courseId=(courseId[0])!  page=(pageBounds.page)!1 limit=(pageBounds.limit)!10 orders='CREATE_TIME.DESC'>
					<#list courseRegisterStats as crs>
						<tr>
							<td>-</td>
							<td>${(crs.courseRegister.user.realName)!}</td>
							<td>身份证</td>
							<td>${(crs.courseRegister.user.deptName)!}</td>
							<td>${(crs.completeVideoNum)!}</td>
							<td>${(crs.completeDiscussionNum)!}</td>
							<td>${(crs.completeTestNum)!}</td>
							<td>${(crs.completeAssignmentNum)!}</td>
							<td>${(crs.faqQuestionNum)!}</td>
							<td>${(crs.faqAnswerNum)!}</td>
							<td>${(crs.noteNum)!}</td>
							<td>${(crs.discussionNum)!}</td>
							<td>${(crs.uploadResourceNum)!}</td>
							<td>${(crs.courseResult.score)!0}</td>
							<td>
								<#if (crs.courseResult.state)??>
									<#if crs.courseResult.state = 'pass'>
										合格
									<#elseif crs.courseResult.state = 'nopass'>
										未达标
									<#else>
										-
									</#if>
								<#else>
								未达标
								</#if>
							</td>
						</tr>
					</#list>
					</@courseRegisterStatDirective>
	            </tbody>
	            <tfoot>
	                <tr>
	                    <td colspan="10">
	                    	 <#if paginator??>
						    	<#import "/nts/include/pagination.ftl" as p/>
						    	<@p.pagination paginator=paginator formId="listStudentCourseStatForm" divId="content"/>
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
		$('#listStudentCourseStatTable').datagrid();
	});
	
	
</script>