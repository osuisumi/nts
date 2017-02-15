<form id="listResourceForm" action="${ctx}/auth_resources" method ="get" style="min-height:500px">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
    <div class="mis-mod">
        <div class="mis-column-innerBox mis-block-cont">
            <div class="mis-column-innerL">
                <div class="mis-mod-tt">
                    <h2 class="tt t1">
                        <span>权限组</span>
                    </h2>
                    <div class="mis-go-shrink">
                         <i onclick="deleteRoleResource();" class="mis-delete-ico"></i>
                         <i onclick="updateRoleResource();" class="mis-alter-ico"></i>
                         <i onclick="addRoleResource();" class="mis-add-ico"></i>
                     </div>    
                </div>
                <div class="mis-ztree">
                    <ul id="roleResourceTree" class="ztree hasChk"></ul>
                </div>  
            </div>
            <div class="mis-column-innerR">
                <div class="mis-mod-tt">
                    <h2 class="tt t1">
                        <span>权限列表</span>
                    </h2>  
                </div>                         
                <div id="loadPermissionPage">
                </div>
            </div>
        </div>
    </div>
</form>

<script>
	$(function () {
		$.ajaxSetup({
			cache : false
		});
		
		$.get("${ctx!}/nts/auth_resources/api?limit=9999",null,function(responseData){
			var treeNodes = new Array();
			for(var i =0 ; i < responseData.length ; i++) {
				node = responseData[i];
				var parentId = "";
				if(node.parent != undefined && node.parent != null){
					parentId = node.parent.id;
				}
				var treeNode = {id:node.id,name:node.name,pId:parentId,open:true};
				treeNodes.push(treeNode);
		    };
		    
		    var setting = {
				check: {
					enable: true,
					chkboxType :{ "Y" : "", "N" : "" }
				},
				data: {
					simpleData: {
						enable: true
					}
				},
				callback : {
					onClick: zTreeOnClick,
					beforeEditName : zTreeBeforeEditName,
					beforeRemove: zTreeBeforeRemove
				},
				edit: {
			        enable: true,
			        renameTitle: '编辑',
        			removeTitle: '删除'
			    }
			}; 
			
			$.fn.zTree.init($("#roleResourceTree"), setting, treeNodes);
		});
	});
	
	function zTreeBeforeRemove(treeId, treeNode){
		$.messager.confirm('确认',"确认删除 节点 -- " + treeNode.name + " 吗？",function(r){    
		    if(r){
		    	console.log(r);
		    	$.ajaxDelete("${ctx!}/nts/auth_resources/" + treeNode.id,null,function(response){
					if(response.responseCode == '00'){
						alert('操作成功');
						var treeObj = $.fn.zTree.getZTreeObj("roleResourceTree");
						treeObj.removeNode(treeNode);
					}
				});
		    }
		    return r;
		});
		return false;
	};

	function zTreeBeforeEditName(treeId, treeNode){
		var url = '${ctx!}/nts/auth_resources/' + treeNode.id + "/edit";
		console.log(url);
		easyui_modal_open('editResourceDiv', '修改组', 800, 300, url, true);
		return false;
	};

	function zTreeOnClick(event, treeId, treeNode){
		loadPermissionPage(treeNode.id);
	};

	function loadPermissionPage(resourceId){
		$('#loadPermissionPage').load('${ctx!}/auth_permissions?resource.id=' + resourceId );
	};
	
	function reload(){
		$.ajaxQuery('listResourceForm', 'content');
	};
	
	function addRoleResource(){
		var url = '${ctx!}/nts/auth_resources/create';
		easyui_modal_open('editResourceDiv', '新增组', 800, 300, url, true);
	};
	
	function deleteRoleResource(){
		var treeObj = $.fn.zTree.getZTreeObj("roleResourceTree");
		var nodes = treeObj.getCheckedNodes();
		if(nodes.length == 0){
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if(nodes.length > 1) {
			$.messager.alert('提示', '不能同时删除多条数据', 'warning');
			return false;
		}else{
			$.ajaxDelete("${ctx!}/nts/auth_resources/" + nodes[0].id,null,function(response){
				if(response.responseCode == '00'){
					alert('操作成功');
					easyui_tabs_update('listResourceForm','layout_center_tabs');
				}
			});
		}
	};
	
	function updateRoleResource(){
		var treeObj = $.fn.zTree.getZTreeObj("roleResourceTree");
		var nodes = treeObj.getCheckedNodes();
		
		if(nodes.length == 0){
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if(nodes.length > 1) {
			$.messager.alert('提示', '不能同时编辑多条数据', 'warning');
			return false;
		}else{
			var url = '${ctx!}/nts/auth_resources/' + nodes[0].id + "/edit";
			easyui_modal_open('editResourceDiv', '修改组', 800, 300, url, true);
		}
	};
</script>