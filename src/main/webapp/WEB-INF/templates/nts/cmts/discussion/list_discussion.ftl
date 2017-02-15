<#assign relationId='cmts'>
<#assign relationType='discussion'>
<form id="listCmtsDiscussionForm" action="${ctx}/manage/nts/cmts/discussion"  method ="get">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<input class="statusParam" type="hidden" name="statusEq" value="${(statusEq[0])!'' }">
	<input class="statusParam" type="hidden" name="statusNeq" value="${(statusNeq[0])!'' }">
	<div class="mis-srh-layout">
	    <ul class="mis-ipt-lst">
	    	<li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>标题：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="text" name="title" value="${(discussion.title)!}" placeholder="标题..." class="mis-ipt">
	                    </div>
	                </div>
	            </div>
	        </li>
	    	<li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>作者：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="text" name="creator.realName" value="${(discussion.creator.realName)!}" placeholder="作者..." class="mis-ipt">
	                    </div>
	                </div>
	            </div>
	        </li>
	        <li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>单位：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="text" name="creator.deptName" value="${(discussion.creator.deptName)!}" placeholder="单位..." class="mis-ipt">
	                    </div>
	                </div>
	            </div>
	        </li>
	        <li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>状态：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-select">
	                        <select id="statusSelect" name="state" onchange="
	                        	$('#listCmtsDiscussionForm .statusParam').val('');
					        	if($(this).val() == 'pass'){
					        		$('#listCmtsDiscussionForm input[name=\'statusNeq\']').val('refuse');
					        	}else if($(this).val() == 'no_pass'){
					        	    $('#listCmtsDiscussionForm input[name=\'statusEq\']').val('refuse');
					        	}
	                        ">
								<option value="">请选择...</option>
								<option value="pass">已通过</option>
								<option value="no_pass">未达标</option>
	                        </select>    
	                        <script>
	                        	$(function(){
	                        		if('${(statusNeq[0])!""}' != ''){
	    				            	$('#listCmtsDiscussionForm #statusSelect option[value="pass"]').prop('selected', true);
	    				            }else{
	    					            if('${(statusEq[0])!""}' != ''){
	    					            	$('#listCmtsDiscussionForm #statusSelect option[value="no_pass"]').prop('selected', true);
	    					            }
	    				            }
	                        	});
	                        </script>
	                    </div>
	                </div>
	            </div>
	        </li>
	    </ul>
	    <div class="mis-btn-row indent1">
	        <button onclick="easyui_tabs_update('listCmtsDiscussionForm','layout_center_tabs');" type="button" class="mis-btn mis-main-btn"><i class="mis-srh-ico"></i>查询</button>
			<a onclick="resetForm(this)"  class="mis-btn mis-default-btn">
				<i class="mis-refresh-ico"></i>重置
			</a>
	    </div>
	</div>
	<div class="mis-table-layout">
	    <div class="mis-opt-row">
	        <div class="mis-opt-mod fl">
	            <button onclick="addCmtsDiscussion()" type="button" class="mis-btn mis-inverse-btn"><i class="mis-add-ico"></i>新建</button>
	            <button onclick="editCmtsDiscussion()" type="button" class="mis-btn mis-inverse-btn"><i class="mis-alter-ico"></i>修改</button>
	            <button onclick="deleteCmtsDiscussion()" type="button" class="mis-btn mis-inverse-btn"><i class="mis-delete-ico"></i>删除</button>
	            <!-- <button onclick="updateCmtsDiscussionStatus('refuse', 0)" type="button" class="mis-btn mis-inverse-btn" ><i class="mis-pass-ico"></i>审核通过</button> -->
	            <button onclick="updateCmtsDiscussionStatus('refuse', -1)" type="button" class="mis-btn mis-inverse-btn" ><i class="mis-unpass-ico"></i>审核不通过</button>
	            <button onclick="goUpdateCmtsDiscussionStatus('top')" type="button" class="mis-btn mis-inverse-btn" ><i class="mis-top-ico"></i>置顶</button>
	            <button onclick="updateCmtsDiscussionStatus('top', 0)" type="button" class="mis-btn mis-inverse-btn" ><i class="mis-untop-ico"></i>取消置顶</button>
	            <button onclick="updateCmtsDiscussionStatus('essence', -1)" type="button" class="mis-btn mis-inverse-btn" ><i class="mis-authorization-ico"></i>设置精华</button>
	            <button onclick="updateCmtsDiscussionStatus('essence', 0)" type="button" class="mis-btn mis-inverse-btn" ><i class="mis-authorization-ico"></i>取消精华</button>
	        </div>
	    </div>
		<div class="mis-table-mod">
	        <table id="listCmtsDiscussionTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
	            <thead>
	                <tr>
	                    <th width="50px" data-options="field:'id',checkbox:true">选项</th>
						<th data-options="field:'title'">标题</th>
						<th data-options="field:'realName'">作者</th>
						<th data-options="field:'deptName'">所在单位</th>
						<th data-options="field:'createTime'">创建时间</th>
						<th data-options="field:'status_refuse'">状态</th>
						<th data-options="field:'topDays'">置顶天数</th>
						<th data-options="field:'status_essence'">是否精华</th>
	                </tr>
	            </thead>
	            <tbody>
	                <@discussionsDirective title=(discussion.title)!'' statusEq=(statusEq[0])!'' statusNeq=(statusNeq[0])!'' getStatus=true deptName=(discussion.creator.deptName)!'' realName=(discussion.creator.realName)!'' relationId=relationId relationType=relationType page=(pageBounds.page)!1 limit=(pageBounds.limit)!10 orders='CREATE_TIME.DESC' >
						<#list discussions as discussion>
							<tr>
								<td>${discussion.id}</td>
								<td><a href="###" onclick="previewDiscussion('${discussion.id}')">${(discussion.title)!}</a></td>
								<td>${(discussion.creator.realName)!}</td>
								<td>${(discussion.creator.deptName)!}</td>
								<td>${TimeUtils.formatDate(discussion.createTime, 'yyyy-MM-dd')}</td>
								<td>
									<#if 0 != (statusMap[discussion.id].refuse.days)!0 >
										未达标
									<#else>	
										已通过
									</#if>
								</td>
								<td>${(statusMap[discussion.id].top.days)!'' }</td>
								<td>
									<#if 0 != (statusMap[discussion.id].essence.days)!0 >
										精华
									</#if>
								</td>
							</tr>
						</#list>
					</@discussionsDirective>
	            </tbody>
	            <tfoot>
	                <tr>
	                    <td colspan="10">
	                    	 <#if paginator??>
						    	<#import "/nts/include/pagination.ftl" as p/>
						    	<@p.pagination paginator=paginator formId="listCmtsDiscussionForm" divId="content"/>
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
		$('#listCmtsDiscussionTable').datagrid();
	});
	
	function addCmtsDiscussion(relationId) {
		var url = '${ctx}/manage/nts/cmts/discussion/create?discussionRelations[0].relation.id=${relationId}&discussionRelations[0].relation.type=${relationType}';
		easyui_modal_open('editCmtsDiscussionDiv', '创建研说', 800, 600, url, true);
	}

	function editCmtsDiscussion() {
		var row = $('#listCmtsDiscussionForm').find('#listCmtsDiscussionTable').datagrid('getSelections');	
		if (row.length == 0) {
			alert('请选择一行数据进行操作！');
			return false;
		}else if (row.length > 1) {
			alert('不能同时编辑多条数据');
			return false;
		}else {
			var id = row[0].id;
			easyui_modal_open('editCmtsDiscussionDiv', '编辑课程', 800, 600, '${ctx}/manage/nts/cmts/discussion/'+id+'/edit', true);
		}
	}
	
	function deleteCmtsDiscussion(){
		var row = $('#listCmtsDiscussionForm').find('#listCmtsDiscussionTable').datagrid('getSelections');
		if (row.length == 0) {
			alert('请选择一行数据进行操作！');
			return false;
		}else {
			confirm('确认要删除选中记录吗？',function(r){
			   if(r){
				   var idsData = formParamSerizlize($('#listCmtsDiscussionForm :checkbox[name=id]:checked')); 
				   $.ajaxDelete("${ctx}/manage/discussion", 'id='+idsData, function(response){
				   		if(response.responseCode == '00'){
				   			easyui_tabs_update('listCmtsDiscussionForm','layout_center_tabs')
				   		}
				   });
			   }    
			}); 
		} 
	}
	
	function goUpdateCmtsDiscussionStatus(state){
		var row = $('#listCmtsDiscussionForm').find('#listCmtsDiscussionTable').datagrid('getSelections');	
		if (row.length == 0) {
			alert('请选择一行数据进行操作！');
			return false;
		}else {
			var idsData = formParamSerizlize($('#listCmtsDiscussionForm :checkbox[name=id]:checked')); 
			easyui_modal_open('updateStatusDiv', '置顶研说', 600, 350, '${ctx}/manage/nts/status/goUpdateStatus?state='+state+'&relation.type=discussion&formId=listCmtsDiscussionForm&id='+idsData, true);
		}
	}
	
	function updateCmtsDiscussionStatus(state, days){
		var msg = '';
		if(state == 'essence'){
			if(days != 0){
				msg = '确定将选中的研说设置为精华研说吗?'
			}else{
				msg = '确定要取消选中研说的精华设置吗?'
			}
		}else if(state == 'top'){
			if(days != 0){
				msg = '确定将选中的研说置顶吗?'
			}else{
				msg = '确定要将选中的研说取消置顶吗?'
			}
		}else if(state == 'refuse'){
			if(days != 0){
				msg = '确定驳回所选研说的审核吗?'
			}else{
				msg = '确定要通过所选研说的审核吗?'
			}
		}
		
		var row = $('#listCmtsDiscussionForm').find('#listCmtsDiscussionTable').datagrid('getSelections');
		if (row.length == 0) {
			alert('请选择一行数据进行操作！');
			return false;
		}else {
			confirm(msg,function(r){
			   if(r){
				   var relationId = '';
				   $(row).each(function(){
					   if(state == 'essence'){
					        if(days != 0){
								msg = '确定将选中的研说设置为精华研说吗?'
								if(this.status_essence.indexOf('精华') < 0){
									relationId = relationId + this.id + ',';
								}
							}else{
								msg = '确定要取消选中研说的精华设置吗?'
								if(this.status_essence.indexOf('精华') >= 0){
									relationId = relationId + this.id + ',';
								}
							}
					   }else{
						   relationId = relationId + this.id + ',';
					   }
				   });
				   if(relationId.length > 0){
					   relationId = relationId.substring(0, relationId.length - 1);
					   $.put("${ctx}/manage/status", 'relation.id='+relationId+'&relation.type=discussion&state='+state+'&days='+days, function(){
						   easyui_tabs_update('listCmtsDiscussionForm','layout_center_tabs');
					   });
				   }else{
					   easyui_tabs_update('listCmtsDiscussionForm','layout_center_tabs');
				   }
			   }    
			}); 
		} 
	}
	
	function previewDiscussion(id){
		window.open('${PropertiesLoader.get("cmts.domain")}cmts/discussion/'+id+'/view');
	}
</script>

