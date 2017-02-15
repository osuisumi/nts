<form id="listClassUserForm" action="${ctx}/train/class/user"  method ="get">
	<input type="hidden" name="classId" value="${(classId[0])!}">
	<input type="hidden" name="trainId" value="${(trainId[0])!}">
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
							<input type="text" name="realName" value="${(realName[0])!}" placeholder="请输入名称..." class="mis-ipt">
						</div>
					</div>
				</div>
			</li>
		</ul>
		<div class="mis-btn-row indent1">
			<button onclick="easyui_tabs_update('listClassUserForm','layout_center_tabs');" type="button" class="mis-btn mis-main-btn"><i class="mis-srh-ico"></i>查询</button>
			<a onclick="resetForm(this)"  class="mis-btn mis-default-btn">
				<i class="mis-refresh-ico"></i>重置
			</a>
		</div>
	</div>

	<div class="mis-table-layout">
		<div class="mis-opt-row">
			<div class="mis-opt-mod fl">
				<a href="###" onclick="editClassUser()" class="mis-btn mis-inverse-btn"><i class="mis-add-ico"></i>设置班级学员</a>
			</div>
		</div>
		<div class="mis-table-mod">
			<table id="listClassUserTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
				<thead>
					<tr>
						<th width="50px" data-options="field:'id',checkbox:true"></th>
						<th  data-options="field:'name'">姓名</th>
						<th  data-options="field:'project.name'">身份证</th>
						<th  data-options="field:'description'">单位</th>
					</tr>
				</thead>
				<tbody>
					<@trainRegisterExtendsDirective page=(pageBounds.page)!1 orders=orders!'CREATE_TIME.DESC' limit=(pageBounds.limit)!10 classId=(classId[0])! realName=(realName[0])! >
						<#if trainRegisterExtends??>
							<#list trainRegisterExtends as tre>
								<tr>
									<td>${tre.id}</td>
									<td>${(tre.userInfo.realName)!}</td>
									<td>${(tre.userInfo.paperworkNo)!}</td>
									<td>${(tre.userInfo.deptName)!}</td>
								</tr>
							</#list>					
						</#if>
					</@trainRegisterExtendsDirective>
				</tbody>
	            <tfoot>
	                <tr>
	                    <td colspan="9">
	                    	 <#if paginator??>
						    	<#import "/nts/include/pagination.ftl" as p/>
						    	<@p.pagination paginator=paginator formId="listClassUserForm" divId="content"/>
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
		$('#listClassUserTable').datagrid();
	});

	function editClassUser(){
		load_next_content('${ctx}/manage/train/class/editUser?trainId=${(trainId[0])!}&classId=${(classId[0])!}', 'listClassUserForm', '编辑班级');
	}
	
</script>