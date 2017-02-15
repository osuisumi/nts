<form id="saveWorkshopUserForm" action="${ctx}/manage/workshopUser" method="post">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	
	<#if '' != (workshopUser.id)!''>
		<script>
			$('#saveWorkshopUserForm').attr('method','put').attr('action', '${ctx }/manage/workshopUser/${(workshopUser.id)!}');
		</script>
		<input type="hidden" name="id" value="${workshopUser.id}"/>
	<#else>
		<input type="hidden" name="id" value="${(workshopUser.workshopId)!}"/>
	</#if>
	
	<span id="param">
		
	</span>
	
	<div class="mis-srh-layout">
    	<ul class="mis-ipt-lst">
    		<#if !((workshopUser.id)??)>
			<li class="item w1">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>姓名：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-add-tag f-cb">
	                        <div class="mis-tagipt mis-ipt-mod">
	                          <input type="text" id="workshopUserName">
	                        </div>
	                        <ul id="userList" class="mis-tag-lst">
	                        </ul>
	                    </div>
	                </div>
	            </div>
	        </li>
	        </#if>
	        <li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>角色：</span>
	                </div>
	                <div class="tc">
                        <div class="mis-select">
                        	<#assign role=(workshopUser.role)!''>
                            <select id="roleSelect" name="role">
								<option <#if role='' || role='master'>selected="selected"</#if> value="master" >坊主</option> 
								<option <#if role='member'>selected="selected"</#if> value="member" >管理成员</option> 
								<option <#if role='student'>selected="selected"</#if> value="student" >学员</option>   
                            </select>
                        </div>
	                </div>
	            </div>
	        </li>
		</ul>
		<div class="mis-btn-row indent1">
            <button onclick="saveWorkshopUser()" type="button" class="mis-btn mis-main-btn"><i class="mis-save-ico"></i>保存</button>
        </div>
	</div>
</form>
<script type="text/javascript">
	$(function(){
		var ul = $('#userList');
		$('#workshopUserName').userSelect({
			url:'${ctx}/user/entities',
			userList:ul,
			paramName:'paramMap[realName]',
			afterInit:function(selectDiv){
				selectDiv.find('input').attr('class','mis-ipt u-pbIpt').removeAttr('style').css('width','300px');
				selectDiv.find('.u-add-tag').css('cursor','pointer').addClass('mis-btn mis-main-btn mis-add-tag').removeAttr('style');
			},
			onBeforeSelect:function(value){
				var isAllow = false;
				$.ajax({
					type:'GET',
					url:'${ctx}/manage/workshopUser/isAllow?userId='+value+'&workshopId=${workshopUser.workshopId}',
					async:false,
					success:function(response){
						if(response.responseCode == '00'){
							isAllow = true;
						}else{
							alert(response.responseMsg);
						}
					},
				});
				return isAllow;	
			},
		});
		
	});



	function saveWorkshopUser() {
		if(!$('#saveWorkshopUserForm').validate().form()){
			return false;
		}
		
		<#if !((workshopUser.id)??)>
		if($('#userList li').size()<=0){
			alert('请选择一个用户');
			return;
		};
		
		initParam();
		</#if>
		
		var data = $.ajaxSubmit('saveWorkshopUserForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			$.messager.alert("提示信息", "操作成功！", 'info', function() {
				easyui_window_update('listWorkshopUserForm','listWorkshopUserDiv');
				easyui_modal_close('editWorkshopDiv');
			});
		}
	};
	
	function initParam(){
		var param = $('#param');
		param.empty();
		var role = $('#roleSelect').val();
		$.each($('#userList a'),function(i,n){
			param.append('<input type="hidden" name="workshopUsers['+i+'].user.id" value="'+$(n).attr('uid')+'">');
			param.append('<input type="hidden" name="workshopUsers['+i+'].role" value="'+role+'">');
			param.append('<input type="hidden" name="workshopUsers['+i+'].state" value="passed">');
			
		});
	}
	
	
</script>