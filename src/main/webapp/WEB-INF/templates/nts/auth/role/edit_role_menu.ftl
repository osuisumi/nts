<form id="saveRoleMenuForm" action="${ctx!}/auth_roles/grant/menu" method="put">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<input type="hidden" name="id" value="${(authRole.id)!}">
	<div class="mis-content">
		<div class="zTreeDemoBackground left">
			<ul id="roleMenuTree" class="ztree hasChk"></ul>
	    </div>
    </div>
	<br>
	<div class="mis-btn-row indent1">
        <button onclick="saveRoleMenu()" type="button" class="mis-btn mis-main-btn"><i class="mis-save-ico"></i>保存</button>
    </div>
</form>
<script type="text/javascript">
	$(function () {
		$.ajaxSetup({
			cache : false
		});
	
		$.get("${ctx!}/auth_menus?limit=9999",null,function(responseData){
			var treeNodes = new Array();
			for(var i = 0; i < responseData.length; i++) {
				node = responseData[i];
				var parentId = "";
				if(node.parent != undefined && node.parent != null){
					parentId = node.parent.id
				}
				if(parentId != ''){
					treeNodes[i] = {id:node.id,name:node.name,pId:parentId};
				}else{
					treeNodes[i] = {id:node.id,name:node.name,pId:parentId,open:true};
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
			
			$.fn.zTree.init($("#roleMenuTree"), setting, treeNodes);
			//树打开关闭
    		misTreeFn(2,true);
			getSelect();
		})
	});
 
	function getSelect(){
		var menusStr = '${menuIds!}';
		var menu = $.parseJSON(menusStr);
		var treeObj = $.fn.zTree.getZTreeObj("roleMenuTree");
		var nodes = treeObj.getNodes();
		$.each(nodes,function(i,n){
			var childrenNodes = nodes[i].children;
			if(childrenNodes){			
				$.each(childrenNodes,function(ci,cn){
					$.each(menu,function(ii,nn){
						if(cn.id == nn){
							treeObj.checkNode(childrenNodes[ci], true, true);
						}
					})
				})
			}
		})
	};

	function saveRoleMenu() {
		var treeObj = $.fn.zTree.getZTreeObj("roleMenuTree");
		var nodes = treeObj.getCheckedNodes(true);
		$('#saveRoleMenuForm .menuParam').empty();
		$(nodes).each(function(i){
			$('#saveRoleMenuForm').append('<input type="hidden" name="menus['+i+'].id" value="'+this.id+'">');
		});
		var data = $.ajaxSubmit('saveRoleMenuForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			$.messager.alert("提示信息", "操作成功！", 'info', function() {
				easyui_modal_close('editRoleMenuDiv');
			});
		}
	};
	
</script>