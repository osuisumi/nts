<form id="listCourseWorkerStatForm" action="${ctx}/manage/course/worker_stat"  method ="get">
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
		</ul>
		<div class="mis-btn-row indent1">
			<button onclick="easyui_window_update('listCourseWorkerStatForm','layout_center_tabs');" type="button" class="mis-btn mis-main-btn"><i class="mis-srh-ico"></i>查询</button>
			<a onclick="resetForm(this)"  class="mis-btn mis-default-btn">
				<i class="mis-refresh-ico"></i>重置
			</a>
		</div>
	</div>

	<div class="mis-table-layout">
		 <div class="mis-opt-row">
	        <div class="mis-opt-mod fl">
	            <button onclick="expertCourseWorkerStat()" type="button" class="mis-btn mis-inverse-btn"><i class="mis-delete-ico"></i>导出</button>
	        </div>
	    </div>
		<div class="mis-table-mod">
			<table id="listCourseWorkerStatTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
				<thead>
					<tr>
						<th width="50px" data-options="field:'id',checkbox:true"></th>
						<th  data-options="field:'realName'">姓名</th>
						<th  data-options="field:'role'">角色</th>
						<th  data-options="field:'train'">培训</th>
						<th  data-options="field:'title'">课程名称</th>
						<th  data-options="field:'studentNum'">选课人数</th>
						<th  data-options="field:'qualifiedPersent'">通过率</th>
						<th  data-options="field:'actNum'">回答问题</th>
						<th  data-options="field:'faqAnserNum'">上传资源</th>
						<th  data-options="field:'uploadResource'">作业总数</th>
						<th  data-options="field:'command'">批改作业</th>
					</tr>
				</thead>
				<tbody>
					<@courseAuthorizeStatsDirective realName=(realName[0])! role="teacher"  limit=10 page=(pageBounds.page)!1>
						<#if courseAuthorizeStats??>
							<#list courseAuthorizeStats as cas>
								<tr>
									<td>${(cas.courseAuthorize.id)!}</td>
									<td>${(cas.courseAuthorize.user.realName)!}</td>
									<td>
										<#if (cas.courseAuthorize.role)??>
											<#if cas.courseAuthorize.role = 'teacher'>助学</#if>
										</#if>
									</td>
									<td>${(cas.train.name)!}</td>
									<td>${(cas.course.title)!}</td>
									<td>${(cas.courseRegisterNum)!}</td>
									<td>
										${(cas.passPersent)!}
									</td>
									<td>${(cas.faqAnswerNum)!}</td>
									<td>${(cas.uploadResourceNum)!}</td>
									<td>${(cas.courseSubmitAssignmentNum)!}</td>
									<td>${(cas.markedAssignmentNum)!}</td>
								</tr>
							</#list>
						</#if>
					</@courseAuthorizeStatsDirective>
				</tbody>
	            <tfoot>
	                <tr>
	                    <td colspan="11">
	                    	 <#if paginator??>
						    	<#import "/nts/include/pagination.ftl" as p/>
						    	<@p.pagination paginator=paginator formId="listCourseWorkerStatForm" divId="content"/>
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
		$('#listCourseWorkerStatTable').datagrid();
	});
	
	function expertCourseWorkerStat(){
		var total = "${(paginator.totalCount)!0}";
		total = parseInt(total);
		if(total<=0){
			alert('没有数据');
			return false;
		}
		mylayerFn.open({
			id : 'exportCourseWorkerStat',
			type : 2,
			title : '导出设置',
			content : '${ctx}/manage/course/editExport?role=teacher&realName=${(realName[0])!}&total='+total,
			area : [500, 300],
			offset : ['auto', 'auto'],
			fix : false,
		});
	}
	
</script>


