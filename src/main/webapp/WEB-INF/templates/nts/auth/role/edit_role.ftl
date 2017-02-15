<form id="saveRoleForm" action="${ctx!}/auth_roles/" method="post">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<input type="hidden" name="relationId" value="${(role.relationId)!'nts'}">
	<#if (role.id)??>
		<input id="roleId" type="hidden" name="id" value="${(role.id)!}">
		<script>
			$('#saveRoleForm').attr('action', '${ctx!}/auth_roles');
			$('#saveRoleForm').attr('method', 'put');
		</script>	
	</#if>
	<div class="mis-srh-layout">
    	<ul class="mis-ipt-lst">
	    	<li class="item">
				<div class="mis-ipt-row">
	                <div class="tl">
	                    <span>角色名称：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="text" name="name" value="${(role.name)!}" placeholder="请输入角色名称..." class="mis-ipt required">
	                    </div>
	                </div>
	            </div>
			</li>
			<li class="item">
				<div class="mis-ipt-row">
	                <div class="tl">
	                    <span>角色标识：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="text" name="code" value="${(role.code)!}" placeholder="请输入角色标识..." class="mis-ipt required">
	                    </div>
	                </div>
	            </div>
			</li>
			<li class="item">
				<div class="mis-ipt-row">
	                <div class="tl">
	                    <span>内容：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="text" name="summary" value="${(role.summary)!}" placeholder="请输入内容..." class="mis-ipt required">
	                    </div>
	                </div>
	            </div>
			</li>
		</ul>
	</div>
	<div class="mis-btn-row indent1">
        <button onclick="saveRole()" type="button" class="mis-btn mis-main-btn"><i class="mis-save-ico"></i>保存</button>
    </div>
</form>
<script type="text/javascript">
	function saveRole() {
		if(!$('#saveRoleForm').validate().form()){
			return false;
		}
		var data = $.ajaxSubmit('saveRoleForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			$.messager.alert("提示信息", "操作成功！", 'info', function() {
				easyui_tabs_update('listRoleForm', 'layout_center_tabs');
				easyui_modal_close('editRoleDiv');
			});
		}else{
			$.messager.alert("提示信息", "操作失败！", 'info');
		}
	}
</script>