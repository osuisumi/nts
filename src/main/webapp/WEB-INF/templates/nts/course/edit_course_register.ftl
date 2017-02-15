<style>
dl{margin: 10px 0 0 10px; }
dt{font-weight: bold; line-height: 40px;}
dd{line-height: 40px; }
.btn-block{position: relative; z-index: 11;}
.btn-block:hover a {display: inline-block;}
.btn-block a {display: none; text-align: center; line-height: 14px; }
</style>
<form id="saveCourseRegisterForm" action="${ctx}/manage/courseRegister/updateCourseCourseRegister" method="post">
<input type="hidden" name="userIds" id="userIds">
<input type="hidden" name="course.id" value="${courseId!}">
<input type="hidden" name="relation.id" value="${trainId!}">
<input type="hidden" name="state" value="pass">
<input type="hidden" name="type" value="trainCourseRegister">
	<div>
	    <div class="easyui-panel">
     	 	<div style="margin: 10px 0 10px 10px">
				<span>请选择制课程:&nbsp;</span>
				<select  id="courseSelectWin" style="width: 200px;">
				</select>
			</div>
	        <div style="border-right: 1px solid #d5d5d5; width: 48%; float: left; height: 80%">
	        	<@courseRegisterUsers trainId="${trainId!}">
	        		<dl id="allUserList">
		                <dt>全部成员</dt>
		                <#list users as user>
		                	<dd class="btn-block" userId="${user.id }">
			                	<em>${user.realName }</em>
			                	<a type="button" class="easyui-linkbutton">
									<i class="fa fa-plus"></i> 添加
								</a>
			                </dd>
		                </#list>
		            </dl>
	        	</@courseRegisterUsers>
	        </div>
	        <div style="border-left: 1px solid #d5d5d5; width: 48%; float: left; height: 80%">
	            <dl id="registerList">
	            <dt>已选课成员</dt>
	            <#if (courseRegisterExtend.course.id)??>
		            <@courseRegisters courseRegisterExtend=(courseRegisterExtend)!>
		            	<#if courseRegisters??>
		            		<#list courseRegisters as crt>
		            		    <dd id="registerTemplate" userId="${(crt.tsUser.id)!}" class="btn-block">
									<em>${(crt.tsUser.realName)!}</em>
									<a type="button" class="easyui-linkbutton">
										<i class="fa fa-times"></i> 删除
									</a>
								</dd>
		            		</#list>
		            	</#if>
					</@courseRegisters>
	            </#if>
	            </dl>
	        </div>
	        <div style="clear: both;"></div>
	    </div>
	</div>
	<div style="text-align: center; margin-top: 20px;">
		<button type="button" onclick="saveCourseRegister()" class="easyui-linkbutton">
			<i class="fa fa-floppy-o"></i> 保 存
		</button>
	</div>
	
</form>
<dd id="allUserTemplate" class="btn-block" style="display: none;">
	<em></em>
    <a type="button" class="easyui-linkbutton">
		<i class="fa fa-plus"></i> 添加
	</a>
</dd>
<dd id="registerTemplate" class="btn-block" style="display: none;">
	<em></em>
	<a type="button" class="easyui-linkbutton">
		<i class="fa fa-times"></i> 删除
	</a>
</dd>
<script type="text/javascript">
	$(function(){
		$('#allUserList dd').each(function(){
			var $this = $(this);
			var userId = $this.attr('userId');
			$('#registerList dd').each(function(){
				var userId1 = $(this).attr('userId');
				if(userId == userId1){
					$this.remove();
					return;
				}
			});
		});
		
		$('#saveCourseRegisterForm').on('click', '#allUserList a', function(){
			var $remove_dd = $(this).parents('dd');
			var userId = $remove_dd.attr('userId');
			var title = $remove_dd.find('em').text();
			$remove_dd.remove();
			var $add_dd = $('#registerTemplate').clone();
			$add_dd.find('em').text(title);
			$('#registerList').append($add_dd.css('display', 'block').removeAttr('id').attr('userId', userId));
		});
		
		$('#saveCourseRegisterForm').on('click', '#registerList a', function(){
			var $remove_dd = $(this).parents('dd');
			var userId = $remove_dd.attr('userId');
			var title = $remove_dd.find('em').text();
			$remove_dd.remove();
			var $add_dd = $('#allUserTemplate').clone();
			$add_dd.find('em').text(title);
			$('#allUserList').append($add_dd.css('display', 'block').removeAttr('id').attr('userId', userId));
		});
	});
	
	
	function saveCourseRegister(){
		var prepareUpdateCourseIds = '';
		$('#registerList dd').each(function(i){
			var userId = $(this).attr('userId');
			if(prepareUpdateCourseIds == ''){
				prepareUpdateCourseIds = userId;
			}else{
				prepareUpdateCourseIds  = prepareUpdateCourseIds + ',' + userId;
			}
		});
		$('#userIds').val(prepareUpdateCourseIds);
		var data = $.ajaxSubmit('saveCourseRegisterForm');
		var json = $.parseJSON(data);
		if(json.responseCode == '00'){
			alert('提交成功');
		}
	}
	
	function changeCourse(node){
		var courseId = node.id;
		var parentNode = $('#courseSelectWin').combotree('tree').tree('getParent',node.target);
		$('#editCourseRegisterDiv').window('refresh', '${ctx}/manage/courseRegister/create?courseId='+courseId+'&trainId='+parentNode.id);
	}
	
	/*顶部combobox*/
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
			$.get('${ctx}/manage/train/api/trainCourses',{
				"trainIds":trainIds
			},function(courses){
				$.each(courses,function(i,n){
					var node = {id:n.course.id,name:n.course.title,pid:n.trainId,type:'c'};
					treeNodes.push(node);
				});
				$('#courseSelectWin').combotree({
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
							$('#courseSelectWin').combo('setValue',rec.id);
							$('#courseSelectWin').combo('setText',rec.name);
							changeCourse(rec);
						}else{
							alert('请选择想要操作的课程');
							$('#courseSelectWin').combo('setValue','');
						}
					},
					onLoadSuccess:function(){
						var selectId = '${(courseRegisterExtend.course.id)!}';
						if(selectId){
							var node = $('#courseSelectWin').combotree('tree').tree('find',selectId);
								if(node){
									$('#courseSelectWin').combo('setValue',node.id);
									$('#courseSelectWin').combo('setText',node.name);
								}
						}
					}
				});
			});
		}
	})
	
</script>