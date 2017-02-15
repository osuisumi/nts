<#global app_path=PropertiesLoader.get('app.nts.path') >
<form id="saveAccountForm" action="${ctx!}/manage/accounts" method="post">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<input id="ctx" type="hidden" name="ctx" value="${ctx!}">
	<#if (account.id)??>
		<input id="id" type="hidden" name="id" value="${(account.id)!}">
		<input id="userid" type="hidden" name="user.id" value="${(account.user.id)!}">
		<script>
			$('#saveAccountForm').attr('action', '${ctx!}/manage/accounts');
			$('#saveAccountForm').attr('method', 'put');
		</script>
	<#else>
		<input type="hidden" name="roleCode" value="2">
	</#if>
	<div class="mis-srh-layout">
    	<ul class="mis-ipt-lst">
	    	<li class="item">
				<div class="mis-ipt-row">
	                <div class="tl">
	                    <span>用户名：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="text" id="userName" name="userName" value="${(account.userName)!}" placeholder="请输入用户名..." class="mis-ipt required">
	                    </div>
	                </div>
	            </div>
			</li>
	        <li class="item">
                <div class="mis-ipt-row">
                    <div class="tl">
                        <span>姓名：</span>
                    </div>
                    <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="text" name="user.realName" value="${(account.user.realName)!}" placeholder="请输入姓名..." class="mis-ipt required">
	                    </div>
	                </div>
                </div>
            </li>
			<#if (account.id)??>
			<#else>
			<li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>密码：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="password" id="password" name="password" placeholder="请输入密码..." class="mis-ipt required">
	                    </div>
	                </div>
	            </div>
	        </li>
	        <li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>密码确认：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="password" name="repassword" placeholder="请输入密码..." class="mis-ipt required">
	                    </div>
	                </div>
	            </div>
	        </li>
	        </#if>
	        <li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>所在单位：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-select">
	                        <select name="user.department.id">
	                        	<@departmentsDirective>
									<#list departments as department>
										<option value="${(department.id)!}" <#if (account.user.department.id)! = (department.id)! >selected="selected"</#if> >${(department.deptName)!}</option>  
									</#list>
								</@departmentsDirective>
	                        </select>    
	                    </div>
	                </div>
	            </div>
	        </li>
	        <li class="item">
                <div class="mis-ipt-row">
                    <div class="tl">
						<#if app_path = '/nts/lego'>
							 <span>手机号：</span>
						<#else>
							 <span>身份证号：</span>
						</#if>
                    </div>
                    <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="text" id="paperworkNo" name="user.paperworkNo" value="${(account.user.paperworkNo)!}" placeholder="请输入身份证号" class="mis-ipt required">
	                    </div>
	                </div>
                </div>
            </li>
		</ul>
	</div>
	<div class="mis-btn-row indent1">
        <button onclick="saveAccount()" type="button" class="mis-btn mis-main-btn"><i class="mis-save-ico"></i>保存</button>
    </div>
</form>
<script type="text/javascript">

	$(function(){
		$('#saveAccountForm').validate({
			rules : {
				userName : {
					required : true,
					remote : {
						url :  $('#ctx').val() + '/manage/accounts/countForValidUserNameIsExist?id=${(account.id)!""}', 
	                    type : "get", 
	                    dataType : "text",
						data :  {
							userName : function() {   
			                    return $("#userName").val();   
			                }
						},
						dataFilter : function (result,type) {
							return parseInt(result) > 0 ? false : true;
						} 
					}
				},
				'user.paperworkNo':{
					required : true,
					remote : {
						url :  $('#ctx').val() + '/manage/users/countForValidpaperworkNoIsExist?id=${(account.user.id)!""}', 
	                    type : "get", 
	                    dataType : "text",
						data :  {
							paperworkNo : function() {   
			                    return $("#paperworkNo").val();   
			                }
						},
						dataFilter : function (result,type) {
							return parseInt(result) > 0 ? false : true;
						} 
					}
				},
				repassword : {
					required: true,
			        minlength: 6,
			        equalTo: "#password"
				}
			},
			messages : {
				userName : {
					required : '必填',
					remote : '用户名已存在'
				},
				repassword : {
					required : '必填',
					equalTo: "两次密码输入不一致"
				},
				'user.paperworkNo':{
					required:'必填',
					remote:'号码已存在'
				}
			}
		});
	});
	
	function saveAccount() {
		if(!$('#saveAccountForm').validate().form()){
			return false;
		}
		var data = $.ajaxSubmit('saveAccountForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			$.messager.alert("提示信息", "操作成功！", 'info', function() {
				easyui_tabs_update('listAccountForm', 'layout_center_tabs');
				easyui_modal_close('editAccountDiv');
			});
		}
	}
</script>