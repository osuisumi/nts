<#global app_path=PropertiesLoader.get('app.nts.path') >
<form id="listCourseRegisterForm" action="${ctx}/manage/courseRegister"  method ="get">
	<input type="hidden" name="course.id" value="${courseRegister.course.id}">
	<input type="hidden" name="relation.id" value="${courseRegister.relation.id}">
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
	                        <input type="text" name="realName" value="${(realName[0])!''}" placeholder="请输入姓名..." class="mis-ipt">
	                    </div>
	                </div>
	            </div>
	        </li>
	    </ul>
	    <div class="mis-btn-row indent1">
	        <button onclick="easyui_tabs_update('listCourseRegisterForm','layout_center_tabs');" type="button" class="mis-btn mis-main-btn"><i class="mis-srh-ico"></i>查询</button>
			<a onclick="resetForm(this)"  class="mis-btn mis-default-btn">
				<i class="mis-refresh-ico"></i>重置
			</a>
	    </div>
	</div>
	<div class="mis-table-layout">
	    <div class="mis-opt-row">
	        <div class="mis-opt-mod fl">
	            <button onclick="deleteCourseRegister()" type="button" class="mis-btn mis-inverse-btn"><i class="mis-delete-ico"></i>删除</button>
	            <button onclick="goImportCourseRegister()" type="button" class="mis-btn mis-inverse-btn" id="layerBtn2"><i class="mis-import-ico"></i>手动导入</button>
	            <#--<#if app_path = '/nts/lego'>
	            	<button onclick="goAutoImportCourseRegister()" type="button" class="mis-btn mis-inverse-btn" id="layerBtn2"><i class="mis-import-ico"></i>自动导入</button>
	            </#if>-->
	            <button onclick="updateCourseRegisterState('pass')" type="button" class="mis-btn mis-inverse-btn" id="layerBtn2"><i class="mis-pass-ico"></i>审核通过</button>
	            <button onclick="updateCourseRegisterState('nopass')" type="button" class="mis-btn mis-inverse-btn" id="layerBtn2"><i class="mis-unpass-ico"></i>审核不通过</button>
	        </div>
	    </div>
	    <div class="mis-table-mod">
        	<table id="listCourseRegisterTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
				<thead>
					<tr>
						<th width="50px" data-options="field:'id',checkbox:true"></th>
						<th data-options="field:'userInfoId',hidden:true"></th>
						<th data-options="field:'title'">姓名</th>
						<th data-options="field:'courseName'">课程名</th>
						<th data-options="field:'termNo'">单位</th>
						<th data-options="field:'state'">状态</th>
					</tr>
				</thead>
				<tbody>
					<@courseRegistersDirective realName=(realName[0])!'' relationId=courseRegister.relation.id courseId=courseRegister.course.id page=(pageBounds.page)!1 limit=(pageBounds.limit)!10 orders='CREATE_TIME.DESC'>
						<#list courseRegisters as cr>
							<tr>
								<td>${cr.id}</td>
								<td>${(cr.user.id)!}</td>
								<td>${(cr.user.realName)!}</td>
								<td>${(cr.course.title)!}</td>
								<td>${(cr.user.deptName)!}</td>
								<td>
									<#if cr.state! == 'submit'>
										待审核
									<#elseif cr.state! == 'pass'>
										已审核
									<#else>
										审核不通过							
									</#if>
								</td>
							</tr>
						</#list>
					</@courseRegistersDirective>
				</tbody>
				<tfoot>
	                <tr>
	                    <td colspan="10">
	                    	 <#if paginator??>
						    	<#import "../include/pagination.ftl" as p/>
						    	<@p.pagination paginator=paginator formId="listCourseRegisterForm" divId="content"/>
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
		$('#listCourseRegisterTable').datagrid();
	});

	function addCourseRegister(){
		/*var courseId = $('#courseSelect').combo('getValue');
		if(!courseId){
			alert('请在下拉框中选择课程');
			return false;
		}
		var node = $('#courseSelect').combotree('tree').tree('find',courseId);
		var trainNode = $('#courseSelect').combotree('tree').tree('getParent',node.target);*/
		easyui_modal_open('editCourseRegisterDiv', '新增选课', 700, 600, '${ctx}/manage/courseRegister/create', true);
	}
	
	function deleteCourseRegister(){
		var row = $('#listCourseRegisterForm').find('#listCourseRegisterTable').datagrid('getSelections');
		if (row.length == 0) {
			alert('请选择一行数据进行操作！');
			return false;
		}else if (row.length > 1) {
			alert('不能同时删除多条数据');
			return false;
		}else {
			confirm('确认要删除选中记录吗？',function(r){
				if(r){
					var id = row[0].id;
					   $.ajaxDelete("${ctx}/manage/courseRegister/"+id,null,function(response){
					   		if(response.responseCode == '00'){
					   			easyui_tabs_update('listCourseRegisterForm','layout_center_tabs')
					   		}
					   });
				}    
			}); 
		} 
	}
	
	function updateCourseRegisterState(state){
		var row = $('#listCourseRegisterForm').find('#listCourseRegisterTable').datagrid('getSelections');
		if (row.length == 0) {
			alert('请选择一行数据进行操作！', 'warning');
			return false;
		}else {
	    	//$('#listCourseForm input[name=state]').remove();
	    	var ids = '';
	    	var userIds = '';
	    	$.each(row,function(i,n){
	    		if(ids == ''){
	    			ids = n.id;
	    		}else{
	    			ids = ids + ',' + n.id;
	    		}
	    		if(userIds==''){
	    			userIds = n.userInfoId;
	    		}else{
	    			userIds = userIds + ',' + n.userInfoId;
	    		}
	    	});
	    	var msg = '确定要通过选中的选课吗?';
	    	if(state == 'nopass'){
	    		msg = '确定驳回选中的选课吗?';
	    	}
	    	confirm(msg, function(){
	    		$.put('${ctx}/manage/courseRegister', 'state='+state+'&id='+ids+'&userIds='+userIds, function(){
					easyui_tabs_update('listCourseRegisterForm', 'layout_center_tabs');
				});
	    	});
		}
	}
	
	function editCourseRegisterClass(){
		var row = $('#listCourseRegisterForm').find('#listCourseRegisterTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else {
			var isReturn = false;
			$.each(row,function(i,n){
				if(n.state.trim() != '已审核'){
					alert('请确保您选中的选课的状态都是已审核');
					isReturn = true;
					return false;
				}
			});
			if(isReturn){
				return false;
			}
	    	var ids = '';
	    	$.each(row,function(i,n){
	    		if(ids == ''){
	    			ids = n.id;
	    		}else{
	    			ids = ids + ',' + n.id;
	    		}
	    	});
    		var url = '${ctx}/manage/courseRegister/editCourseRegisterClass?id='+ids+'&course.id=${(courseRegisterExtend.course.id)!}&relation.id=${(courseRegisterExtend.relation.id)!}';
			easyui_modal_open('editCourseRegisterClassDiv', '设置班级', 700, 300, url, true);
		}
	}
	
	function goImportCourseRegister(){
		var courseId = '${courseRegister.course.id}';
		var trainId = '${courseRegister.relation.id}';
		//easyui_modal_open('importCourseRegisterDiv','导入选课',300,200,'${ctx}/courseRegister/goImport?courseId='+courseId+'&trainId='+trainId,true);
		load_next_content('${ctx}/courseRegister/goImport?courseId='+courseId+'&trainId='+trainId,'listCourseRegisterForm','导入选课');
	}
	
	function goAutoImportCourseRegister(){
		var courseId = '${courseRegister.course.id}';
		var trainId = '${courseRegister.relation.id}';
		load_next_content('${ctx}/courseRegister/goAutoImport?courseId='+courseId+'&trainId='+trainId,'listCourseRegisterForm','导入选课');
	}
	
	/*顶部combobox
	$(function(){
		var treeNodes=new Array();
		var trainIds = '';
		var projectIds = '';
		$.get('${ctx}/manage/project/api',{},function(projects){
			$.each(projects,function(i,n){
				if(projectIds == ''){
					projectIds = n.id;
				}else{
					projectIds = projectIds + ',' + n.id;
				};
				var node = {id:n.id,name:n.name,pid:'',type:'p'};
				treeNodes.push(node);
			});
			initTrainNodes();
		});
		
		function initTrainNodes(){
			$.get('${ctx}/manage/train/api/trains',{
				"projectIds":projectIds
			},function(trains){
				$.each(trains,function(i,n){
					if(trainIds == ''){
						trainIds = n.id;
					}else{
						trainIds = trainIds + ',' + n.id;
					};
					var node = {id:n.id,name:n.name,pid:n.project.id,type:'t'};
					treeNodes.push(node);
				});
				initCourseNodes(trainIds);
			});
		}
		
		function initCourseNodes(trainIds){
			$.get('${ctx}/manage/courseRelation/api/listCourseRelationByTrainIds',{
				"trainIds":trainIds
			},function(courseRelations){
				$.each(courseRelations,function(i,n){
					var node = {id:n.course.id,name:n.course.title,pid:n.relation.id,type:'c'};
					treeNodes.push(node);
				});
				$('#courseSelect').combotree({
					data:treeNodes,
					parentField: "pid",
					formatter:function(row){
						if(row.type=='p'){
							return "(项目)" + row.name;
						}else if(row.type == 't'){
							return "(培训)" + row.name;
						}else if(row.type == 'c'){
							return "(课程)" + row.name;
						}
						
					},
					onClick:function(rec){
						if(rec.type == 'c'){
							$('#courseSelect').combo('setValue',rec.id);
							$('#courseSelect').combo('setText',rec.name);
						}else{
							alert('请选择想要查看的课程');
							$('#courseSelect').combo('setValue','');
						}
					},
					onLoadSuccess:function(){
						var selectId = '${(courseRegisterExtend.course.id)!}';
						if(selectId){
							var node = $('#courseSelect').combotree('tree').tree('find',selectId);
								if(node){
									$('#courseSelect').combo('setValue',node.id);
									$('#courseSelect').combo('setText',node.name);
								}
						}
					}
				}).combobox("initClear");
			});
		}
	})
	*/
	
	/*
	$(function(){
		$('#projectSelect').combobox({
			onSelect:function(rec){
				$('#trainSelect').combobox('reload','${ctx}/train/api/trains?project.id='+rec.value);
			},
			onLoadSuccess:function(data){
				createTrainSelect();
				if(data.length>0){
					$('#projectSelect').combobox('select',data[0].value);
					$('#trainSelect').combobox('reload','${ctx}/train/api/trains?project.id='+data[0].value);
				}
			}
		});
		
	function createTrainSelect(){
		$('#trainSelect').combobox({
			valueField:'id',    
    		textField:'name',   
			onSelect:function(rec){
				$('#courseSelect').combobox('reload','${ctx}/train/api/trainCourses?trainId='+rec.id);	
			},
			onLoadSuccess:function(data){
				createCourseSelect();
				if(data.length>0){
					$('#trainSelect').combobox('select',data[0].id);
					$('#courseSelect').combobox('reload','${ctx}/train/api/trainCourses?trainId='+data[0].id);	
				}else{
					$('#trainSelect').combobox('clear');
				}
			}
		});
	
	}
	
	function createCourseSelect(){
		$('#courseSelect').combobox({
			valueField:'id',    
  			textField:'title',   
			onSelect:function(rec){
					
			},
			onLoadSuccess:function(data){
				if(data.length>0){
					$('#courseSelect').combobox('select',data[0].id);
				}else{
					$('#courseSelect').combobox('clear');
				}
				
			}
		});
	}
		
	})
*/
</script>

