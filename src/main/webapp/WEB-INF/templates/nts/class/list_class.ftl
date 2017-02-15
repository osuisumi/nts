<form id="listClassForm" action="${ctx}/manage/class"  method ="get">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	
	<div class="mis-srh-layout">
	    <ul class="mis-ipt-lst">
	        <li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>项目：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-select">
	                        <select id="projectParamSelect" name="projectId" onchange="changeProject(this)">
	                            <option value="">请选择...</option>
								<@projects>
									<#list projects as project>
										<option value="${project.id }">${project.name }</option>
									</#list>
								</@projects>  
	                        </select> 
	                        <script>
	                        	$(function(){
	                        		$('#listClassForm #projectParamSelect').find('option[value="${(projectId[0])!}"]').prop('selected', true);
	                        		$('#listClassForm #projectParamSelect').trigger('change');
	                        	});
	                        
	                        	function changeProject(obj){
		                        	var data = 'projectIds='+$(obj).val();
		                        	var $select = $('#listClassForm #trainParamSelect');
						        	$.get('/manage/train/api/trains',data,function(data){
						    			data.unshift({'name':'请选择','id':''});
						    			$select.empty();
						    			$(data).each(function(){
						    				var option = '<option value="'+this.id+'">'+this.name+'</option>';
						    				$select.append(option);
						    			});
						    			$select.find('option[value="${(class.relation.id)!}"]').prop('selected', true);
						    			$select.find('option[value="${(class.relation.id)!}"]').trigger('change');
						    		});
	                        	}
	                        </script>
	                    </div>
	                </div>
	            </div>
	        </li>
	        <li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>培训：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-select">
	                        <select id="trainParamSelect" name="relation.id" onchange="changeTrain(this)">
	                            <option value="">请选择...</option>
	                        </select> 
	                        <script>
	                        	function changeTrain(obj){
	                        		var data = 'relation.id='+$(obj).val();
	                        		var $select = $('#listClassForm #courseParamSelect');
	    				        	$.get('${ctx }/courseRelation/entities/course',data,function(data){
	    				    			data.unshift({'title':'请选择','id':''});
						    			$select.empty();
						    			$(data).each(function(){
						    				var option = '<option value="'+this.id+'">'+this.title+'</option>';
						    				$select.append($(option));
						    				$select.find('option[value="${(class.course.id)!}"]').prop('selected', true);
						    			});
						    		});
	                        	}
	                        </script>
	                    </div>
	                </div>
	            </div>
	        </li>
	        <li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>课程：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-select">
	                        <select id="courseParamSelect" name="course.id">
	                            <option value="">请选择...</option>
	                        </select> 
	                    </div>
	                </div>
	            </div>
	        </li>
	    </ul>
	    <div class="mis-btn-row indent1">
	        <button onclick="easyui_tabs_update('listClassForm','layout_center_tabs');" type="button" class="mis-btn mis-main-btn"><i class="mis-srh-ico"></i>查询</button>
			<a onclick="resetForm(this)"  class="mis-btn mis-default-btn">
				<i class="mis-refresh-ico"></i>重置
			</a>
	    </div>
	</div>
	
	<div class="mis-table-layout">
		<#if ('' != (class.course.id)!)>
		    <div class="mis-opt-row">
		        <div class="mis-opt-mod fl">
	        		<button onclick="addClass()" type="button" class="mis-btn mis-inverse-btn"><i class="mis-add-ico"></i>新建</button>
	        		<button onclick="editClass()" type="button" class="mis-btn mis-inverse-btn"><i class="mis-alter-ico"></i>修改</button>
		            <button onclick="deleteClass()" type="button" class="mis-btn mis-inverse-btn"><i class="mis-delete-ico"></i>删除</button>
	        	</div>
	    	</div>
	    <#else> 
	       	<div class="mis-table-srhTl">
                <i class="mis-srh-result"></i>
                <span>请选择课程后点击查询</span>
            </div>
	   	</#if>
	    <div class="mis-table-mod">
	    	<#if ('' != (class.course.id)!)>
	        	<table id="listClassTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
					<thead>
						<tr>
							<th width="50px" data-options="field:'id',checkbox:true"></th>
							<th data-options="field:'name'">班级名</th>
							<th data-options="field:'personNum'">班级人数</th>
						</tr>
					</thead>
					<tbody>
						<@classesDirective pageBounds=pageBounds courseId=(class.course.id)! relationId=(class.relation.id)!>
							<#list classes as class>
								<tr>
									<td>${class.id}</td>
									<td>${(class.name)!}</td>
									<td>${(class.personNum)!0}</td>
								</tr>
							</#list>
						</@classesDirective>
					</tbody>
					<tfoot>
		                <tr>
		                    <td colspan="10">
		                    	 <#if paginator??>
							    	<#import "../include/pagination.ftl" as p/>
							    	<@p.pagination paginator=paginator formId="listClassRegisterForm" divId="content"/>
								</#if>
		                    </td>
		                </tr>
		            </tfoot>
		        </table>
			</#if>
		</div>	
	</div>
</form>
<script>
	$(function(){
		$('#listClassTable').datagrid();
	});

	function addClass(relationId) {
		var url = '${ctx}/manage/class/create?course.id=${(class.course.id)!}&relation.id=${(class.relation.id)!}';
		easyui_modal_open('editClassDiv', '创建班级', 700, 300, url, true);
	}
	
	function editClass() {
		var row = $('#listClassForm').find('#listClassTable').datagrid('getSelections');	
		if (row.length == 0) {
			alert('请选择一行数据进行操作！');
			return false;
		}else if (row.length > 1) {
			alert('不能同时编辑多条数据');
			return false;
		}else {
			var id = row[0].id;
			easyui_modal_open('editClassDiv', '编辑班级', 700, 300, '${ctx}/manage/class/'+id+'/edit', true);
		}
	}
	
	function deleteClass(){
		var row = $('#listClassForm').find('#listClassTable').datagrid('getSelections');
		if (row.length == 0) {
			alert('请选择一行数据进行操作！');
			return false;
		}else {
			confirm('确认要删除选中记录吗？',function(r){
			   if(r){
			   	   var id = row[0].id;
				   $.ajaxDelete("${ctx}/manage/class", $('#listClassForm').serialize(), function(response){
				   		if(response.responseCode == '00'){
				   			easyui_tabs_update('listClassForm','layout_center_tabs')
				   		}
				   });
			   }    
			}); 
		} 
	}
</script>

