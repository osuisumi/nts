<form id="listMenuForm" action="${ctx}/nts/auth_menus/list" method="get">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<div class="mis-table-layout">
		<div class="mis-opt-row">
			<div class="mis-opt-mod fl">
				<button onclick="addMenu();" type="button" class="mis-btn mis-inverse-btn">
					<i class="mis-add-ico"></i>新建
				</button>
				<button onclick="editMenu();" type="button" class="mis-btn mis-inverse-btn">
					<i class="mis-alter-ico"></i>修改
				</button>
				<button onclick="deleteMenu();"  type="button" class="mis-btn mis-inverse-btn" >
					<i class="mis-delete-ico"></i>删除
				</button>
			</div>
		</div>
		<div class="mis-table-mod">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
				<thead>
					<tr>
						<th width="50px" data-options="field:'id',checkbox:true">选项</th>
						<th width="250px" data-options="field:'name'">菜单名</th>
						<th width="250px" data-options="field:'uri'">链接</th>
						<th width="250px" data-options="field:'orderNo'">序号</th>
					</tr>
				</thead>
			</table>
		<ul id="rolePermissionTree" class="ztree"></ul>
		</div>
	</div>
</form>
<script>
	$(function () {
		$.ajaxSetup({
			cache : false
		});
		
		$.get("${ctx!}/nts/auth_menus?limit=9999",null,function(responseData){
			var treeNodes = new Array();
			for(var i =0; i < responseData.length; i++) {
				node = responseData[i];
				var parentId = "";
				if(node.parent != undefined && node.parent != null){
					parentId = node.parent.id
				}
				var uri = "";
				if(node.permission != undefined && node.permission != null){
					uri = node.permission.actionURI;
				}
				treeNodes[i] = {id:node.id,name:node.name,pId:parentId,uri:uri,orderNo:node.orderNo};
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
				callback: {
				},
				view: {
					addDiyDom: addDiyDom
				}
			};  
			
			$.fn.zTree.init($("#rolePermissionTree"), setting, treeNodes);
			//树打开关闭
    		misTreeFn(2,true);
		});
		
	});
	
	function addDiyDom(treeId, treeNode) {
		var switchObj = $("#" + treeNode.tId + "_switch");
		var tableStr = '<table width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table"><tbody><tr><td width="50px;"></td><td width="250px;"></td><td width="250px;"></td><td width="250px;"></td></tr></tbody></table>';
		switchObj.after(tableStr);
		var checkObj = $("#" + treeNode.tId + "_check");
		checkObj.remove();
		$('#' + treeNode.tId).find('table').find('td:eq(0)').append(checkObj);
		var aObj = $("#" + treeNode.tId + "_a");
		aObj.css('float','left');
		aObj.remove();
		$('#' + treeNode.tId).find('table').find('td:eq(1)').append(aObj);
		$('#' + treeNode.tId).find('table').find('td:eq(2)').append(treeNode.uri);
		$('#' + treeNode.tId).find('table').find('td:eq(3)').append(treeNode.orderNo);
		
		var childrenNodes = treeNode.children;
		if(childrenNodes != null){
			$.each(childrenNodes,function(i,n){
				var tableStr = '<table width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table"><tbody><tr><td width="50px;"></td><td width="250px;"></td><td width="250px;"></td><td width="250px;"></td></tr></tbody></table>';
				var switchObj = $("#" + n.tId + "_switch");
				switchObj.after(tableStr);
				var checkObj = $("#" + n.tId + "_check");
				checkObj.remove();
				$('#' + n.tId).find('table').find('td:eq(0)').append(checkObj);
				var aObj = $("#" + n.tId + "_a");
				aObj.css('float','left');
				aObj.remove();
				$('#' + n.tId).find('table').find('td:eq(1)').append(aObj);
				$('#' + n.tId).find('table').find('td:eq(2)').append(n.uri);
				$('#' + n.tId).find('table').find('td:eq(3)').append(n.orderNo);
			});
		}
	};
	
	function addMenu() {
		var url = '${ctx!}/nts/auth_menus/create';
		easyui_modal_open('editMenuDiv', '新增菜单', 800, 300, url, true);
	}

	function editMenu() {
		var treeObj = $.fn.zTree.getZTreeObj("rolePermissionTree");
		var nodes = treeObj.getCheckedNodes(true);
		if(nodes.length == 0){
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if(nodes.length > 1) {
			$.messager.alert('提示', '不能同时编辑多条数据', 'warning');
			return false;
		}else{
			easyui_modal_open('editMenuDiv', '修改菜单', 800, 300, '${ctx!}/nts/auth_menus/'+nodes[0].id+'/edit', true);
		}
	};
	
	function deleteMenu(){
		var treeObj = $.fn.zTree.getZTreeObj("rolePermissionTree");
		var nodes = treeObj.getCheckedNodes(true);
		if(nodes.length == 0){
			$.messager.alert('提示', '请选择至少一行数据进行操作！', 'warning');
			return false;
		}else{
			var hasParent = false;
			var id = '';
			for(var i = 0; i < nodes.length; i++){
				id = id + ',' + nodes[i].id ;
				if(nodes[i].children != null || nodes[i].children != undefined){				
					if(nodes[i].children.length > 0 && hasParent != true){
						hasParent = true;
					}
				}
			}
			if(hasParent){
				$.messager.confirm('确认','选中的菜单中包含一级菜单，删除该菜单将一并删除其所有的子菜单',function(r){
	    			if(r){
	    				$.ajaxDelete('${ctx!}/nts/auth_menus/batch/delete', '&id=' + id, function(){
							for (var i=0, l=nodes.length; i < l; i++) {
								treeObj.removeNode(nodes[i]);
							}
						});
	    			}
	    		});
			}else{
				$.messager.confirm('确认','确定删除所选菜单',function(r){
	    			if(r){
	    				$.ajaxDelete('${ctx!}/nts/auth_menus/batch/delete', '&id=' + id, function(){
							for (var i=0, l=nodes.length; i < l; i++) {
								treeObj.removeNode(nodes[i]);
							}
						});
	    			}
	    		});
			}
		}
	};

</script>