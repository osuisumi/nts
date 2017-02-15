<@accountRoleAuthorizeData account=account >
	<#assign account=(account)!>
	<#assign roles=(roles)!>
</@accountRoleAuthorizeData>
<form id="accountRoleAuthorizeForm" action="${ctx!}/auth_roles/authAccountRoleAuthorize" method="post">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<input type="hidden" name="userIds" value="${(account.user.id)!}">
	<input type="hidden" name="relationId" value="nts">
	
	<div class="mis-srh-layout">
    	<ul class="mis-ipt-lst">
    		<li class="item">
				<div class="mis-ipt-row">
	                <div class="tl">
	                    <span>用户名：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input disabled type="text" value="${(account.userName)!}" placeholder="请输入用户名..." class="mis-ipt required">
	                    </div>
	                </div>
	            </div>
			</li>
			<li class="item">
				<div class="mis-ipt-row">
	                <div class="tl">
	                    <span>角色授权：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-select">
	                        <select name="id" id="">
	                        	<option value="">请选择...</option>
	                        	<#list roles as role>
									<option value="${(role.id)!}" <#if (account.roles[0].id)! == (role.id)!>selected="selected"</#if> >${(role.name)!}</option>  
								</#list>
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
	                        <input disabled type="text" value="${(account.user.realName)!}" placeholder="请输入用户名..." class="mis-ipt required">
	                    </div>
	                </div>
	            </div>
			</li>
    	</ul>
    </div>
	<div class="mis-btn-row indent1">
        <button onclick="saveAccountRole()" type="button" class="mis-btn mis-main-btn"><i class="mis-save-ico"></i>保存</button>
    </div>
</form>
<script type="text/javascript">
	function saveAccountRole() {
		if(!$('#accountRoleAuthorizeForm').validate().form()){
			return false;
		}
		var data = $.ajaxSubmit('accountRoleAuthorizeForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			$.messager.alert("提示信息", "操作成功！", 'info', function() {
				easyui_tabs_update('listAccountForm', 'layout_center_tabs');
				easyui_modal_close('editAuthAccountRoleAuthorizeDiv');
			});
		}else{
			$.messager.alert("提示信息", "操作失败！", 'warning');
		}
	}
</script>