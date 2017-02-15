<form id="saveRolePermissionForm" action="${ctx!}/auth_roles/grant/permission" method="put">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<input type="hidden" name="id" value="${(authRole.id)!}">
	<div class="mis-content">
		<div class="zTreeDemoBackground left">
			<ul id="rolePermissionTree" class="ztree hasChk"></ul>
	    </div>
    </div>
	<br>
	<div class="mis-btn-row indent1">
        <button onclick="saveRolePermission()" type="button" class="mis-btn mis-main-btn"><i class="mis-save-ico"></i>保存</button>
    </div>
</form>
<script type="text/javascript">

	$(function(){
		$.ajaxSetup({
			cache : false
		});
	
		$.get("${ctx!}/auth_resources/api?limit=9999",null,function(responseData){
			var treeNodes = new Array();
			for(var i = 0 ; i < responseData.length ; i++) {
				node = responseData[i];
				var parentId = "";
				if(node.parent != undefined && node.parent != null){
					parentId = node.parent.id
				}
				var treeNode = {id:node.id,name:node.name,pId:parentId,open:true};
				treeNodes.push(treeNode);
				if(node.permissions){
					for(var j = 0 ; j < node.permissions.length ; j++){
						var permission = node.permissions[j];
						var treePermissionNode = {id:permission.id,name:permission.name,pId:node.id};
						treeNodes.push(treePermissionNode);
					}
				}
			};
			
			var setting = {
				check: {
					enable: true
				},
				data: {
					simpleData: {
						enable: true
					}
				},
				callback: {
				}
			};  
			
			$.fn.zTree.init($("#rolePermissionTree"), setting, treeNodes);
			//树打开关闭
    		misTreeFn(2,true);
			getSelect();
		});
	});

	function getSelect(){
		var permissionIdsStr = '${permissionIds!}';
		var permissionIds = $.parseJSON(permissionIdsStr);
		var treeObj = $.fn.zTree.getZTreeObj("rolePermissionTree");
		var nodes = treeObj.getNodes();
		$.each(nodes,function(i,n){
			var childrenNodes = nodes[i].children;
			if(childrenNodes){			
				$.each(childrenNodes,function(ci,cn){
					$.each(permissionIds,function(ii,nn){
						if(cn.id == nn){
							treeObj.checkNode(childrenNodes[ci], true, true);
						}
					});
				});
			}
		});
	};

	function saveRolePermission() {
		var treeObj = $.fn.zTree.getZTreeObj("rolePermissionTree");
		var nodes = treeObj.getCheckedNodes(true);
		$.each(nodes,function(i){
			$('#saveRolePermissionForm').append('<input type="hidden" name="permissions['+i+'].id" value='+nodes[i].id+'>');
		});
		var data = $.ajaxSubmit('saveRolePermissionForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			$.messager.alert("提示信息", "操作成功！", 'info', function() {
				easyui_modal_close('editRolePermissionDiv');
			});
		}
	};
</script>