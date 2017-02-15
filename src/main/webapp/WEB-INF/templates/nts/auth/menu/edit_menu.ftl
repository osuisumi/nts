<form id="saveMenuForm" action="${ctx!}/auth_menus/save" method="post">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0]/>
	<input type="hidden" name="relationId" value="nts">
	<#if (menu.id)??>
	<input id="id" type="hidden" name="id" value="${(menu.id)!}">
	</#if>
	
	<div class="mis-srh-layout">
    	<ul class="mis-ipt-lst">
	    	<li class="item">
				<div class="mis-ipt-row">
	                <div class="tl">
	                    <span>菜单名称：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="text" name="name" value="${(menu.name)!}" placeholder="请输入菜单名称..." class="mis-ipt required">
	                    </div>
	                </div>
	            </div>
			</li>
			<li class="item">
				<div class="mis-ipt-row">
	                <div class="tl">
	                    <span>排序：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="text" name="orderNo" value="${(menu.orderNo)!}" placeholder="请输入排序数..." class="mis-ipt required">
	                    </div>
	                </div>
	            </div>
			</li>
			<li class="item">
				<div class="mis-ipt-row">
	                <div class="tl">
	                    <span>父菜单：</span>
	                </div>
	                <div class="tc">
						<div class="mis-ipt-mod">
							<input id="parentMenuSelect" onclick="show_editMenu_parentMenuTree(); return false;" type="text" class="mis-ipt" readonly >
							<input type="hidden" id="parentId" name="parent.id" class="mis-ipt" value="${(menu.parent.id)!}">
						</div>
					</div>
	                <div class="tc" style="border:1px solid;">
						<ul id="editMenu_parentMenuTree" class="ztree"></ul>
					</div>
	            </div>
			</li>
			<li class="item">
				<div class="mis-ipt-row">
	                <div class="tl">
	                    <span>访问地址：</span>
	                </div>
	                <div class="tc">
						<div class="mis-ipt-mod">
							<input id="permissionSelect" onclick="show_editMenu_permissionTree(); return false;" type="text" class="mis-ipt" readonly >
							<input type="hidden" id="permissionId" name="permission.id" class="mis-ipt" value="${(menu.permission.id)!}">
						</div>
					</div>
					<div class="tc" style="border:1px solid;">
						<ul id="editMenu_permissionTree" class="ztree"></ul>
					</div>
	            </div>
			</li>
		</ul>
	</div>
	<div class="mis-btn-row indent1">
        <button onclick="saveMenu()" type="button" class="mis-btn mis-main-btn"><i class="mis-save-ico"></i>保存</button>
    </div>
</form>
<script type="text/javascript">
	$(function(){
		
		$.ajaxSetup({
			cache : false
		});
		
		var permissionId = '${(menu.permission.id)!}';
		
		$.get("${ctx!}/auth_resources/api?limit=99999",null,function(responseData){
			var treeNodes = new Array();
			var resourceNode = {name:'请选择...',uri:'请选择...'};
			treeNodes.push(resourceNode);
			for(var i = 0 ; i < responseData.length ; i++){
				var node = responseData[i];
				var parentId = "";
				var uri = "";
				if(node.parent != undefined && node.parent != null){
					parentId = node.parent.id
				}
				var resourceNode = {id:node.id,name:node.name,pId:parentId,uri:uri,open:true};
				treeNodes.push(resourceNode);
				if(node.permissions){
					for(var j = 0 ; j < node.permissions.length ; j++){
						var permission = node.permissions[j];
						var permissionNode = {id:permission.id,name:permission.name,pId:node.id,uri:permission.actionURI};
						treeNodes.push(permissionNode);
					}
				}
			};
			
			var setting = {
				data: {
					simpleData: {
						enable: true
					}
				},
				callback : {
					onClick: editMenu_permissionTreeOnClick,
				}
			}; 
			
			$.fn.zTree.init($("#editMenu_permissionTree"), setting, treeNodes);
			//树打开关闭
    		misTreeFn(2,true);
			$("#editMenu_permissionTree").hide();
			
			if(permissionId != ''){			
				var treeObj = $.fn.zTree.getZTreeObj("editMenu_permissionTree");
				var treeNode = treeObj.getNodeByParam('id',permissionId, null);
				$('#permissionId').val(treeNode.id);
				$('#permissionSelect').val(treeNode.uri);
			}
		});
		
		var parentMenuId = '${(menu.parent.id)!}';
		var menuId = '${(menu.id)!}';
		
		$.get("${ctx!}/auth_menus?limit=9999",null,function(responseData){
			var treeNodes = new Array();
			var menuNode = {name:'请选择...'};
			treeNodes.push(menuNode);
			for(var i = 0 ; i < responseData.length ; i++) {
		    	node = responseData[i];
		  		var parentId = "";
		  		if(node.parent != undefined && node.parent != null){
			  		parentId = node.parent.id
		  		}
		  		var menuNode = {id:node.id,name:node.name,pId:parentId};
		  		treeNodes.push(menuNode);
	  		};
	  		
	  		var setting = {
				data: {
					simpleData: {
						enable: true
					}
				},
				callback : {
					onClick: editMenu_parentMenuTreeOnClick
				}
			};
			
			$.fn.zTree.init($("#editMenu_parentMenuTree"), setting, treeNodes);
			//树打开关闭
			misTreeFn(2,true);
			$("#editMenu_parentMenuTree").hide();
			
			if(parentMenuId != ''){	
				var treeObj = $.fn.zTree.getZTreeObj("editMenu_parentMenuTree");
				var treeNode = treeObj.getNodeByParam('id',parentMenuId, null);
				$('#parentId').val(treeNode.id);
				$('#parentMenuSelect').val(treeNode.name);
				if(menuId != ''){
					var treeNode = treeObj.getNodeByParam('id',menuId, null);
					treeObj.removeNode(treeNode);
				}
			}
		});
	});

	function show_editMenu_parentMenuTree(){
		$("#editMenu_parentMenuTree").show();
	};
	
	function editMenu_parentMenuTreeOnClick(event, treeId, treeNode){
		$('#parentId').val(treeNode.id);
		$('#parentMenuSelect').val(treeNode.name);
		$("#editMenu_parentMenuTree").hide();
	};
	
	function editMenu_permissionTreeOnClick(event, treeId, treeNode){
		$('#permissionId').val(treeNode.id);
		$('#permissionSelect').val(treeNode.uri);
		$("#editMenu_permissionTree").hide();
	};

	function show_editMenu_permissionTree(){
		$("#editMenu_permissionTree").show();
	};
	
	function saveMenu() {
		var id = $('#id').val();
		if(id){
			$('#saveMenuForm').attr('action','${ctx!}/auth_menus/update');
			$('#saveMenuForm').attr('method','put');
		}
		if(!$('#saveMenuForm').validate().form()){
			return false;
		}
		var data = $.ajaxSubmit('saveMenuForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			$.messager.alert("提示信息", "操作成功！", 'info', function() {
				easyui_modal_close('editMenuDiv');
				$.ajaxQuery('listMenuForm', 'content');
			});
		}else{
			alert("操作失败");
		}
	};
</script>