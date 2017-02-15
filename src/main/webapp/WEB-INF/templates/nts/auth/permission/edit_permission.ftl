<form id="savePermissionForm" action="${ctx!}/auth_permissions/save" method="post">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0]/>
	<#if (permission.id)??>
		<input type="hidden" name="id" value="${(permission.id)!}">
		<script type="text/javascript">
			$('#savePermissionForm').attr('action','${ctx!}/auth_permissions/update').attr('method','put');
		</script>
	</#if>
	<input type="hidden" value="nts" name="relationId">
	<div class="mis-srh-layout">
		<ul class="mis-ipt-lst">
			<li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>名称：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="text" name="name" value="${(permission.name)!}" placeholder="请输入名称..." class="mis-ipt required">
	                    </div>
	                </div>
	            </div>
	        </li>
	        <li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>ACTION：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="text" name="action" value="${(permission.action)!}" placeholder="请输入ACTION..." class="mis-ipt required">
	                    </div>
	                </div>
	            </div>
	        </li>
	        <li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>地址：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="text" name="actionURI" value="${(permission.actionURI)!}" placeholder="请输入地址..." class="mis-ipt">
	                    </div>
	                </div>
	            </div>
	        </li>
	        <li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>父分组：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-select">
	                        <select name="resource.id" id="roleResourceSelect">
	                        </select>    
	                    </div>
	                </div>
	            </div>
	        </li>
		</ul>
	</div>
	<div class="mis-btn-row indent1">
        <button onclick="savePermission()" type="button" class="mis-btn mis-main-btn"><i class="mis-save-ico"></i>保存</button>
    </div>
</form>

<script type="text/javascript">
	$(function () {
		$.ajaxSetup({
			cache : false
		});
		
		var resourceId = '${(permission.resource.id)!}';
		
		$.get("${ctx!}/auth_resources/api?limit=9999",null,function(responseData){
			for(var i = 0 ; i < responseData.length ; i++) {
				if(resourceId == responseData[i].id){
					var optionStr = '<option value="' 
									+ responseData[i].id
									+ '" selected>' 
									+ responseData[i].name
									+ '</option>';
				}else{				
					var optionStr = '<option value="' 
									+ responseData[i].id
									+ '">' 
									+ responseData[i].name
									+ '</option>';
				}
				$('#roleResourceSelect').append(optionStr);
			};
		});
	});
	
	function savePermission() {
		if(!$('#savePermissionForm').validate().form()){
			return false;
		}
		var data = $.ajaxSubmit('savePermissionForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			$.messager.alert("提示信息", "操作成功！", 'info', function() {
				easyui_modal_close('editPermissionDiv');
				$.ajaxQuery('listPermissionForm', 'loadPermissionPage');
			});
		}
	}
</script>