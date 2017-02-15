<#assign relationId='cmts'>
<#assign relationType='lesson'>
<form id="listCmtsLessonForm" action="${ctx}/manage/nts/cmts/lesson"  method ="get">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
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
	                        <select id="statusSelect" name="state">
								<option value="">请选择...</option>
								<option value="in_progress">进行中</option>
								<option value="unselected">未晋选</option>
								<option value="auditing">已晋选</option>
								<option value="passed">已通过</option>
								<option value="no_pass">未达标</option>
								<option value="start_lesson">已开课</option>
	                        </select>    
	                        <script>
	                        	$(function(){
	    				        	$('#listCmtsLessonForm #stateSelect option[value="${(discussion.state)!""}"]').prop('selected', true);
	                        	});
	                        </script>
	                    </div>
	                </div>
	            </div>
	        </li>
	    </ul>
	    <div class="mis-btn-row indent1">
	        <button onclick="easyui_tabs_update('listCmtsLessonForm','layout_center_tabs');" type="button" class="mis-btn mis-main-btn"><i class="mis-srh-ico"></i>查询</button>
			<a onclick="resetForm(this)"  class="mis-btn mis-default-btn">
				<i class="mis-refresh-ico"></i>重置
			</a>
	    </div>
	</div>
	<div class="mis-table-layout">
	    <div class="mis-opt-row">
	        <div class="mis-opt-mod fl">
	            <button onclick="addCmtsLesson()" type="button" class="mis-btn mis-inverse-btn"><i class="mis-add-ico"></i>新建</button>
	            <button onclick="editCmtsLesson()" type="button" class="mis-btn mis-inverse-btn"><i class="mis-alter-ico"></i>修改</button>
	            <button onclick="deleteCmtsLesson()" type="button" class="mis-btn mis-inverse-btn"><i class="mis-delete-ico"></i>删除</button>
	            <!-- <button onclick="updateCmtsLessonStatus('refuse', 0)" type="button" class="mis-btn mis-inverse-btn" ><i class="mis-pass-ico"></i>审核通过</button> -->
	            <button onclick="updateCmtsLessonStatus('refuse', -1)" type="button" class="mis-btn mis-inverse-btn" ><i class="mis-unpass-ico"></i>审核不通过</button>
	            <button onclick="goUpdateCmtsLessonStatus('top')" type="button" class="mis-btn mis-inverse-btn" ><i class="mis-top-ico"></i>置顶</button>
	            <button onclick="updateCmtsLessonStatus('top', 0)" type="button" class="mis-btn mis-inverse-btn" ><i class="mis-untop-ico"></i>取消置顶</button>
	            <button onclick="goAuditLesson()" type="button" class="mis-btn mis-inverse-btn" ><i class="mis-authorization-ico"></i>专家评审</button>
	            <button onclick="goCreateMessage()" type="button" class="mis-btn mis-inverse-btn" ><i class="mis-authorization-ico"></i>开课并发送观摩通知</button>
	        </div>
	    </div>
		<div class="mis-table-mod">
	        <table id="listCmtsLessonTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
	            <thead>
	                <tr>
	                    <th width="50px" data-options="field:'id',checkbox:true">选项</th>
						<th data-options="field:'title'">标题</th>
						<th data-options="field:'realName'">作者</th>
						<th data-options="field:'deptName'">所在单位</th>
						<th data-options="field:'createTime'">创建时间</th>
						<th data-options="field:'supportNum'">点赞数</th>
						<th data-options="field:'followNum'">观摩意向</th>
						<th data-options="field:'staus_refuse'">审核情况</th>
						<th data-options="field:'state'">状态</th>
						<th data-options="field:'topDays'">置顶天数</th>
	                </tr>
	            </thead>
	            <tbody>
	                <@discussionsDirective title=(discussion.title)!'' statusNeq='refuse' getStatus=true state=(discussion.state)!'' deptName=(discussion.creator.deptName)!'' realName=(discussion.creator.realName)!'' relationId=relationId relationType=relationType page=(pageBounds.page)!1 limit=(pageBounds.limit)!10 orders='CREATE_TIME.DESC' >
						<#list discussions as discussion>
							<tr>
								<td>${discussion.id}</td>
								<td><a href="###" onclick="previewLesson('${discussion.id}')">${(discussion.title)!}</a></td>
								<td>${(discussion.creator.realName)!}</td>
								<td>${(discussion.creator.deptName)!}</td>
								<td>${TimeUtils.formatDate(discussion.createTime, 'yyyy-MM-dd')}</td>
								<td>${(discussion.discussionRelations[0].supportNum)!0}</td>
								<td>${(discussion.discussionRelations[0].followNum)!0 }</td>
								<td>
									<#if 0 != (statusMap[discussion.id].refuse.days)!0 >
										未达标
									<#else>	
										已通过
									</#if>
								</td>
								<td>
									<#if 'in_progress' == (discussion.state)!''>
										进行中
									<#elseif 'unselected' == (discussion.state)!''>
										未晋选
									<#elseif 'auditing' == (discussion.state)!''>
										已晋选
									<#elseif 'passed' == (discussion.state)!''>
										已通过
									<#elseif 'no_pass' == (discussion.state)!''>
										未达标
									<#elseif 'start_lesson' == (discussion.state)!''>
										已开课
									</#if>
								</td>
								<td>${(statusMap[discussion.id].top.days)!'' }</td>
							</tr>
						</#list>
					</@discussionsDirective>
	            </tbody>
	            <tfoot>
	                <tr>
	                    <td colspan="10">
	                    	 <#if paginator??>
						    	<#import "/nts/include/pagination.ftl" as p/>
						    	<@p.pagination paginator=paginator formId="listCmtsLessonForm" divId="content"/>
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
		$('#listCmtsLessonTable').datagrid();
	});
	
	function addCmtsLesson(relationId) {
		var url = '${ctx}/manage/nts/cmts/lesson/create?discussionRelations[0].relation.id=${relationId}&discussionRelations[0].relation.type=${relationType}';
		easyui_modal_open('editCmtsLessonDiv', '新建创课', 800, 700, url, true);
	}

	function editCmtsLesson() {
		var row = $('#listCmtsLessonForm').find('#listCmtsLessonTable').datagrid('getSelections');	
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时编辑多条数据', 'warning');
			return false;
		}else {
			var id = row[0].id;
			easyui_modal_open('editCmtsLessonDiv', '编辑创课', 800, 700, '${ctx}/manage/nts/cmts/lesson/'+id+'/edit', true);
		}
	}
	
	function deleteCmtsLesson(){
		var row = $('#listCmtsLessonForm').find('#listCmtsLessonTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else {
			$.messager.confirm('确认','确认要删除选中记录吗？',function(r){
			   if(r){
				   $.ajaxDelete("${ctx}/manage/discussion", $('#listCmtsLessonForm').serialize(), function(response){
				   		if(response.responseCode == '00'){
				   			easyui_tabs_update('listCmtsLessonForm','layout_center_tabs')
				   		}
				   });
			   }    
			}); 
		} 
	}
	
	function goUpdateCmtsLessonStatus(state){
		var row = $('#listCmtsLessonForm').find('#listCmtsLessonTable').datagrid('getSelections');	
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else {
			var idsData = formParamSerizlize($('#listCmtsLessonForm :checkbox[name=id]:checked')); 
			easyui_modal_open('updateStatusDiv', '置顶创课', 600, 350, '${ctx}/manage/nts/status/goUpdateStatus?state='+state+'&relation.type=discussion&formId=listCmtsLessonForm&id='+idsData, true);
		}
	}
	
	function updateCmtsLessonStatus(state, days){
		var msg = '';
		if(state == 'essence'){
			if(days != 0){
				msg = '确定将选中的创课设置为精华创课吗?'
			}else{
				msg = '确定要取消选中创课的精华设置吗?'
			}
		}
		
		var row = $('#listCmtsLessonForm').find('#listCmtsLessonTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else {
			$.messager.confirm('确认',msg,function(r){
			   if(r){
				   var relaitonId = '';
				   $('#listCmtsLessonForm input[name="id"]:checked').each(function(i){
					   relaitonId += $(this).val();
					   if(i != $('#listCmtsLessonForm input[name="id"]:checked').length - 1){
						   relaitonId += ',';
					   }
				   });
				   $.put("${ctx}/manage/status", 'relation.id='+relaitonId+'&relation.type=discussion&state='+state+'&days='+days, function(response){
				   		if(response.responseCode == '00'){
				   			easyui_tabs_update('listCmtsLessonForm','layout_center_tabs')
				   		}
				   });
			   }    
			}); 
		} 
	}
	
	function updateCmtsLessonStatus(state, days){
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
		
		var row = $('#listCmtsLessonForm').find('#listCmtsLessonTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else {
			$.messager.confirm('确认',msg,function(r){
			   if(r){
				   var relationId = '';
				   $(row).each(function(){
				       relationId = relationId + this.id + ',';
				   });
				   if(relationId.length > 0){
					   relationId = relationId.substring(0, relationId.length - 1);
					   $.put("${ctx}/manage/status", 'relation.id='+relationId+'&relation.type=discussion&state='+state+'&days='+days, function(){
						   easyui_tabs_update('listCmtsLessonForm','layout_center_tabs');
					   });
				   }else{
					   easyui_tabs_update('listCmtsLessonForm','layout_center_tabs');
				   }
			   }    
			}); 
		} 
	}
	
	function goAuditLesson(){
		var row = $('#listCmtsLessonForm').find('#listCmtsLessonTable').datagrid('getSelections');	
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else {
			var row = $('#listCmtsLessonForm').find('#listCmtsLessonTable').datagrid('getSelections');
			var isReturn = false;
			$(row).each(function(){
				var state = this.state.trim();
				if(state == '进行中' || state == '未晋选' || state == '已开课'){
					isReturn = true;
					return false;
				}
			});
			if(isReturn){
				alert('还未晋选或者已开课的创课不能进行专家评审, 请重新勾选', null, 2500);
				return false;
			}
			$('#listCmtsLessonForm input[name=state]').remove();
			easyui_modal_open('auditLessonDiv', '专家评审', 600, 350, '${ctx}/manage/nts/cmts/lesson/goAuditLesson?'+$('#listCmtsLessonForm').serialize(), true);
		}
	}
	
	function goCreateMessage(){
		var row = $('#listCmtsLessonForm').find('#listCmtsLessonTable').datagrid('getSelections');	
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时编辑多条数据', 'warning');
			return false;
		}else {
			var state = row[0].state.trim();
			if(state != '已通过' && state != '已开课' ){
				alert('未通过专家评审的创课无法开课, 请重新勾选', null, 2500);
				return false;
			}
			var id = row[0].id;
			var title = row[0].title;
			easyui_modal_open('createMessageDiv', '发送观摩通知', 600, 350, '${ctx}/manage/nts/cmts/lesson/goCreateMessage?id='+id+'&title='+title, true);
		}
	}
	
	function previewLesson(id){
		window.open('${PropertiesLoader.get("cmts.domain")}cmts/lesson/'+id+'/view');
	}
	
</script>

