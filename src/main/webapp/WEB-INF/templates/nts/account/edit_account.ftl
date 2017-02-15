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
                        <span>姓名：</span>
                    </div>
                    <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="text" name="user.realName" value="${(account.user.realName)!}" placeholder="请输入姓名..." class="mis-ipt required">
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